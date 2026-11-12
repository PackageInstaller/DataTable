using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10801;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private const string actionTag_Loop_Timeline = "Ultra_TL_Loop";

	private const string actionTag_Loop_NoTimeline = "Ultra_NoTL_Loop";

	private const string actionTag_End = "Ultra_End";

	private const int totalLoopTime = 5;

	private const int perkId_42 = 510842;

	private const string actionTag_End_Perk42 = "Ultra_P42_End";

	private int _totalLoopTime;

	private bool _canAim;

	private AimTarget _aimTarget;

	private PlayTimeline _playTimeline;

	private int _loopTime;

	private TSVector2 _direction;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
		_totalLoopTime = 5;
		_canAim = true;
		_loopTime = 0;
		_direction = _actor.tsTransform.Forward;
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, PlayTimelineShootCombo, PlayNoTimelineShootCombo);
	}

	private void PlayTimelineShootCombo()
	{
		string loopStageActionTag = GetLoopStageActionTag(haveTimeline: true);
		Action onComboLoop = OnShootComboLoop;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(loopStageActionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
	}

	private void PlayNoTimelineShootCombo()
	{
		string loopStageActionTag = GetLoopStageActionTag(haveTimeline: false);
		Action onComboLoop = OnShootComboLoop;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(loopStageActionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
	}

	private string GetLoopStageActionTag(bool haveTimeline)
	{
		if (!haveTimeline)
		{
			return "Ultra_NoTL_Loop";
		}
		return "Ultra_TL_Loop";
	}

	protected void OnShootComboLoop()
	{
		_loopTime++;
		if (_loopTime >= _totalLoopTime)
		{
			string text = "Ultra_End";
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 510842, out var _))
			{
				text = "Ultra_P42_End";
			}
			_canAim = !((PlayerAdventureActor)_actor).isAssist;
			string actionTag = text;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		}
	}

	public void OnUpdate()
	{
		if (_canAim)
		{
			LogicEntity attackTarget = GetAttackTarget();
			if (attackTarget != null)
			{
				_direction = (attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			}
			if (_aimTarget == null)
			{
				_aimTarget = new AimTarget();
			}
			if (_actor.aimMode != AdventureActor.AimMode.LockDirection)
			{
				_aimTarget.Aim(_actor, null, _direction);
			}
			else
			{
				_actor.tsTransform.Forward = _direction;
			}
		}
	}

	private LogicEntity GetAttackTarget()
	{
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			return CommonUtils.GetAssistantAttackTarget(_actor);
		}
		return _actor.attackTarget;
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
		_playTimeline?.Clear();
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_aimTarget?.Cancel();
		_aimTarget?.Clear();
		_loopTime = 0;
	}
}
