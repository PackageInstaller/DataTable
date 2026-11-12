using System;
using AdventureBehaviour;

namespace AIScript;

public class ActorActionBase : AIBase
{
	protected PlayerAdventureActor _player;

	protected PlayerSkillCd _playerSkillCd;

	private SkillPhaseFeatureFlag _skillPhaseFeatureFlag;

	private int _skillId;

	private bool tryCastRush;

	private bool isListenDodgeEndEvent;

	protected bool IsObstacleBetweenActorAndTargetAndPreventNormalAttack => ILRuntimeAPI.IsObstacleBetweenActorAndTargetAndPreventNormalAttack(_actor);

	public void OnEnable()
	{
		_player = _actor as PlayerAdventureActor;
		_playerSkillCd = _player?.playerSkillCd;
		OnActionEnable();
	}

	protected virtual void OnActionEnable()
	{
	}

	public virtual void OnStart()
	{
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_INPUT_ACTION_BUTTON_OPERATE", OnPlayerInput);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ASSIST_ACTOR_CASTSKILL", OnAssistActorCastSkill);
	}

	public virtual void OnStop()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_INPUT_ACTION_BUTTON_OPERATE", OnPlayerInput);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ASSIST_ACTOR_CASTSKILL", OnAssistActorCastSkill);
	}

	public void OnDisable()
	{
		OnActionDisable();
		_playerSkillCd = null;
	}

	protected virtual void OnActionDisable()
	{
	}

	private void OnSkillHaveAmount(IEvent evt)
	{
		if (evt is AdventureActorSkillHaveSectionAmountEvent adventureActorSkillHaveSectionAmountEvent && adventureActorSkillHaveSectionAmountEvent.actorId == _actor.dataID && _actor is PlayerAdventureActor playerAdventureActor && playerAdventureActor.playerAIInfo.DodgeId == adventureActorSkillHaveSectionAmountEvent.skillId)
		{
			OnDodgeSkillHaveAmount(adventureActorSkillHaveSectionAmountEvent.haveSectionAmount);
		}
	}

	protected virtual void OnDodgeSkillHaveAmount(bool haveSectionAmount)
	{
	}

	private void OnPlayerInput(IEvent evt)
	{
		if (!(_actor is BrickActor) && (_player == null || _player.isAssist))
		{
			return;
		}
		AdventureInputActionOperate adventureInputActionOperate = (AdventureInputActionOperate)evt;
		switch (adventureInputActionOperate.key)
		{
		case ActionKey.A:
			switch (adventureInputActionOperate.buttonState)
			{
			case ButtonState.Press:
				OnButtonAPress();
				break;
			case ButtonState.Hold:
				OnButtonAHold();
				break;
			case ButtonState.Click:
			case ButtonState.Cancel:
				OnButtonAClickOrCancel();
				break;
			}
			break;
		case ActionKey.B:
			switch (adventureInputActionOperate.buttonState)
			{
			case ButtonState.Press:
				OnButtonBPress();
				break;
			case ButtonState.Click:
			case ButtonState.Cancel:
				OnButtonBCancel();
				break;
			case ButtonState.Hold:
				break;
			}
			break;
		case ActionKey.C:
			switch (adventureInputActionOperate.buttonState)
			{
			case ButtonState.Press:
				OnButtonCPress();
				break;
			case ButtonState.Hold:
				OnButtonCHold();
				break;
			case ButtonState.Click:
			case ButtonState.Cancel:
				OnButtonCCancel();
				break;
			}
			break;
		case ActionKey.D:
			switch (adventureInputActionOperate.buttonState)
			{
			case ButtonState.Press:
				OnButtonDPress();
				break;
			case ButtonState.Hold:
				OnButtonDHold();
				break;
			case ButtonState.Click:
				OnButtonDClick();
				break;
			case ButtonState.Cancel:
				OnButtonDCancel();
				break;
			}
			break;
		}
	}

	protected virtual void OnButtonAPress()
	{
	}

	protected virtual void OnButtonAHold()
	{
	}

	protected virtual void OnButtonAClickOrCancel()
	{
	}

	protected virtual void OnButtonBPress()
	{
	}

	protected virtual void OnButtonBCancel()
	{
	}

	protected virtual void OnButtonCPress()
	{
		if (!_actor.forbiddenRush)
		{
			isListenDodgeEndEvent = false;
			_player.dodgeSkillActivationEndEvent = null;
			tryCastRush = true;
		}
	}

	protected virtual void OnButtonCCancel()
	{
	}

	protected virtual void OnButtonCHold()
	{
		if (!_actor.forbiddenRush)
		{
			if (tryCastRush)
			{
				tryCastRush = !CastIndependentRushSkill();
			}
			if (tryCastRush && !isListenDodgeEndEvent)
			{
				isListenDodgeEndEvent = true;
				_player.dodgeSkillActivationEndEvent = OnDodgeSkillActivationEnd;
			}
		}
	}

	private void OnDodgeSkillActivationEnd()
	{
		if (tryCastRush && _player.dodgeButtonHold)
		{
			tryCastRush = !CastIndependentRushSkill();
		}
	}

	protected virtual bool CastIndependentRushSkill()
	{
		if (_actor.logicVariable == null || _playerSkillCd == null)
		{
			return false;
		}
		return ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.C), _actor, SkillPhaseFeatureFlag.Skill2, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: true, SkillCountdownTiming.Start, null, null, ingoreCDAndEnergy: false, isRushJoinDodge: false);
	}

	protected virtual void OnButtonDPress()
	{
	}

	protected virtual void OnButtonDHold()
	{
	}

	protected virtual void OnButtonDClick()
	{
	}

	protected virtual void OnButtonDCancel()
	{
	}

	private void OnAssistActorCastSkill(IEvent evt)
	{
		AdventureAssistActorCastSkillEvent adventureAssistActorCastSkillEvent = (AdventureAssistActorCastSkillEvent)evt;
		if (adventureAssistActorCastSkillEvent.actorId == _actor.dataID && _playerSkillCd != null)
		{
			PlayerAdventureActor obj = _actor as PlayerAdventureActor;
			_actor.actorSkillManage?.DestoryAllSkill();
			if (adventureAssistActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.B)
			{
				_skillId = _playerSkillCd.GetCurrentBindSkillId(ActionKey.B);
				_skillPhaseFeatureFlag = SkillPhaseFeatureFlag.Skill1;
				OnCastSkill();
			}
			else if (adventureAssistActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
			{
				_skillId = _playerSkillCd.GetCurrentBindSkillId(ActionKey.D);
				_skillPhaseFeatureFlag = SkillPhaseFeatureFlag.Ultimate;
				OnCastUltimate();
			}
			obj.isAssistAIFinish = false;
			obj.isAssistStartLeave = false;
			obj.isAssistLeaving = false;
		}
	}

	protected virtual void OnCastSkill()
	{
		CastBindSkill(() =>
		{
			(_actor as PlayerAdventureActor).isAssistAIFinish = true;
		});
	}

	protected virtual void OnCastUltimate()
	{
		CastBindSkill(() =>
		{
			(_actor as PlayerAdventureActor).isAssistAIFinish = true;
		});
	}

	protected void CastBindSkill(Action finish = null)
	{
		CastSkill(_skillId, _skillPhaseFeatureFlag, finish);
	}

	protected void CastSkill(int skillId, SkillPhaseFeatureFlag skillPhaseFeatureFlag, Action finish)
	{
		ILRuntimeAPI.CreateSkill(skillId, _actor, skillPhaseFeatureFlag, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool result) =>
		{
			finish?.Invoke();
		});
	}

	private (ActionKey actionKey, SkillPhaseFeatureFlag skillPhaseFeatureFlag) GetActionKeyAndSkillTypeBySlotType(HotfixEnum.skillSlotType skillSlotType)
	{
		ActionKey item = ActionKey.None;
		SkillPhaseFeatureFlag item2 = SkillPhaseFeatureFlag.CertainSkillId;
		switch (skillSlotType)
		{
		case HotfixEnum.skillSlotType.A:
			item = ActionKey.A;
			item2 = SkillPhaseFeatureFlag.Dodge;
			break;
		case HotfixEnum.skillSlotType.B:
			item = ActionKey.B;
			item2 = SkillPhaseFeatureFlag.Skill1;
			break;
		case HotfixEnum.skillSlotType.C:
			item = ActionKey.C;
			item2 = SkillPhaseFeatureFlag.Skill2;
			break;
		case HotfixEnum.skillSlotType.D:
			item = ActionKey.D;
			item2 = SkillPhaseFeatureFlag.Ultimate;
			break;
		case HotfixEnum.skillSlotType.NORMAL:
			item = ActionKey.Normal;
			item2 = SkillPhaseFeatureFlag.Normal;
			break;
		}
		return (actionKey: item, skillPhaseFeatureFlag: item2);
	}
}
