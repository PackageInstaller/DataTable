using AdventureBehaviour;

namespace AIScript.Trap._16510FengCao_Floral;

public class Action : AIBase
{
	private readonly int skillId;

	private static readonly int areaTag = CommonHelper.StringToHash("");

	public void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TRAP_COLLISION", OnEnterCollison);
	}

	public void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TRAP_COLLISION", OnEnterCollison);
	}

	private void OnEnterCollison(IEvent _evt)
	{
		if (_evt is AdventureTrapCollisionEvent { form: AreaEffectEntity form } adventureTrapCollisionEvent && adventureTrapCollisionEvent.to.Id == _actor.Id && form.CheckTag(areaTag))
		{
			ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.Monster, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, (bool success) =>
			{
			});
		}
	}
}
