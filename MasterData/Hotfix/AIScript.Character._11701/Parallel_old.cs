using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11701;

public class Parallel_old : ParallelBase
{
	private static readonly int attackTag_normal = CommonHelper.StringToHash("117_Normal_Hit");

	private static readonly int attackTag_skill = CommonHelper.StringToHash("117_Skill_Hit");

	private static readonly int attackTag_ultra = CommonHelper.StringToHash("117_Ultra_Hit");

	private static readonly int targetTag = CommonHelper.StringToHash("LightTag1");

	private const int personalPerkId_7 = 511707;

	private readonly Dictionary<int, int> buffIdDict_perk_7 = new Dictionary<int, int>
	{
		[1] = 11755711,
		[2] = 11755721,
		[3] = 11755731,
		[4] = 11755741,
		[5] = 11755751
	};

	private const int personalPerkId_8 = 511708;

	private readonly Dictionary<int, FP> rateDict_perk_8 = new Dictionary<int, FP>
	{
		[1] = 0.1,
		[2] = 0.12,
		[3] = 0.14,
		[4] = 0.15,
		[5] = 0.9
	};

	private readonly int additionalAttrId_8 = 11755811;

	private readonly string effectAlias_8 = "fx_11701_loop_perk8_Strengthen_L";

	private readonly string effectAlias1_8 = "fx_11701_loop_perk8_Strengthen_R";

	private const int personalPerkId_9 = 511709;

	private readonly Dictionary<int, int> buffIdDict_perk_9 = new Dictionary<int, int>
	{
		[1] = 11755911,
		[2] = 11755921,
		[3] = 11755931,
		[4] = 11755941,
		[5] = 11755951
	};

	private readonly Dictionary<int, int> cooldownDict_perk_9 = new Dictionary<int, int>
	{
		[1] = 10,
		[2] = 8,
		[3] = 7,
		[4] = 6,
		[5] = 5
	};

	private const int personalPerkId_10 = 511710;

	private readonly Dictionary<int, string> areaEffectDict_perk_10 = new Dictionary<int, string>
	{
		[1] = "AreaEffect_117_Perk10_ThunderArmor",
		[2] = "AreaEffect_117_Perk10_ThunderArmor",
		[3] = "AreaEffect_117_Perk10_ThunderArmor",
		[4] = "AreaEffect_117_Perk10_ThunderArmor",
		[5] = "AreaEffect_117_Perk10_ThunderArmor"
	};

	private readonly FP cd_perk_10 = 5;

	private const int personalPerkId_11 = 511711;

	private readonly Dictionary<int, FP> rateDict_perk_11 = new Dictionary<int, FP>
	{
		[1] = 0.4,
		[2] = 0.56,
		[3] = 0.62,
		[4] = 0.68,
		[5] = 1
	};

	private readonly string areaEffectAlias_perk_11 = "AreaEffect_117_Perk11_Repel";

	private const int personalPerkId_12 = 511712;

	private readonly FP hp_percent_perk_12 = 80;

	private readonly Dictionary<int, int> additionalAttrIdDict_perk_12 = new Dictionary<int, int>
	{
		[1] = 11756211,
		[2] = 11756221,
		[3] = 11756231,
		[4] = 11756241,
		[5] = 11756251
	};

	private const int personalPerkId_13 = 511713;

	private readonly Dictionary<int, int> additionalAttrIdDict_perk_13 = new Dictionary<int, int>
	{
		[1] = 11756311,
		[2] = 11756321,
		[3] = 11756331,
		[4] = 11756341,
		[5] = 11756351
	};

	private const int personalPerkId_14 = 511714;

	private readonly Dictionary<int, int> buffIdDict_perk_14 = new Dictionary<int, int>
	{
		[1] = 11756411,
		[2] = 11756421,
		[3] = 11756431,
		[4] = 11756441,
		[5] = 11756451
	};

	private const int personalPerkId_15 = 511715;

	private readonly Dictionary<int, int> buffIdDict_perk_15 = new Dictionary<int, int>
	{
		[1] = 11756511,
		[2] = 11756521,
		[3] = 11756531,
		[4] = 11756541,
		[5] = 11756551
	};

	private readonly int buffId_destiny_2 = 11709021;

	private readonly int buffId_destiny_6 = 11709061;

	private readonly string ultra_bullet_tag_destiny_6 = "ultra";

	private bool nextSkillEnhance;

	private PlayFX playFx;

	private PlayFX playFx1;

	private FP lastPerk9TakeEffectTime;

	private FP lastPerk10TakeEffectTime;

	public override void OnEnable()
	{
		base.OnEnable();
		nextSkillEnhance = false;
		lastPerk9TakeEffectTime = -_actor.LogicTime;
		lastPerk10TakeEffectTime = -_actor.LogicTime;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_RECEIVE_DAMAGE", OnDamage);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
	}

	protected virtual void OnBeforeHit(IEvent evt)
	{
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (adventureActorReceiveDamageBeforeHitEvent.from == _actor)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511712, out var perkLevel) && _actor.actorHealthInfo.hpPercentage > hp_percent_perk_12)
			{
				AdventureActor.AddFromAttr(additionalAttrIdDict_perk_12.get_Item(perkLevel), _actor);
			}
			if ((adventureActorReceiveDamageBeforeHitEvent.to as AdventureActor).CheckTag(targetTag) && CommonUtils.CheckHitByTag(adventureActorReceiveDamageBeforeHitEvent.hitDamageTag, attackTag_ultra) && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511713, out var perkLevel2))
			{
				AdventureActor.AddFromAttr(additionalAttrIdDict_perk_13.get_Item(perkLevel2), _actor);
			}
		}
	}

	protected virtual void OnDamage(IEvent evt)
	{
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		int perkLevel4;
		if (adventureActorReceiveDamageEvent.from == _actor)
		{
			if (!(adventureActorReceiveDamageEvent.to as AdventureActor).CheckTag(targetTag))
			{
				return;
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, attackTag_normal))
			{
				if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511707, out var perkLevel))
				{
					_actor.buffComponent?.AddBuff(buffIdDict_perk_7.get_Item(perkLevel), _actor);
				}
				if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511708, out var perkLevel2))
				{
					FP fP = rateDict_perk_8.get_Item(perkLevel2);
					if (TSRandom.Range(FP.Zero, FP.One) <= fP && !nextSkillEnhance)
					{
						nextSkillEnhance = true;
						if (playFx == null)
						{
							playFx = new PlayFX();
						}
						playFx.Play(_actor, null, effectAlias_8, _actor.tsTransform.PositionY, _actor.tsTransform.Position, _actor.tsTransform.Forward);
						if (playFx1 == null)
						{
							playFx1 = new PlayFX();
						}
						playFx1.Play(_actor, null, effectAlias1_8, _actor.tsTransform.PositionY, _actor.tsTransform.Position, _actor.tsTransform.Forward);
					}
				}
			}
			if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, attackTag_skill) && nextSkillEnhance)
			{
				AdventureActor.AddFromAttr(additionalAttrId_8, _actor);
				nextSkillEnhance = false;
				playFx?.Stop();
				playFx?.Clear();
				playFx1?.Stop();
				playFx1?.Clear();
			}
			if (adventureActorReceiveDamageEvent.isKill && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511715, out var perkLevel3))
			{
				_actor.buffComponent?.AddBuff(buffIdDict_perk_15.get_Item(perkLevel3), _actor);
			}
		}
		else if (adventureActorReceiveDamageEvent.to == _actor && adventureActorReceiveDamageEvent.attackType == DamageType.Melee && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511711, out perkLevel4))
		{
			FP fP2 = rateDict_perk_11.get_Item(perkLevel4);
			if (TSRandom.Range(FP.Zero, FP.One) <= fP2)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectAlias_perk_11, _actor.tsTransform.Position);
			}
		}
	}

	private void OnCastSkill(IEvent evt)
	{
		if (!(evt is AdventureActorCastSkillEvent adventureActorCastSkillEvent))
		{
			return;
		}
		AdventureActor adventureActor = adventureActorCastSkillEvent.sender as AdventureActor;
		if (adventureActor == null || adventureActor != _actor)
		{
			return;
		}
		if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511709, out var perkLevel) && _actor.LogicTime - lastPerk9TakeEffectTime >= cooldownDict_perk_9.get_Item(perkLevel))
			{
				lastPerk9TakeEffectTime = _actor.LogicTime;
				_actor.buffComponent?.AddBuff(buffIdDict_perk_9.get_Item(perkLevel), _actor);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511710, out var perkLevel2) && _actor.LogicTime - lastPerk10TakeEffectTime >= cd_perk_10)
			{
				lastPerk10TakeEffectTime = _actor.LogicTime;
				ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectDict_perk_10.get_Item(perkLevel2), _actor.tsTransform.Position);
			}
		}
		if (adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511714, out var perkLevel3))
		{
			_actor.buffComponent?.AddBuff(buffIdDict_perk_14.get_Item(perkLevel3), _actor);
		}
	}

	private void OnBulletFinish(IEvent evt)
	{
		if (evt is AdventureBulletFinishEvent adventureBulletFinishEvent && adventureBulletFinishEvent.tag == ultra_bullet_tag_destiny_6)
		{
			_actor.buffComponent?.RemoveBuffByBuffId(buffId_destiny_6);
		}
	}
}
