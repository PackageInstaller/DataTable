#define LOG_DEBUG
using System;
using AdventureBehaviour;

namespace AIScript.Character._11801;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	private static readonly string actionTag_withTimeline = "Ultra_TimelineOn";

	private static readonly string actionTag_noTimeline = "Ultra_TimelineOff";

	private static readonly int loopCount = 2;

	private static readonly string areaEffect_pull = "AreaEffect_118_Ultra_XiYin";

	private static readonly int buffId_Base_1 = 11890002;

	private static readonly int loopCount_add = 2;

	private static readonly string areaEffect_pull_buff = "AreaEffect_118_Ultra_T2_XiYin_Buff";

	private int _currentLoopCount;

	private int _totalLoopCount;

	private long _areaEffectID;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11801 Skill_Ultra OnDisable");
		base.OnSkillDisable();
		_actor.DisableInvincible();
		_playTimeline.Clear();
		if (_areaEffectID > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectID);
		}
		_actor.buffComponent.RemoveBuffByBuffId(buffId_Base_1);
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11801 Skill_Ultra OnEnable");
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_currentLoopCount = 0;
		_totalLoopCount = loopCount;
		_areaEffectID = 0L;
		_actor.buffComponent.AddBuff(buffId_Base_1, _actor);
	}

	public virtual void OnStart()
	{
		NovaLogger.Debug("11801 Skill_Ultra OnStart");
		if (_skill != null)
		{
			if (_playTimeline == null)
			{
				_playTimeline = new PlayTimeline();
			}
			_playTimeline.Play(_actor, () =>
			{
				string actionTag = actionTag_withTimeline;
				System.Action onAnticipationEnd = OnAnticipationEnd;
				System.Action onRecoveryBegin = OnRecoverBegin;
				System.Action onComboLoop = OnComboLoop;
				System.Action onComboFinish = OnFinish;
				System.Action onInterrupt = OnInterrupt;
				BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
			}, () =>
			{
				string actionTag = actionTag_noTimeline;
				System.Action onAnticipationEnd = OnAnticipationEnd;
				System.Action onRecoveryBegin = OnRecoverBegin;
				System.Action onComboLoop = OnComboLoop;
				System.Action onComboFinish = OnFinish;
				System.Action onInterrupt = OnInterrupt;
				BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
			});
		}
	}

	private void OnAnticipationEnd()
	{
		string fxAlias = areaEffect_pull;
		_areaEffectID = ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, _actor.tsTransform.Position);
	}

	private void OnRecoverBegin()
	{
		if (_areaEffectID > 0)
		{
			ILRuntimeAPI.StopAreaEffect(_areaEffectID);
			_areaEffectID = 0L;
		}
	}

	private void OnComboLoop()
	{
		_currentLoopCount++;
		if (_currentLoopCount >= _totalLoopCount)
		{
			comboAttack.CancelAttack();
		}
	}

	private void OnFinish()
	{
		NovaLogger.Debug("11801 Skill_Ultra onFinish");
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		NovaLogger.Debug("11801 Skill_Ultra OnInterrupt");
		OnFinish();
	}
}
