using AdventureBehaviour;

namespace AIScript.Monster.Soldier._30601;

public class Action : AIBase
{
	private readonly int skillId_SummonSkill1 = 103060101;

	public void OnStart()
	{
		_actor.EnableUnparalleled();
	}

	public void OnUpdate()
	{
		TryCastSummonSkill1();
	}

	public void OnStop()
	{
		_actor.DisableUnparalleled();
	}

	private void TryCastSummonSkill1()
	{
		if (skillId_SummonSkill1 != 0 && !_actor.actorSkillManage.HaveSkill(skillId_SummonSkill1))
		{
			ILRuntimeAPI.CreateSkill(skillId_SummonSkill1, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false);
		}
	}
}
