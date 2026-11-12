#define LOG_DEBUG
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50011XingXing;

public class Skill_1 : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	private readonly LookAtTarget _lookAtTarget = new LookAtTarget();

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_50011XingXing Skill_1 OnDisable");
		base.OnSkillDisable();
		_lookAtTarget.Clear();
		_comboAttack?.Clear();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_50011XingXing Skill_1 OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_50011XingXing Skill_1 OnStart");
		if (!(_skill != null))
		{
			return;
		}
		LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
		if (!CommonUtils.CheckTargetIsValid(activedPlayerActor, 0L))
		{
			OnFinish();
			return;
		}
		SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
		if (_comboAttack == null)
		{
			_comboAttack = new ComboAttack();
		}
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[2]
		{
			ComboInputBuffer.ActionKey.G,
			ComboInputBuffer.ActionKey.A
		};
		TSVector2 forward = _actor.tsTransform.Forward;
		TSVector2 tSVector = activedPlayerActor.tsTransform.Position - _actor.tsTransform.Position;
		if (forward.y * tSVector.x - forward.x * tSVector.y > 0)
		{
			array = new ComboInputBuffer.ActionKey[2]
			{
				ComboInputBuffer.ActionKey.G,
				ComboInputBuffer.ActionKey.B
			};
		}
		ComboAttack comboAttack = _comboAttack;
		AdventureActor actor = _actor;
		AdventureSkill skill = _skill;
		ComboInputBuffer.ActionKey[] actionKeys = array;
		int skillId = ((_skill != null) ? _skill.skillId : 0);
		Action onComboFinish = OnFinishS;
		Action onInterrupt = OnInterrupt;
		comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt);
		_lookAtTarget.BeginLookAt(_actor, activedPlayerActor, 2, 60, () =>
		{
			_comboAttack.InterruptAttack();
			OnFinish();
		});
	}

	protected void OnFinishS()
	{
		NovaLogger.Debug("_50011XingXing Skill_1 OnFinishS");
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_50011XingXing Skill_1 onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_50011XingXing Skill_1 onInterrupt");
		_skill.Clear();
	}
}
