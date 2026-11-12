using TrueSync;

namespace AIScript.Monster.Soldier._2501073;

public class Action_Summoned : AIBase
{
	private readonly FP durationTime = 5;

	private FP _durationTime;

	public void OnStart()
	{
		_durationTime = durationTime;
	}

	public void OnUpdate()
	{
		if (_durationTime > 0)
		{
			_durationTime -= _actor.LogicDeltaTime;
		}
		else
		{
			_actor.DestroySelf();
		}
	}

	public void OnStop()
	{
		_durationTime = 0;
	}
}
