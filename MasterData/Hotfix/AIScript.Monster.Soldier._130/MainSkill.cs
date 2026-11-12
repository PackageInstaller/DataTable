using System;
using TrueSync;

namespace AIScript.Monster.Soldier._130;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Skill";

	private readonly string eventName_Summon = "Summon";

	private readonly int summonedChessId = 100001;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_Summon) && ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController)
		{
			TSVector2 position = ((_actor.attackTarget != null) ? _actor.attackTarget.tsTransform.Position : _actor.tsTransform.Position);
			TSVector2 normalized = ((_actor.attackTarget != null) ? (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position) : _actor.tsTransform.Forward).normalized;
			soldierLevelController.SpawnSoldierSummon(_actor as SoldierActor, summonedChessId, position, normalized.GetAngle());
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
