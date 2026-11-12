using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._137;

public class SupportSkill : SkillAdvancedBase
{
	private const string comboTag = "Support1";

	private const string comboTag_2 = "Support2";

	private const string damageEventName = "137SkillSupJumpAtk";

	private const string areaEffectKey = "AreaEffect_Soldier_137_Support";

	private const string eventName_Summon = "137_Soldier_Summon";

	private const int summonedChessId = 100006;

	private static readonly FP spawnRadius = 5;

	private const int maxSummonCount_Potential = 3;

	private int _potentialLv;

	private int _summonedCount;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
		_summonedCount = 0;
	}

	public void OnStart()
	{
		PlayCombo();
	}

	private void PlayCombo()
	{
		string actionTag = ((_potentialLv >= 2) ? "Support2" : "Support1");
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnComboFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnComboFinish()
	{
		_skill.Clear();
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName == "137SkillSupJumpAtk")
		{
			TSVector2 position = _actor.tsTransform.Position;
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_Soldier_137_Support", position);
		}
		else if (!(eventName != "137_Soldier_Summon") && ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController)
		{
			int num = ((_potentialLv < 2) ? 1 : 3);
			if (_summonedCount < num)
			{
				TSVector2 position2 = _actor.RandomActorReachablePointInsideRing(_actor.tsTransform.Position, 0, spawnRadius);
				TSVector2 normalized = ((_actor.attackTarget != null) ? (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position) : _actor.tsTransform.Forward).normalized;
				soldierLevelController.SpawnSoldierSummon(_actor as SoldierActor, 100006, position2, normalized.GetAngle());
				_summonedCount++;
			}
		}
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
