using System;

namespace AIScript.Monster.TowerDefense._16001;

public class SkillDeath : SkillAdvancedBase
{
	private const string comboTag_Death_Summoned = "BubbleDoll_Dead";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.PlayDeathAnim();
	}

	public void OnStart()
	{
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack("BubbleDoll_Dead", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
