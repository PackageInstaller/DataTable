using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15001;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		_actor.EnableCloseBlock();
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 3))
		{
			_actor.buffComponent.AddBuff(15096311, _actor);
		}
		DefaultLookAt();
	}

	public void OnStart()
	{
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, OnPlayTimeLineFinish, OnNotPlayTimeLine);
	}

	private void OnPlayTimeLineFinish()
	{
		string actionTag = "150_Ultra_TL";
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnNotPlayTimeLine()
	{
		string actionTag = "150_Ultra_NoTL";
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "150_Ultra_Attack"))
		{
			GenerateAttackAreaEffect();
		}
	}

	private void GenerateAttackAreaEffect()
	{
		TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Forward * Config.offset_AreaEffect_UltraSkill;
		ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_150_Ultra", position);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 515041, out var _))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_150_Ultra_P41", position);
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
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_actor.DisableCloseBlock();
	}
}
