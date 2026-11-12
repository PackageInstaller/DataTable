using AdventureBehaviour;

namespace AIScript.Monster._13051GaoDa;

public class Action_Hand : AIBase
{
	private static readonly string changeFxAlias = "changeFx";

	private static readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.X };

	private ComboAttack _comboAttack;

	private int actionPhase;

	public void OnEnable()
	{
		actionPhase = 1;
		_actor.logicVariable.SetLogicTagValue("actorPositionX", _actor.tsTransform.Position.x);
		_actor.logicVariable.SetLogicTagValue("actorPositionY", _actor.tsTransform.Position.y);
		_actor.logicVariable.SetLogicTagValue("actorForwardX", _actor.tsTransform.Forward.x);
		_actor.logicVariable.SetLogicTagValue("actorForwardY", _actor.tsTransform.Forward.y);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("MONSTER_GAMDAM_MESSAGE", OnReceiveMessage);
	}

	public void OnDisable()
	{
		_comboAttack?.Clear();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("MONSTER_GAMDAM_MESSAGE", OnReceiveMessage);
	}

	private void OnReceiveMessage(IEvent evt)
	{
		if (!(evt is AdventureMonsterGundamMessage adventureMonsterGundamMessage) || adventureMonsterGundamMessage.monsterId != _actor.Id)
		{
			return;
		}
		if (adventureMonsterGundamMessage.operationType == "castSkill")
		{
			if (adventureMonsterGundamMessage.brokenOthers)
			{
				_actor.actorSkillManage.DestoryAllSkill();
			}
			_actor.InterruptAttack(force: true);
			_actor.logicVariable.SetLogicTagValue("skillType", adventureMonsterGundamMessage.skillType);
			_actor.logicVariable.ToggleLogicTag("isNextHandSkill", adventureMonsterGundamMessage.isNextHandSkill);
			_actor.logicVariable.SetLogicTagValue("handCount", adventureMonsterGundamMessage.handCount);
			_actor.logicVariable.SetLogicTagValue("bodyId", adventureMonsterGundamMessage.bodyId);
			_actor.logicVariable.SetLogicTagValue("actionPhase", adventureMonsterGundamMessage.actionPhase);
			_actor.logicVariable.SetLogicTagValue("cooperateType", adventureMonsterGundamMessage.cooperateType);
			actionPhase = adventureMonsterGundamMessage.actionPhase;
			CastSkill(adventureMonsterGundamMessage.skillId);
		}
		else if (adventureMonsterGundamMessage.operationType == "playFx")
		{
			new PlayFX().Play(_actor, null, changeFxAlias, _actor.tsTransform.PositionY, _actor.tsTransform.Position, _actor.tsTransform.Forward);
		}
		else if (adventureMonsterGundamMessage.operationType == "masterInAction")
		{
			_actor.logicVariable.SetLogicTagValue("bodyId", adventureMonsterGundamMessage.bodyId);
			_actor.PlayIdleAnim();
		}
		else if (adventureMonsterGundamMessage.operationType == "masterBeControl" && !_actor.actorSkillManage.HaveRunningSkill())
		{
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			_comboAttack.BeginAttack(_actor, null, actionKeys, flushInputedKeys: true, 0, forceInterruptAttack: true);
		}
	}

	private void CastSkill(int skillId)
	{
		ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: false, isBreakable: false, SkillCountdownTiming.Start, (bool result) =>
		{
			SendSkillFinishMessage();
		});
	}

	private void SendSkillFinishMessage()
	{
		AdventureMonsterGundamMessage adventureMonsterGundamMessage = AdventureMonsterGundamMessage.Generate();
		adventureMonsterGundamMessage.monsterId = _actor.Id;
		adventureMonsterGundamMessage.operationType = "skillFinish";
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureMonsterGundamMessage);
	}
}
