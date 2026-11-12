using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._141;

public class Action_Summoned : AIBase
{
	private readonly FP duration_Skill1 = 5;

	private readonly int skillId_SummonSkill1 = 100014104;

	private FP _duration_Skill1;

	public void OnStart()
	{
		_duration_Skill1 = duration_Skill1;
		_actor.EnableUnparalleled();
		_actor.EnableSearchedImmunity();
		_actor.EnableCloseBlock();
	}

	public void OnUpdate()
	{
		if (_duration_Skill1 > 0)
		{
			if (!_actor.actorSkillManage.HaveSkill(skillId_SummonSkill1))
			{
				CreateSummonSkill(skillId_SummonSkill1);
			}
			_duration_Skill1 -= _actor.LogicDeltaTime;
		}
		else
		{
			_actor.DestroySelf();
		}
	}

	private bool CreateSummonSkill(int skillId)
	{
		if (skillId == 0)
		{
			return false;
		}
		return ILRuntimeAPI.CreateSkill(skillId, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false);
	}

	public void OnStop()
	{
		_actor.DisableUnparalleled();
		_actor.DisableSearchedImmunity();
		_actor.DisableCloseBlock();
		_duration_Skill1 = 0;
	}
}
