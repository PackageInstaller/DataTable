using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._137;

public class Action_Summoned : AIBase
{
	private static readonly FP durationTime = 3;

	private const int skillId_SummonSkill = 100013704;

	private static readonly FP useSkillInterval = 1;

	private FP _durationTime;

	private FP _useSkillInterval;

	public void OnStart()
	{
		_durationTime = durationTime;
		_useSkillInterval = 0;
		_actor.EnableUnparalleled();
		_actor.EnableCloseBlock();
	}

	public void OnUpdate()
	{
		if (_durationTime > 0)
		{
			_durationTime -= _actor.LogicDeltaTime;
			if (_useSkillInterval > 0)
			{
				_useSkillInterval -= _actor.LogicDeltaTime;
				return;
			}
			ILRuntimeAPI.CreateSkill(100013704, _actor, SkillPhaseFeatureFlag.CertainSkillId, SkillLauncherType.DynamicActor, isInterruptAttack: true, isBreakable: false);
			_useSkillInterval = useSkillInterval;
		}
		else
		{
			_actor.DestroySelf();
		}
	}

	public void OnStop()
	{
		_actor.DisableUnparalleled();
		_actor.DisableCloseBlock();
		_durationTime = 0;
	}
}
