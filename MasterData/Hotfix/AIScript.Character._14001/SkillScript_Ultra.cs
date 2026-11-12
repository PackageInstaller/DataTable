using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14001;

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
		if (_playTimeline == null)
		{
			_playTimeline = new PlayTimeline();
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514022, out var perkLevel) && _actor.isHide)
		{
			_actor.Visible();
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514043, out perkLevel))
		{
			_actor.buffComponent.RemoveBuffByBuffId(14043011);
		}
		_actor.actorSearchTargetInfo.AddSearchRange(Config.addSearchRange_UltraSkill, ActorSearchTarget.SearchType.allRange);
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		AimDirection();
	}

	public void OnStart()
	{
		_playTimeline.Play(_actor, PlayFirstStageCombo, PlayAllStageCombo, 1, addPlayTime: false);
	}

	private void PlayFirstStageCombo()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = PlaySecondTimeline;
		Action onInterrupt = OnInterrupt;
		BeginAttack("140_Ultra_TL1", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		_actor.ResumeAnimationGroup();
	}

	private void PlayAllStageCombo()
	{
		string text = "140_Ultra_NoTL";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514042, out var _))
		{
			text = "140_Ultra_NoTL_P42";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		_actor.ResumeAnimationGroup();
	}

	private void PlaySecondTimeline()
	{
		_playTimeline.Play(_actor, PlaySecondStageCombo, PlaySecondStageCombo, 2);
	}

	private void PlaySecondStageCombo()
	{
		string text = "140_Ultra_TL2";
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514042, out var _))
		{
			text = "140_Ultra_TL2_P42";
		}
		string actionTag = text;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "140_Ultra_Lock"))
		{
			AimDirection();
		}
		else if (string.Equals(eventName, "140_Ultra_P1_Start"))
		{
			_actor.Hide(performanceMode: true);
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: false);
		}
		else if (string.Equals(eventName, "140_Ultra_P1_End"))
		{
			_actor.Visible();
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: true);
		}
		else if (string.Equals(eventName, "140_Ultra_Area"))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_14001_Ultra", _actor.tsTransform.Position, _actor.tsTransform.Rotation);
		}
		else if (string.Equals(eventName, "140_Ultra_Shoot"))
		{
			TSVector2 position = _actor.tsTransform.Position;
			if (_actor.attackTarget != null)
			{
				position = _actor.attackTarget.tsTransform.Position;
			}
			else
			{
				position += _actor.tsTransform.Forward * Config.areaEffectOffset_NoTarget_UltraSkill;
			}
			string fxAlias = "AreaEffect_14001_Ultra_Boom";
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 514042, out var _))
			{
				fxAlias = "AreaEffect_14001_Ultra_Boom_P42";
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, fxAlias, position);
		}
	}

	private void AimDirection()
	{
		TSVector2 tSVector = ((_actor.attackTarget != null) ? (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized : _actor.tsTransform.Forward);
		LockDirection(tSVector);
		_actor.tsTransform.Forward = tSVector;
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
		CancelLockDirection();
		_actor.actorSearchTargetInfo.AddSearchRange(-Config.addSearchRange_UltraSkill, ActorSearchTarget.SearchType.allRange);
		_actor.DisableInvincible();
		_actor.DisableSuperArmor();
		_actor.DisableImmuneControl();
		_actor.DisableCloseBlock();
		_actor.ResumeAnimationGroup();
		if (_actor.isHide)
		{
			_actor.Visible();
			SceneSingleton<AdventureIndicatorController>.Instance.ShowHighlightBlob(show: true);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514032, out var perkLevel))
		{
			_actor.buffComponent.AddBuff(14032012, _actor);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514041, out perkLevel))
		{
			DeterministicShape shape = new DeterministicShape
			{
				shapeType = DeterministicShape.ShapeType.Circle,
				innerRadius = _actor.GetRadius(),
				radius = Config.randomDropRadius_P41,
				position = _actor.tsTransform.Position
			};
			for (int i = 0; i < 3; i++)
			{
				TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, shape);
				ILRuntimeAPI.PlayDrop(_actor, "Item_140_Ultra_P41", randomPointInShape);
			}
		}
	}
}
