using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._130;

public class Action_Summoned : AIBase
{
	private readonly FP useSkillInterval = 1;

	private readonly int skillId_SummonSkill = 100013004;

	private readonly FP durationTime = 6;

	private readonly FP useSkillDelay_Potential = 5;

	private readonly int skillId_SummonSkill_Potential = 100013005;

	private int _potentialLv;

	private FP _useSkillInterval;

	private FP _durationTime;

	private FP _useSkillDelay_Potential;

	public void OnStart()
	{
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_useSkillInterval = 0;
		_durationTime = durationTime;
		if (_potentialLv >= 2)
		{
			_useSkillDelay_Potential = useSkillDelay_Potential;
		}
		_actor.EnableInvincible();
		_actor.EnableCloseBlock();
		_actor.EnableSearchedImmunity();
	}

	public void OnUpdate()
	{
		if (_durationTime > 0)
		{
			if (_potentialLv >= 2)
			{
				if (_useSkillDelay_Potential > 0)
				{
					_useSkillDelay_Potential -= _actor.LogicDeltaTime;
				}
				else
				{
					ILRuntimeAPI.CreateSkill(skillId_SummonSkill_Potential, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false);
				}
			}
			if (_useSkillInterval > 0)
			{
				_useSkillInterval -= _actor.LogicDeltaTime;
			}
			else
			{
				ILRuntimeAPI.CreateSkill(skillId_SummonSkill, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false);
				_useSkillInterval = useSkillInterval;
			}
			_durationTime -= _actor.LogicDeltaTime;
		}
		else
		{
			_actor.DestroySelf();
		}
	}

	public void OnStop()
	{
		_actor.DisableInvincible();
		_actor.DisableCloseBlock();
		_actor.DisableSearchedImmunity();
	}
}
