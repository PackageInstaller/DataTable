using System.Collections;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14701;

public class ParallelScript_MainControl : ParallelScript
{
	private int summonId = 14700011;

	private int summonInherit = 100;

	private FP summonLeftTime = 15;

	private FP linkDistanceIn = 6;

	private FP linkDistanceOut = 9;

	private string linkFx = "fx_14701_loop_SoundLine_Nrm";

	private string weaklinkFx = "fx_14701_loop_SoundLine_Red";

	private int buffId_link = 14790001;

	private const int perkId_2 = 514702;

	private int buff_2 = 14702011;

	private const int perkId_3 = 514703;

	private string areaEffect_3 = "AreaEffect_147_P3_AOE";

	private const int perkId_4 = 514704;

	private string areaEffect_4 = "AreaEffect_147_P3P4_AOE";

	private const int perkId_6 = 514706;

	private int buff_6 = 14706011;

	private const int perkId_7 = 514707;

	private int buff_7 = 14707011;

	private const int perkId_8 = 514708;

	private string areaEffect_8 = "AreaEffect_147_Ultra_AOE_1_P8";

	private string areaEffect_8_2 = "AreaEffect_147_Ultra_AOE_2_P8";

	private const int perkId_9 = 514709;

	private int buff_9 = 14709011;

	private const int perkId_10 = 514710;

	private int buff_10 = 14710011;

	private const int perkId_12 = 514712;

	private FP interval_12 = 0.5;

	private FP width_12 = 2;

	private string linkFx_12 = "fx_14701_loop_SoundLine_Hit";

	private string weaklinkFx_12 = "fx_14701_loop_SoundLine_Hit_Red";

	private CommomAreaHitConfig hitCfg_12 = new CommomAreaHitConfig
	{
		hitDamageId = 147300005,
		hitFlags = HitBox.FeatureFlag.None,
		hitFeatureData = new HitBox.HitBoxFeatureData(),
		hittedEffectAlias = "fx_14701_hit_YinBo",
		hurtAnimType = HitBox.HurtAnimType.None
	};

	private const int perkId_13 = 514713;

	private int buff_13 = 14713011;

	private SummonCfg summonCfg = new SummonCfg();

	private MonsterAdventureActor summonMonster;

	private CoroutineNode corLinkFx;

	private CoroutineNode corCastAreaEffect;

	private CoroutineNode corHitActor;

	private PlayFX playFX = new PlayFX();

	private PlayFX playFX_Weak = new PlayFX();

	private bool isInLink;

	private bool isInWeakLink;

	private bool isInStrongLink;

	private int castUltra = CommonHelper.StringToHash("CastUltra");

	private int castUltra2 = CommonHelper.StringToHash("CastUltra2");

	private int summonEvt = CommonHelper.StringToHash("summonEvt");

	private int castAreaEvt = CommonHelper.StringToHash("castAreaEvt");

	public override void OnEnable()
	{
		base.OnEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		summonCfg.summonFollowType = SummonFollowType.NotFollow;
		summonCfg.summonAttrType = SummonAttrType.InheritByInitialSnapshot;
		summonCfg.summonRelation = SummonRelation.Independent;
		summonCfg.attrPercent = summonInherit;
		summonCfg.leftTime = summonLeftTime;
		summonCfg.retainWhenCrossLevel = false;
		isInLink = false;
		isInStrongLink = false;
		isInWeakLink = false;
		_actor.logicVariable.ToggleLogicTag("inLink", value: false);
		StartCoroutine(ref corLinkFx, CheckLinkFx());
		if (GetPerkLv(514712, out var _))
		{
			StartCoroutine(ref corHitActor, HitActor());
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_READY_MSG", OnBattleReady);
		StopCoroutine(ref corLinkFx);
		StopCoroutine(ref corCastAreaEffect);
		StopCoroutine(ref corHitActor);
		_actor.buffComponent.RemoveBuffByBuffId(buffId_link);
		_actor.buffComponent.RemoveBuffByBuffId(buff_7);
		playFX.Stop();
		playFX_Weak.Stop();
	}

	public override void OnCastSkill(AdventureActorCastSkillEvent evt, bool isSelf)
	{
		base.OnCastSkill(evt, isSelf);
		if (!isSelf)
		{
			AdventureActor adventureActor = evt.sender as AdventureActor;
			if (adventureActor != null && summonMonster != null && adventureActor.Id == summonMonster.Id && evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.NONE && GetPerkLv(514710, out var _))
			{
				summonMonster.buffComponent.AddBuff(buff_10, summonMonster);
			}
		}
	}

	public override void OnCastEndSkill(AdventureActorCastSkillEndEvent evt)
	{
		base.OnCastEndSkill(evt);
		if (evt.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && GetPerkLv(514706, out var _))
		{
			_actor.buffComponent.AddBuff(buff_6, _actor);
		}
	}

	public override void OnBeforeHit(AdventureActorReceiveDamageBeforeHitEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnBeforeHit(evt, monster, isSelf);
	}

	public override void OnHitPost(AdventureActorReceiveDamageEvent evt, MonsterAdventureActor monster, bool isSelf)
	{
		base.OnHitPost(evt, monster, isSelf);
	}

	public override void OnCustomEvent(AdventureActorCustomEvent evt)
	{
		int lv;
		if (evt.eventHashCode == castUltra)
		{
			if (GetPerkLv(514708, out lv) && summonMonster != null && summonMonster.actorHealthInfo.isAlive)
			{
				summonMonster.monsterSummonInfo.ResetLeftTime();
				ILRuntimeAPI.PlayAreaEffect(summonMonster, areaEffect_8, summonMonster.tsTransform.Position);
			}
		}
		else if (evt.eventHashCode == castUltra2)
		{
			if (GetPerkLv(514708, out lv) && summonMonster != null && summonMonster.actorHealthInfo.isAlive && isInLink)
			{
				ILRuntimeAPI.PlayAreaEffect(summonMonster, areaEffect_8_2, summonMonster.tsTransform.Position);
			}
		}
		else if (evt.eventHashCode == summonEvt)
		{
			if (summonMonster != null)
			{
				UnLink();
				summonMonster.DestroySelf();
				summonMonster = null;
				isInLink = false;
				isInWeakLink = false;
				isInStrongLink = false;
			}
			TSVector2 pos = evt.tsVector2ParamList.get_Item(0);
			TSVector2 value = evt.tsVector2ParamList.get_Item(1);
			FP fpParam = evt.fpParam;
			_actor.logicVariable.SetLogicTagValue("monsterRadius", fpParam);
			_actor.logicVariable.SetLogicTagTSVector2Value("targetPos", value);
			ILRuntimeAPI.SummonMonster(_actor, 0, summonId, pos, _actor.tsTransform.Forward, summonCfg, null, (MonsterAdventureActor entity) =>
			{
				summonMonster = entity;
			});
		}
		else if (evt.eventHashCode == castAreaEvt && GetPerkLv(514703, out lv) && summonMonster != null && summonMonster.actorHealthInfo.isAlive)
		{
			string fxAlias = areaEffect_3;
			if (GetPerkLv(514704, out lv))
			{
				fxAlias = areaEffect_4;
			}
			ILRuntimeAPI.PlayAreaEffect(summonMonster, fxAlias, summonMonster.tsTransform.Position);
		}
	}

	private void OnBattleReady(IEvent evt)
	{
		if (_actor != null && summonMonster != null)
		{
			UnLink();
			summonMonster.DestroySelf();
			summonMonster = null;
			isInLink = false;
			isInWeakLink = false;
			isInStrongLink = false;
		}
	}

	public override void OnTriggerMask(AdventureActorReceiveDamageEvent evt)
	{
		base.OnTriggerMask(evt);
		if (GetPerkLv(514702, out var lv))
		{
			_actor.buffComponent.AddBuff(buff_2, _actor);
		}
		if (GetPerkLv(514713, out lv))
		{
			AdventureActor adventureActor = evt.from as AdventureActor;
			if (adventureActor != null)
			{
				adventureActor.buffComponent.AddBuff(buff_13, adventureActor);
			}
		}
	}

	private IEnumerator CheckLinkFx()
	{
		while (true)
		{
			if (summonMonster != null && summonMonster.actorHealthInfo.isAlive)
			{
				FP fP = TSVector2.Distance(summonMonster.tsTransform.Position, _actor.tsTransform.Position);
				if (fP > linkDistanceOut)
				{
					UnLink();
				}
				else if (fP > linkDistanceIn)
				{
					Link(isWeak: true);
				}
				else
				{
					Link(isWeak: false);
				}
			}
			else
			{
				UnLink();
			}
			yield return null;
		}
	}

	private void Link(bool isWeak)
	{
		int lv;
		if (!isInLink)
		{
			isInLink = true;
			_actor.logicVariable.ToggleLogicTag("inLink", value: true);
			if (GetPerkLv(514707, out lv))
			{
				_actor.buffComponent.AddBuff(buff_7, _actor);
			}
			if (GetPerkLv(514709, out lv) && summonMonster != null && summonMonster.actorHealthInfo.isAlive)
			{
				summonMonster.buffComponent.AddBuff(buff_9, summonMonster);
			}
			_actor.buffComponent.AddBuff(buffId_link, _actor);
		}
		if (isWeak)
		{
			if (!isInWeakLink)
			{
				isInWeakLink = true;
				isInStrongLink = false;
				playFX.Stop();
				string fxAlias = (GetPerkLv(514712, out lv) ? weaklinkFx_12 : weaklinkFx);
				TSVector sourcePosition = new TSVector(_actor.tsTransform.Position.x, 0, _actor.tsTransform.Position.y);
				TSVector targetPosition = new TSVector(summonMonster.tsTransform.Position.x, 0, summonMonster.tsTransform.Position.y);
				playFX_Weak.Stop();
				playFX_Weak.PlayLinFx(_actor, fxAlias, 1f, useCustSource: false, _actor.gameObject, sourcePosition, _actor.tsTransform.PositionY, summonMonster.gameObject, targetPosition, summonMonster.tsTransform.PositionY);
			}
		}
		else if (!isInStrongLink)
		{
			isInStrongLink = true;
			isInWeakLink = false;
			playFX_Weak.Stop();
			string fxAlias2 = (GetPerkLv(514712, out lv) ? linkFx_12 : linkFx);
			TSVector sourcePosition2 = new TSVector(_actor.tsTransform.Position.x, 0, _actor.tsTransform.Position.y);
			TSVector targetPosition2 = new TSVector(summonMonster.tsTransform.Position.x, 0, summonMonster.tsTransform.Position.y);
			playFX.Stop();
			playFX.PlayLinFx(_actor, fxAlias2, 1f, useCustSource: false, _actor.gameObject, sourcePosition2, _actor.tsTransform.PositionY, summonMonster.gameObject, targetPosition2, summonMonster.tsTransform.PositionY);
		}
	}

	private void UnLink()
	{
		if (isInLink)
		{
			isInLink = false;
			isInStrongLink = false;
			isInWeakLink = false;
			_actor.logicVariable.ToggleLogicTag("inLink", value: false);
			if (GetPerkLv(514707, out var lv))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buff_7);
			}
			if (GetPerkLv(514709, out lv) && summonMonster != null && summonMonster.actorHealthInfo.isAlive)
			{
				summonMonster.buffComponent.RemoveBuffByBuffId(buff_9);
			}
			playFX.Stop();
			playFX_Weak.Stop();
			_actor.buffComponent.RemoveBuffByBuffId(buffId_link);
		}
	}

	private IEnumerator HitActor()
	{
		while (true)
		{
			if (isInLink)
			{
				FP length = TSVector2.Distance(_actor.tsTransform.Position, summonMonster.tsTransform.Position);
				hitCfg_12.position = (_actor.tsTransform.Position + summonMonster.tsTransform.Position) / 2;
				hitCfg_12.direction = (summonMonster.tsTransform.Position - _actor.tsTransform.Position).normalized;
				ILRuntimeAPI.RectangleAreaHit(_actor, hitCfg_12, width_12, length);
			}
			yield return _actor.WaitTime(interval_12);
		}
	}
}
