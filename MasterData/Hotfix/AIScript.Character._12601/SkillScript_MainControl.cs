using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12601;

public class SkillScript_MainControl : SkillAdvancedBase
{
	private readonly string key_Base = "B1_Skill";

	private readonly int skillId_S1 = 12631000;

	private readonly string evt_FanShoot = "126Shoot";

	private readonly int perkId_1 = 512601;

	private readonly int count_1 = 2;

	private readonly FP radiusOffest = 3.8;

	private readonly string bullut_T2 = "Bullet_12601_Skill1P01_MagicHat";

	private readonly int perkId_2 = 512602;

	private readonly int skillId_S2 = 12631001;

	private readonly int perkId_4 = 512604;

	private readonly string key_Base_Prek4 = "B1_Skill_P04";

	private const string eventName_Summon = "B1_Summon";

	private const int monsterId_Summon = 12601111;

	private const int monsterId_Summon_2 = 12601311;

	private readonly FP randomRadius_SummonPosition = 0;

	private readonly FP durationTime_Summoned = 8;

	private DeterministicShape _randomPositionShape;

	private SummonCfg _summonCfg;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	public void OnUpdate()
	{
		LockDirection();
		if (_actor.attackTarget == null)
		{
			comboAttack.CancelAttack();
		}
	}

	private void OnFinishOrInterrupt()
	{
		_skill.Clear();
	}

	private void DoMainLogic()
	{
		string text = key_Base;
		if (GetPerkLv(perkId_4, out var _))
		{
			text = key_Base_Prek4;
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action action = onRecoveryBegin;
		System.Action onComboFinish = OnFinishOrInterrupt;
		System.Action onInterrupt = OnFinishOrInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, action, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void onRecoveryBegin()
	{
	}

	protected void OnCustomEvent(string eventName)
	{
		int lv;
		if (eventName.Equals(evt_FanShoot))
		{
			if (GetPerkLv(perkId_1, out lv))
			{
				TSVector2 normalized = TSVector2.Rotate(_actor.tsTransform.Forward, -45).normalized;
				TSVector2 position = _actor.tsTransform.Position + normalized * radiusOffest;
				ILRuntimeAPI.ShootByDirection(bullut_T2, _actor, default, normalized, position, 1.22);
				TSVector2 normalized2 = TSVector2.Rotate(_actor.tsTransform.Forward, 45).normalized;
				TSVector2 position2 = _actor.tsTransform.Position + normalized2 * radiusOffest;
				ILRuntimeAPI.ShootByDirection(bullut_T2, _actor, default, normalized2, position2, 1.22);
			}
			if (GetPerkLv(perkId_2, out lv))
			{
				AdventurRebindSkill adventurRebindSkill = AdventurRebindSkill.Generate();
				adventurRebindSkill.sender = _actor;
				adventurRebindSkill.slotKey = ActionKey.B;
				adventurRebindSkill.skillId = skillId_S2;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventurRebindSkill);
			}
		}
		if (eventName.Equals("B1_Summon") && GetPerkLv(perkId_4, out lv))
		{
			Summon();
		}
	}

	private void Summon()
	{
		TSVector2 position = _actor.tsTransform.Position;
		TSVector2 forward = _actor.tsTransform.Forward;
		if (_summonCfg == null)
		{
			_summonCfg = new SummonCfg
			{
				summonAttrType = SummonAttrType.InheritByInitialSnapshot,
				summonRelation = SummonRelation.Coexisted,
				attrPercent = 100,
				leftTime = durationTime_Summoned,
				summonType = SummonType.None
			};
		}
		int monsterId = ((_actor.skinID == 12603) ? 12601311 : 12601111);
		ILRuntimeAPI.SummonMonster(_actor, 0, monsterId, position, forward, _summonCfg, null, (MonsterAdventureActor monster) =>
		{
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.eventName = "126_Summon";
			adventureActorCustomEvent.stringParamList = new List<string> { monster.Id.ToString() };
			_actor.DispatchEvent(adventureActorCustomEvent);
		});
	}

	private bool GetPerkLv(int perkId, out int lv)
	{
		return ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, perkId, out lv);
	}
}
