using TrueSync;

namespace AIScript.PassiveSkill;

public class AmendAtkByMoveSpdAmend : PassiveSkillBase
{
	private FDP _atkPercentAmendFDP;

	protected override void OnSkillEnable()
	{
		_atkPercentAmendFDP = FDP.Zero;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_MOVESPEED_CHANGED", OnMoveSpeedChanged);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_MOVESPEED_CHANGED", OnMoveSpeedChanged);
	}

	private void OnMoveSpeedChanged(IEvent evt)
	{
		if (evt is AdventureActorMoveSpeedChangedEvent adventureActorMoveSpeedChangedEvent && adventureActorMoveSpeedChangedEvent.actorId == _actor.Id)
		{
			if (_atkPercentAmendFDP != FDP.Zero)
			{
				_actor.attributeList.ChangeValue(1, 2, -_atkPercentAmendFDP);
			}
			_atkPercentAmendFDP = _actor.attributeList.GetAttributeValue(HotfixEnum.effectAttributeType.MOVESPEED) / _actor.attributeList.GetOriginValue(HotfixEnum.effectAttributeType.MOVESPEED);
			_atkPercentAmendFDP -= FDP.One;
			if (_atkPercentAmendFDP != FDP.Zero)
			{
				_actor.attributeList.ChangeValue(1, 2, _atkPercentAmendFDP);
			}
		}
	}
}
