using System;
using TrueSync;
using UnityEngine;

namespace AIScript.Character._14901;

public class SkillScript_Skill_MainControl : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt(useInputDirectionFirst: true, useSemiAutoBattleMode: true);
		_actor.EnableSuperArmor();
	}

	public void OnStart()
	{
		ParallelScript_MainControl.delayTime = 0;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("149_Skill_Main", flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
		if (string.Equals(evt, "149_Summon_IronMaiden"))
		{
			ParallelScript_MainControl.delayTime = Config_MainControl.summonDelay;
			ParallelScript_MainControl.rightShape = new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Fan,
				position = _actor.tsTransform.Position,
				angle = Config_MainControl.summonAngle / 2,
				rotation = _actor.tsTransform.Right.GetAngle(),
				innerRadius = 0,
				radius = _actor.actorSearchTargetInfo.hearRange
			};
			ParallelScript_MainControl.leftShape = new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Fan,
				position = _actor.tsTransform.Position,
				angle = Config_MainControl.summonAngle / 2,
				rotation = _actor.tsTransform.Left.GetAngle(),
				innerRadius = 0,
				radius = _actor.actorSearchTargetInfo.hearRange
			};
			ParallelScript_MainControl.acPos = _actor.tsTransform.Position;
			ParallelScript_MainControl._rotation = _actor.tsTransform.Rotation;
			ParallelScript_MainControl._scale = _actor.transform.localScale;
			Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
			ParallelScript_MainControl._target = new TSVector2(mainCamera.transform.position.x, mainCamera.transform.position.z);
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
		_actor.DisableSuperArmor();
		comboAttack?.Clear();
	}
}
