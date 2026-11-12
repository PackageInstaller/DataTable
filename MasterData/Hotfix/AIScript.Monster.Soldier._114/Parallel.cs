using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._114;

public class Parallel : AIBase
{
	private readonly HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.BaiMaoJuTuan;

	private static readonly int damageTag_MainSkill = CommonHelper.StringToHash("114_MainSkill_Hit");

	private static readonly int damageTag_Normal = CommonHelper.StringToHash("114_Normal_Hit");

	private readonly List<int> buffId_DarkMark = new List<int> { 250105503, 250105504, 250105505 };

	private const int hitId_DarkMark = 1000114005;

	private readonly List<string> fxPath = new List<string> { "fx_11401_base_Skill_Main_3_Short_Bombing_P04_Strengthen_Lv1", "fx_11401_base_Skill_Main_3_Short_Bombing_P04_Strengthen_Lv2", "fx_11401_base_Skill_Main_3_Short_Bombing_P04_Strengthen_Lv3" };

	private const int maxTriggerPerWindow = 2;

	private static readonly FP windowDuration = 1;

	private static readonly FP hitDelay = 0.5f;

	private int bounceCount = 3;

	private int bombCount = 2;

	private FP searchRange = 7.5;

	private FP reboundRange = 5;

	private string bullet_First = "Bullet_Soldier_114_Support";

	private string bullet_Bounce = "Bullet_Soldier_114_Support_Bounce";

	private List<TSVector2> shootOffsets_XZ = new List<TSVector2>
	{
		new TSVector2(0.7, -1),
		new TSVector2(-0.7, -1)
	};

	private List<FP> shootOffsets_Y = new List<FP> { 1.5, 1.5 };

	private string fxKey_DotShoot = "fx_11401_base_Skill_Main_2_td";

	private bool _aborted;

	private readonly Dictionary<long, List<FP>> _triggerTimesByTarget = new Dictionary<long, List<FP>>();

	private readonly List<long> _staleTargets = new List<long>();

	private int _potentialLv;

	private List<LogicEntity> entities = new List<LogicEntity>();

	private List<ReflectWeapon> reflectWeapons = new List<ReflectWeapon>();

	private List<CoroutineNode> corList = new List<CoroutineNode>();

	private long uidGen;

	private PlayFX playFX_hit = new PlayFX();

	public void OnEnable()
	{
		_aborted = false;
		_triggerTimesByTarget.Clear();
		_staleTargets.Clear();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		uidGen = 0L;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		_actor.AddEventListener("ACTOR_CUSTOM_EVENT", OnActorCustomEvent);
	}

	public void OnDisable()
	{
		_aborted = true;
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		_actor?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnActorCustomEvent);
		_triggerTimesByTarget.Clear();
		_staleTargets.Clear();
		entities.Clear();
		foreach (CoroutineNode cor in corList)
		{
			StopCoroutine(cor);
		}
		corList.Clear();
		for (int i = 0; i < reflectWeapons.Count; i++)
		{
			if (!reflectWeapons.get_Item(i).isFinished)
			{
				reflectWeapons.get_Item(i).Finish();
			}
		}
		reflectWeapons.Clear();
	}

	private void OnDamage(IEvent evt)
	{
		if (!_aborted && !(_actor == null) && buffId_DarkMark.Count > 0 && evt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent && !(adventureActorReceiveDamageEvent.from != _actor))
		{
			OnExpHit(adventureActorReceiveDamageEvent);
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, damageTag_MainSkill) && adventureActorReceiveDamageEvent.to is AdventureActor adventureActor && GetPartnerLv() >= 1)
			{
				adventureActor.buffComponent?.AddBuff(buffId_DarkMark.get_Item(_potentialLv - 1), _actor);
			}
		}
	}

	private void OnExpHit(AdventureActorReceiveDamageEvent settlementEvt)
	{
		if (CommonUtils.CheckHitByTag(settlementEvt.hitDamageTag, damageTag_Normal) && settlementEvt.to is AdventureActor adventureActor && !(adventureActor.buffComponent == null) && adventureActor.buffComponent.CheckBuffByBuffID(buffId_DarkMark.get_Item(_potentialLv - 1)) && GetPartnerLv() >= 1 && TryConsumeTriggerQuota(adventureActor.Id))
		{
			_actor.StartLogicCoroutine(DelayHit(adventureActor, adventureActor.Id));
		}
	}

	private IEnumerator DelayHit(AdventureActor target, long targetId)
	{
		playFX_hit.Play(_actor, target, fxPath.get_Item(_potentialLv - 1), target.tsTransform.Position, 0, TSVector2.zero);
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(hitDelay));
		if (!_aborted && !(_actor == null) && !(target == null) && target.Id == targetId && target.actorHealthInfo.isAlive)
		{
			ILRuntimeAPI.HitActor(_actor, target, 1000114005);
		}
	}

	private bool TryConsumeTriggerQuota(long targetId)
	{
		FP logicTime = _actor.LogicTime;
		FP fP = logicTime - windowDuration;
		_staleTargets.Clear();
		foreach (KeyValuePair<long, List<FP>> item in _triggerTimesByTarget)
		{
			List<FP> value = item.Value;
			for (int num = value.Count - 1; num >= 0; num--)
			{
				if (value.get_Item(num) < fP)
				{
					value.RemoveAt(num);
				}
			}
			if (value.Count == 0)
			{
				_staleTargets.Add(item.Key);
			}
		}
		for (int i = 0; i < _staleTargets.Count; i++)
		{
			_triggerTimesByTarget.Remove(_staleTargets.get_Item(i));
		}
		if (!_triggerTimesByTarget.TryGetValue(targetId, out var value2))
		{
			value2 = new List<FP>(2);
			_triggerTimesByTarget.Add(targetId, value2);
		}
		if (value2.Count >= 2)
		{
			return false;
		}
		value2.Add(logicTime);
		return true;
	}

	private int GetPartnerLv()
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return 0;
		}
		return soldierLevelController.GetPartnerLv(partnerType);
	}

	private void OnActorCustomEvent(IEvent evt)
	{
		if (!_aborted && !(_actor == null) && evt is AdventureActorCustomEvent adventureActorCustomEvent && !(adventureActorCustomEvent.eventName != "shoot2"))
		{
			CoroutineNode item = StartCoroutine(DotShoot());
			corList.Add(item);
		}
	}

	private IEnumerator DotShoot()
	{
		CommonUtils.SearchNearTargetsByCircleInTD(_actor, _actor.tsTransform.Position, searchRange, entities, isConfront: true);
		if (entities.Count > 0)
		{
			if (_actor.attackTarget != null && entities.Contains(_actor.attackTarget))
			{
				entities.Remove(_actor.attackTarget);
				entities.Insert(0, _actor.attackTarget);
			}
			for (int i = 0; i < bombCount; i++)
			{
				int index = i % entities.Count;
				ReflectWeapon reflectWeapon = new ReflectWeapon
				{
					uid = GenUid(),
					owner = _actor,
					reflectCount = bounceCount,
					reboundRange = reboundRange,
					firBullet = bullet_First,
					sedBullet = bullet_Bounce
				};
				TSVector2 shootPosXZ = _actor.tsTransform.TransformLocalPointToWorldSpace(shootOffsets_XZ.get_Item(i));
				FP shootPosY = shootOffsets_Y.get_Item(i);
				reflectWeapon.Shoot(entities.get_Item(index), shootPosXZ, shootPosY);
				reflectWeapons.Add(reflectWeapon);
			}
		}
		yield break;
	}

	private long GenUid()
	{
		uidGen++;
		return uidGen;
	}
}
