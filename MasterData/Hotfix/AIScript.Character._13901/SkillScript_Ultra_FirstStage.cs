using System;
using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._13901;

public class SkillScript_Ultra_FirstStage : SkillAdvancedBase
{
	private PlayTimeline _playTimeline;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableInvincible();
		_actor.EnableSuperArmor();
		_actor.EnableImmuneControl();
		if (ModuleController<AdventureModuleController>.Instance.CheckActorActiveTalentLevel(_actor.dataID, 2))
		{
			_actor.buffComponent.AddBuff(13996221, _actor);
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
		Action<string> onCustomEvent = OnCustomEvent;
		Action onActivationEnd = OnActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("139_Ultra_TL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnNotPlayTimeLine()
	{
		Action<string> onCustomEvent = OnCustomEvent;
		Action onActivationEnd = OnActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("139_Ultra_NoTL", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, "139_Ultra1_AddBuff"))
		{
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513903, out var perkLevel))
			{
				int buffNum = _actor.buffComponent.GetBuffNum(0, 0, Config_MainControl.buffTag_Soul);
				if (buffNum > 0)
				{
					AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
					adventureActorCustomEvent.sender = _actor;
					adventureActorCustomEvent.actor = _actor;
					adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_RemoveSoul;
					adventureActorCustomEvent.boolParam = true;
					_actor.DispatchEvent(adventureActorCustomEvent);
					for (int i = 0; i < Config_MainControl.removeSoulFxList_P3.Count && i <= buffNum - 1; i++)
					{
						new PlayFX().Play(_actor, null, Config_MainControl.removeSoulFxList_P3.get_Item(i), default, _actor.tsTransform.Position, default);
					}
				}
				if (_actor.logicVariable.GetLogicTagToggle("TriggerPersonalPerk_P1 "))
				{
					_actor.buffComponent.AddBuff(13903012, _actor);
				}
				else
				{
					_actor.buffComponent.AddBuff(13903011, _actor);
				}
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513904, out perkLevel))
			{
				_actor.buffComponent.AddBuff(13904011, _actor);
			}
			else
			{
				_actor.buffComponent.AddBuff(13994011, _actor);
			}
			if (CommonUtils.HavePersonalPerk(_actor.dataID, 513941, out perkLevel))
			{
				_actor.buffComponent.AddBuff(13941011, _actor);
			}
		}
		else
		{
			if (!string.Equals(eventName, "Event_139_Ultra1_Area"))
			{
				return;
			}
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_13901_Ultra1", _actor.tsTransform.Position, default, (AreaEffectEntity areaEffect) =>
			{
				if (CommonUtils.HavePersonalPerk(_actor.dataID, 513942, out var _))
				{
					areaEffect.ModifyScale(1 + CommonUtils.GetScriptValue(_actor, Config.parameterId_P42));
				}
			});
		}
	}

	private void OnActivationEnd()
	{
		BindSecondStageUltraSkill();
	}

	private void BindSecondStageUltraSkill()
	{
		if (_skill.skillId == 13940000 && ((PlayerAdventureActor)_actor).playerSkillCd.GetCurrentBindSkillId(ActionKey.D) != 13940001)
		{
			((PlayerAdventureActor)_actor).playerSkillCd.BindSkillIdToButton(ActionKey.D, 13940001);
			AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
			adventureActorCustomEvent.sender = _actor;
			adventureActorCustomEvent.actor = _actor;
			adventureActorCustomEvent.eventHashCode = Config.eventHashCode_ChangeUltraSkillStage;
			_actor.DispatchEvent(adventureActorCustomEvent);
			if (((PlayerAdventureActor)_actor).isAssist || (ModuleController<AdventureModuleController>.Instance.SemiAutoBattle && ModuleController<AdventureModuleController>.Instance.AutoCastUltimateSkill))
			{
				SetSkillPhaseConfig(SkillPhaseFeatureFlag.Ultimate, null, SkillPhaseFeatureFlag.Ultimate, null);
				ILRuntimeAPI.CreateSkill(13940001, _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End, null, null, ingoreCDAndEnergy: true);
			}
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
	}
}
