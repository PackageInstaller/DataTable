using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15601;

public class SkillScript_HeartArrow_Support : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (activedPlayerActor != null)
		{
			_actor.LookAt(activedPlayerActor.tsTransform.Position, 0f);
		}
	}

	public void OnStart()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill_Sup_ShootHeartArrow", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "ShootHeartArrow"))
		{
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config_Support.shootOffset_HeartArrow;
			AdventureActor actor = _actor;
			TSVector2 forward = _actor.tsTransform.Forward;
			FP shootPositionY_HeartArrow = Config_Support.shootPositionY_HeartArrow;
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			ILRuntimeAPI.ShootByDirection("Bullet_156_Sup_Skill_HeartArrow", actor, default, forward, position, shootPositionY_HeartArrow, default, activedPlayerActor);
		}
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
