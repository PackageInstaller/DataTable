using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13201;

public class ParallelScript_MainControl : ParallelScript
{
	private static readonly int damageTag_TriggerLightMark = CommonHelper.StringToHash("132_LightTag_Trigger");

	private const string areaEffectKey_LightMark = "AreaEffect_132_LightTag_Boom";

	private static readonly FP triggerCD_StrengthNormalAttack = 5;

	private static readonly int damageTag_Skill_Stage1 = CommonHelper.StringToHash("132_Main_S1_Burst");

	private const string tipsKey_TriggerMark = "LightMark_Trigger_Effect_02";

	private const int perkId_1 = 513201;

	private static readonly int damageTag_P1 = CommonHelper.StringToHash("132_Main_S3_Burst");

	private const int perkId_2 = 513202;

	private static readonly int damageTag_Trigger_P2 = CommonHelper.StringToHash("132_P2");

	private const int additionalAttrId_P2 = 13202011;

	private const int perkId_3 = 513203;

	private const int buffId_P3 = 13203011;

	private static readonly int damageTag_Trigger_P3 = CommonHelper.StringToHash("132_P3");

	private const int additionalAttrId_P3 = 13203011;

	private const int perkId_4 = 513204;

	private static readonly int damageTag_P4 = CommonHelper.StringToHash("132_Main_S2_Burst");

	private const int additionalAttrId_P4 = 13204011;

	private const int perkId_8 = 513208;

	private const string areaEffectKey_Skill_Stage1_P8 = "AreaEffect_132_Main_S1_Burst_P08_Stun";

	private const int perkId_10 = 513210;

	private static readonly int damageTag_P10 = CommonHelper.StringToHash("132_Ultra");

	private const int perkId_11 = 513211;

	private static readonly int damageTag_P11 = CommonHelper.StringToHash("132_Attack5");

	private const int buffId_P11 = 13211011;

	private const int perkId_12 = 513212;

	private const int parameterId_P12 = 13212011;

	private const int buffId_P12 = 13212011;

	private const int perkId_13 = 513213;

	private const int buffId_P13 = 13213011;

	private List<int> _damageTagList_TriggerLightMark;

	private FP _triggerTime_P12;

	public override void OnEnable()
	{
		base.OnEnable();
		if (_damageTagList_TriggerLightMark == null)
		{
			_damageTagList_TriggerLightMark = new List<int>(5);
		}
		else
		{
			_damageTagList_TriggerLightMark.Clear();
		}
		_damageTagList_TriggerLightMark.Add(damageTag_TriggerLightMark);
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513201, out var perkLevel))
		{
			_damageTagList_TriggerLightMark.Add(damageTag_P1);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513210, out perkLevel))
		{
			_damageTagList_TriggerLightMark.Add(damageTag_P10);
		}
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
	}

	private void OnCastSkill(IEvent evt)
	{
		if (!(evt is AdventureActorCastSkillEvent { sender: PlayerAdventureActor sender } adventureActorCastSkillEvent))
		{
			return;
		}
		int perkLevel;
		if (sender == _actor && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513212, out perkLevel))
			{
				FP scriptValue = CommonUtils.GetScriptValue(_actor, 13212011);
				if (_triggerTime_P12 <= 0 || _actor.LogicTime - _triggerTime_P12 > scriptValue)
				{
					_actor.buffComponent?.AddBuff(13212011, _actor);
					_triggerTime_P12 = _actor.LogicTime;
				}
			}
		}
		else if (sender != _actor && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B && ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513213, out perkLevel))
		{
			_actor.buffComponent?.AddBuff(13213011, _actor);
		}
	}

	protected override void OnSelfAttacked(AdventureActorReceiveAttackEvent attackEvent)
	{
		base.OnSelfAttacked(attackEvent);
		MonsterAdventureActor monsterAdventureActor = attackEvent.to as MonsterAdventureActor;
		if (!CommonUtils.CheckHitByTag(attackEvent.hitDamageTag, damageTag_Skill_Stage1))
		{
			return;
		}
		int perkLevel;
		if (CommonUtils.CheckElementMark(CommonDefine.LightMark1, monsterAdventureActor))
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513202, out perkLevel))
			{
				_actor.logicVariable.ToggleLogicTag("CanTriggerPerk_2", value: true);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513203, out perkLevel))
			{
				monsterAdventureActor.buffComponent?.AddBuff(13203011, _actor);
			}
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513208, out perkLevel))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_132_Main_S1_Burst_P08_Stun", monsterAdventureActor.tsTransform.Position);
		}
	}

	protected override void OnSelfBeforeHit(AdventureActorReceiveDamageBeforeHitEvent beforeHitEvent)
	{
		base.OnSelfBeforeHit(beforeHitEvent);
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513202, out var perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_Trigger_P2))
		{
			AdventureActor.AddFromAttr(13202011, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513203, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_Trigger_P3))
		{
			AdventureActor.AddFromAttr(13203011, _actor);
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513204, out perkLevel) && CommonUtils.CheckHitByTag(beforeHitEvent.hitDamageTag, damageTag_P4))
		{
			AdventureActor.AddFromAttr(13204011, _actor);
		}
	}

	protected override void OnSelfDamaged(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.OnSelfDamaged(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513211, out var _) && CommonUtils.CheckHitByTag(damageEvent.hitDamageTag, damageTag_P11))
		{
			monsterAdventureActor.buffComponent?.AddBuff(13211011, _actor);
		}
	}

	protected override void TryTriggerLightMark(AdventureActorReceiveDamageEvent damageEvent)
	{
		base.TryTriggerLightMark(damageEvent);
		MonsterAdventureActor monsterAdventureActor = damageEvent.to as MonsterAdventureActor;
		bool flag = false;
		if (_damageTagList_TriggerLightMark != null && _damageTagList_TriggerLightMark.Count > 0)
		{
			for (int i = 0; i < damageEvent.hitDamageTag.Count; i++)
			{
				int item = damageEvent.hitDamageTag.get_Item(i);
				if (_damageTagList_TriggerLightMark.Contains(item))
				{
					flag = true;
					break;
				}
			}
		}
		if (flag)
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_132_LightTag_Boom", monsterAdventureActor.tsTransform.Position);
			monsterAdventureActor.buffComponent?.RemoveBuffByTag(CommonDefine.Light);
			CommonUtils.TriggerElementMarkEvent(CommonDefine.Light, HotfixEnum.AdventureActorElementTriggerType.LightElementTriggerType1, _actor, monsterAdventureActor, "LightMark_Trigger_Effect_02");
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		_damageTagList_TriggerLightMark?.Clear();
		_triggerTime_P12 = 0;
	}
}
