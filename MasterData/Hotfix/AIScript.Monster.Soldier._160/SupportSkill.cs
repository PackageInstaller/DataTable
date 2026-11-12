using System;
using TrueSync;

namespace AIScript.Monster.Soldier._160;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support";

	private readonly string eventName_Summon = "Fire";

	private readonly int summonedChessId = 100003;

	private readonly TSVector2 summonOffset = new TSVector2(0, 0);

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
			TSVector2 result = _actor.tsTransform.Position + _actor.tsTransform.Left * summonOffset.x + _actor.tsTransform.Forward * summonOffset.y;
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			TSVector2 normalized = ((_actor.attackTarget != null) ? (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position) : _actor.tsTransform.Forward).normalized;
			soldierLevelController.SpawnSoldierSummon(_actor as SoldierActor, summonedChessId, result, normalized.GetAngle());
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
