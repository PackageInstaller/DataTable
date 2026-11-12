using System;

namespace AIScript.Monster.TowerDefense._16001;

public class SkillSpawn : SkillAdvancedBase
{
	private const string comboTag_Spawn_Summoned = "BubbleDoll_Born";

	protected PlayerAdventureActor _summoner;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		_actor.EnableCloseBlock();
		string actionTag = "BubbleDoll_Born";
		System.Action onComboFinish = OnFinish;
		System.Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
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
		_actor.Action(makeThreatAlert: false);
	}
}
