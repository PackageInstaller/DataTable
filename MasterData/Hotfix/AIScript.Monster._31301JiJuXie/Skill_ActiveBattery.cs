using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_ActiveBattery : SkillSimpleBase
{
	private static readonly string combo_ActiveBattery = "ActiveBattery";

	private static readonly string evt_Active = "Active";

	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private List<LogicEntity> teamMateList = new List<LogicEntity>();

	private List<long> _lockFxIds;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_lockFxIds != null)
		{
			foreach (long lockFxId in _lockFxIds)
			{
				StopEffect(lockFxId);
			}
			_lockFxIds.Clear();
		}
		SetLogicTagToggleValue(_actor, Config.Skill_ActiveBattery_Finish, value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		string actionKey = ((CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0) ? combo_Turn_Left : combo_Turn_Right);
		BeginAttack(1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 entityPosition = GetEntityPosition(logicEntity);
		BeginLookAtByPos(entityPosition, 0.66, (FP)90 / (FP)0.66);
		yield return WaitTime(0.66);
		StopWaitLookAt();
		BeginAttack(2, combo_ActiveBattery, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.48);
		List<LogicEntity> targetByTeammateIndexes = GetTargetByTeammateIndexes(new List<int> { 1 });
		if (_lockFxIds == null)
		{
			_lockFxIds = new List<long>();
		}
		_lockFxIds.Clear();
		foreach (LogicEntity item in targetByTeammateIndexes)
		{
			if (!(item == null) && (!(item is AdventureActor entity) || !entity.IsDead()))
			{
				List<long> lockFxIds = _lockFxIds;
				Skill_ActiveBattery skill_ActiveBattery = this;
				LogicEntity target = item;
				lockFxIds.Add(skill_ActiveBattery.PlayLinkEffect("fx_m31301_loop_skill7_link", useCustomSource: false, null, default, default, target));
			}
		}
		yield return WaitCustomEvent(evt_Active);
		if (_lockFxIds != null)
		{
			foreach (long lockFxId in _lockFxIds)
			{
				StopEffect(lockFxId);
			}
			_lockFxIds.Clear();
		}
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config.evt_ActiveBattery;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
