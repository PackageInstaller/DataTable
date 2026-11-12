using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13201;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private const string actionTag_Timeline = "132_Ultra_TL";

	private const string actionTag_NoTimeline = "132_Ultra_NoTL";

	private const string eventName_GenerateAreaEffect = "StartArea";

	private const string fxKey_Default = "fx_13201_base_Ultra_AOE";

	private const string areaEffectKey_Default = "AreaEffect_132_Ultra";

	private static readonly FP forwardOffset_NoTarget = 8;

	private const string eventName_StopLookAt = "StopLock";

	private const int perkId_42 = 513242;

	private const string areaEffectKet_P42 = "AreaEffect_132_Ultra_P42";

	private const int perkId_43 = 513243;

	private const string actionTag_Timeline_P43 = "132_Ultra_TL";

	private const string actionTag_NoTimeline_P43 = "132_Ultra_NoTL";

	private const string fxKey_P43 = "fx_13201_base_Ultra_AOE_H6";

	private const string areaEffectKey_P43 = "AreaEffect_132_Ultra_H6";

	private PlayTimeline _playTimeline;

	private PlayFX _playFX;

	private bool _canLookAt;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		DefaultLookAt();
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
		{
			_actor.buffComponent.AddBuff(13296211, _actor);
		}
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
	}

	public void OnStart()
	{
		LookAt();
		_canLookAt = true;
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		_playTimeline.Play(_actor, OnPlayTimelineFinish, OnNoPlayTimeLine);
	}

	private void OnPlayTimelineFinish()
	{
		string text = "132_Ultra_TL";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513243, out var _))
		{
			text = "132_Ultra_TL";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnNoPlayTimeLine()
	{
		string text = "132_Ultra_NoTL";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513243, out var _))
		{
			text = "132_Ultra_NoTL";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: false, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	public void OnUpdate()
	{
		if (_canLookAt)
		{
			LookAt();
		}
	}

	private void LookAt()
	{
		TSVector2 dir = _actor.tsTransform.Forward;
		if (_actor.attackTarget != null)
		{
			dir = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
		}
		_actor.LookAtDir(dir, 0);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "StartArea"))
		{
			TSVector2 areaEffectPosition = GetAreaEffectPosition();
			string fxAlias = "AreaEffect_132_Ultra";
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513242, out var perkLevel))
			{
				fxAlias = "AreaEffect_132_Ultra_P42";
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, areaEffectPosition);
			string fxAlias2 = "fx_13201_base_Ultra_AOE";
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513243, out perkLevel))
			{
				fxAlias2 = "fx_13201_base_Ultra_AOE_H6";
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_132_Ultra_H6", areaEffectPosition);
			}
			if (_playFX == null)
			{
				_playFX = new PlayFX();
			}
			else
			{
				_playFX.Clear();
			}
			_playFX.Play(_actor, null, fxAlias2, default, areaEffectPosition, _actor.tsTransform.Forward);
		}
		else if (string.Equals(eventName, "StopLock"))
		{
			_canLookAt = false;
		}
	}

	private TSVector2 GetAreaEffectPosition()
	{
		TSVector2 position = _actor.tsTransform.Position;
		if (_actor.attackTarget != null)
		{
			return _actor.attackTarget.tsTransform.Position;
		}
		return position + _actor.tsTransform.Forward * forwardOffset_NoTarget;
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
		_canLookAt = false;
	}
}
