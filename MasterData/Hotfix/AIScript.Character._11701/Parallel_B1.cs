using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11701;

public class Parallel_B1 : Parallel_old
{
	protected static readonly int _attackTag_additional_damage = CommonHelper.StringToHash("117_B1T3_Hit");

	protected static readonly int _targetTag = CommonHelper.StringToHash("LightTag1");

	private const int _hitDamageId = 117000001;

	private const string _hitFxPath = "fx_13201_light_mark_harm";

	private readonly FP _additionalHitDamageCoolDown = 6f;

	private const int personalPerkId_1 = 511701;

	private readonly Dictionary<int, int> additionalAttrIdDict_perk_1 = new Dictionary<int, int>
	{
		[1] = 11755111,
		[2] = 11755121,
		[3] = 11755131,
		[4] = 11755141,
		[5] = 11755151
	};

	private const int personalPerkId_2 = 511702;

	private readonly Dictionary<int, int> cooldown_perk_2 = new Dictionary<int, int>
	{
		[1] = 32,
		[2] = 25,
		[3] = 23,
		[4] = 21,
		[5] = 16
	};

	private const int personalPerkId_3 = 511703;

	private readonly Dictionary<int, int> addTime_perk_3 = new Dictionary<int, int>
	{
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5
	};

	private static readonly int attackTag_perk_3 = CommonHelper.StringToHash("117_B1_Hit");

	private const int areaEffect_addTime_perk_3 = 2;

	private const int areaEffect_max_addTime_perk_3 = 5;

	private readonly Dictionary<long, FP> _additionalHitDamageTargetDic = new Dictionary<long, FP>();

	private FP lastPerk2TakeEffectTime;

	private Dictionary<long, FP> areaEffectAdditionalTimeDict = new Dictionary<long, FP>();

	public override void OnEnable()
	{
		base.OnEnable();
		lastPerk2TakeEffectTime = -_actor.LogicTime;
		areaEffectAdditionalTimeDict.Clear();
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_SWICH_PLAYER_ACTOR", OnSwitchActor);
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_SWICH_PLAYER_ACTOR", OnSwitchActor);
	}

	protected override void OnBeforeHit(IEvent evt)
	{
		base.OnBeforeHit(evt);
		AdventureActorReceiveDamageBeforeHitEvent adventureActorReceiveDamageBeforeHitEvent = evt as AdventureActorReceiveDamageBeforeHitEvent;
		if (adventureActorReceiveDamageBeforeHitEvent.from != _actor)
		{
			return;
		}
		AdventureActor adventureActor = adventureActorReceiveDamageBeforeHitEvent.to as AdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511701, out var perkLevel))
		{
			MonsterAdventureActor monsterAdventureActor = adventureActor as MonsterAdventureActor;
			if (monsterAdventureActor.IsBossMonster() || monsterAdventureActor.monsterInfo.epicType == HotfixEnum.monsterEpicType.ELITE)
			{
				AdventureActor.AddFromAttr(additionalAttrIdDict_perk_1.get_Item(perkLevel), _actor);
			}
		}
	}

	protected override void OnDamage(IEvent evt)
	{
		base.OnDamage(evt);
		AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent = evt as AdventureActorReceiveDamageEvent;
		if (adventureActorReceiveDamageEvent.from != _actor)
		{
			return;
		}
		AdventureActor adventureActor = adventureActorReceiveDamageEvent.to as AdventureActor;
		if (CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, _attackTag_additional_damage) && adventureActor.CheckTag(_targetTag))
		{
			bool flag = true;
			if (_additionalHitDamageTargetDic.TryGetValue(adventureActor.Id, out var value) && _actor.LogicTime < value + _additionalHitDamageCoolDown)
			{
				flag = false;
			}
			if (flag)
			{
				ILRuntimeAPI.HitActor(_actor, adventureActor, 117000001, null, "fx_13201_light_mark_harm", attackFxPlayOnTarget: true);
				_additionalHitDamageTargetDic.set_Item(adventureActor.Id, _actor.LogicTime);
			}
		}
		if (!ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511703, out var _) || !adventureActorReceiveDamageEvent.isKill || !CommonUtils.CheckHitByTag(adventureActorReceiveDamageEvent.hitDamageTag, attackTag_perk_3) || !adventureActor.CheckTag(_targetTag))
		{
			return;
		}
		if (areaEffectAdditionalTimeDict.TryGetValue(adventureActorReceiveDamageEvent.areaEffectId, out var value2))
		{
			if (value2 < 5)
			{
				FP fP = TSMath.Min(2, 5 - value2);
				areaEffectAdditionalTimeDict.get_Item(adventureActorReceiveDamageEvent.areaEffectId) += fP;
				modifyAreaEffectLeftTime(adventureActorReceiveDamageEvent.areaEffectId, fP);
			}
		}
		else
		{
			areaEffectAdditionalTimeDict.set_Item(adventureActorReceiveDamageEvent.areaEffectId, (FP)2);
			modifyAreaEffectLeftTime(adventureActorReceiveDamageEvent.areaEffectId, 2);
		}
		static void modifyAreaEffectLeftTime(long areaEffectId, FP addTime)
		{
			ILRuntimeAPI.AddAreaEffectLeftTime(areaEffectId, addTime);
		}
	}

	private void OnSwitchActor(IEvent evt)
	{
		if ((evt as AdventureSWICH_PLAYER_ACTOR).sender as AdventureActor == _actor && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511702, out var perkLevel) && _actor.LogicTime - lastPerk2TakeEffectTime >= cooldown_perk_2.get_Item(perkLevel))
		{
			lastPerk2TakeEffectTime = _actor.LogicTime;
			(_actor as PlayerAdventureActor).playerSkillCd.ResetSkillCD(ActionKey.B);
		}
	}
}
