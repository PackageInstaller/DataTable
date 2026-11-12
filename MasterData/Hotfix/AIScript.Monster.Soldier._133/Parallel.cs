using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._133;

public class Parallel : AIBase
{
	private const string areaEffect_Potential = "AreaEffect";

	private static readonly int damageTag_MainSkill = CommonHelper.StringToHash("133_MainSkill_Bullet");

	public HotfixEnum.ChessPartnerType partnerTypes = HotfixEnum.ChessPartnerType.QiLiMoFa;

	private static readonly string[] bulletTag_main = new string[5] { "MainSkill_1", "MainSkill_2", "MainSkill_3", "MainSkill_4", "MainSkill_5" };

	private readonly FP bulletTag_Main_delay = 0.5;

	private static readonly string[] bulletMainPath_ex = new string[5] { "MagicPartner_Main_1", "MagicPartner_Main_2", "MagicPartner_Main_3", "MagicPartner_Main_4", "MagicPartner_Main_5" };

	private const string bulletTag_sup = "SupSkill";

	private readonly FP bulletTag_sup_delay = 0.5;

	private const string bulletSupPath_ex = "MagicPartner_Sup";

	private static readonly string areaTag_sup = "MagicPartner";

	private static readonly int[] onceDamageIds_exBulletByPartnerLv = new int[3] { 1, 1933663295, 1937007987 };

	private int PotentialLv = 1;

	private SoldierLevelController _levelCtrl;

	private bool _aborted;

	private bool _firingExtra;

	private readonly List<LogicEntity> _searchBuffer = new List<LogicEntity>();

	public void OnEnable()
	{
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
		_aborted = false;
		_firingExtra = false;
		_levelCtrl = ModuleController<AdventureModuleController>.Instance.levelInstance as SoldierLevelController;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
	}

	public void OnDisable()
	{
		_aborted = true;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_BORN", OnBulletBorn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("AREA_EFFECT_BEGIN", OnAreaEffectBegin);
		_searchBuffer.Clear();
		_levelCtrl = null;
	}

	private void OnDamage(IEvent evt)
	{
		if (evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && PotentialLv >= 2 && !(adventureActorReceiveDamageEvent.from != _actor) && adventureActorReceiveDamageEvent.isKill && CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_MainSkill) && adventureActorReceiveDamageEvent.to is AdventureActor adventureActor)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect", adventureActor.tsTransform.Position);
		}
	}

	private void OnBulletBorn(IEvent evt)
	{
		if (_aborted || _firingExtra || !(evt is AdventureBulletBornEvent adventureBulletBornEvent) || adventureBulletBornEvent.owner == null || _actor == null || adventureBulletBornEvent.owner.Id != _actor.Id || _levelCtrl == null || _levelCtrl.GetPartnerLv(partnerTypes) < 1)
		{
			return;
		}
		int num = IndexOfMainTag(adventureBulletBornEvent.tag);
		if (num >= 0)
		{
			if (num < bulletMainPath_ex.Length)
			{
				StartCoroutine(DelayShootExtraBullet(bulletMainPath_ex[num], bulletTag_Main_delay, preferOtherTarget: false));
			}
		}
		else if (!string.IsNullOrEmpty("SupSkill") && adventureBulletBornEvent.tag == "SupSkill")
		{
			StartCoroutine(DelayShootExtraBullet("MagicPartner_Sup", bulletTag_sup_delay, preferOtherTarget: true));
		}
	}

	private void OnAreaEffectBegin(IEvent evt)
	{
		if (!_aborted && evt is AdventureAreaEffectBeginEvent adventureAreaEffectBeginEvent && !(adventureAreaEffectBeginEvent.owner == null) && !(_actor == null) && adventureAreaEffectBeginEvent.owner.Id == _actor.Id && !(_levelCtrl == null) && _levelCtrl.GetPartnerLv(partnerTypes) >= 1 && !string.IsNullOrEmpty(areaTag_sup) && adventureAreaEffectBeginEvent.sender is AreaEffectEntity areaEffectEntity && areaEffectEntity.CheckChildTag(areaTag_sup))
		{
			areaEffectEntity.AddAdditionalAttr(GetPartnerLvOnceDamageId());
		}
	}

	private static int IndexOfMainTag(string tag)
	{
		for (int i = 0; i < bulletTag_main.Length; i++)
		{
			if (!string.IsNullOrEmpty(bulletTag_main[i]) && bulletTag_main[i] == tag)
			{
				return i;
			}
		}
		return -1;
	}

	private IEnumerator DelayShootExtraBullet(string bulletPath, FP delay, bool preferOtherTarget)
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(delay));
		if (!_aborted && !string.IsNullOrEmpty(bulletPath) && !(_actor == null) && !_actor.IsDead())
		{
			LogicEntity logicEntity = null;
			if (preferOtherTarget)
			{
				logicEntity = FindOtherConfrontTarget();
			}
			if (logicEntity == null && _actor.attackTarget != null && !_actor.attackTarget.IsDead())
			{
				logicEntity = _actor.attackTarget;
			}
			ShootExtraBullet(bulletPath, logicEntity, !preferOtherTarget);
		}
	}

	private void ShootExtraBullet(string bulletPath, LogicEntity target, bool fixOnce)
	{
		_firingExtra = true;
		try
		{
			AdventureBulletBase bullet;
			if (target != null)
			{
				TSVector2 position = _actor.tsTransform.TransformLocalPointToWorldSpace(new TSVector2(0, 1.5f));
				bullet = ILRuntimeAPI.Shoot(bulletPath, _actor, 0, position, 1.8, default, target, AimType.Target, BulletDirectionType.BulletToTarget);
			}
			else
			{
				bullet = ILRuntimeAPI.ShootByDirection(bulletPath, _actor, default, _actor.tsTransform.Forward, _actor.tsTransform.Position);
			}
			if (fixOnce)
			{
				ApplyPartnerLvOnceDamage(bullet);
			}
		}
		finally
		{
			_firingExtra = false;
		}
	}

	private void ApplyPartnerLvOnceDamage(AdventureBulletBase bullet)
	{
		if (!(bullet == null))
		{
			bullet.AddAdditionalAttr(GetPartnerLvOnceDamageId());
		}
	}

	private int GetPartnerLvOnceDamageId()
	{
		if (_levelCtrl == null)
		{
			return 0;
		}
		int num = _levelCtrl.GetPartnerLv(partnerTypes);
		if (num < 1)
		{
			return 0;
		}
		if (num > onceDamageIds_exBulletByPartnerLv.Length)
		{
			num = onceDamageIds_exBulletByPartnerLv.Length;
		}
		return onceDamageIds_exBulletByPartnerLv[num - 1];
	}

	private AdventureActor FindOtherConfrontTarget()
	{
		_searchBuffer.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, _actor.actorSearchTargetInfo.monsterSearchRange, isConfront: true, includeSelf: false, _searchBuffer);
		LogicEntity attackTarget = _actor.attackTarget;
		for (int i = 0; i < _searchBuffer.Count; i++)
		{
			if (_searchBuffer.get_Item(i) is AdventureActor adventureActor && (!(attackTarget != null) || adventureActor.Id != attackTarget.Id))
			{
				ActorHealthInfo actorHealthInfo = adventureActor.actorHealthInfo;
				if (actorHealthInfo != null && actorHealthInfo.isAlive && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
				{
					return adventureActor;
				}
			}
		}
		return null;
	}
}
