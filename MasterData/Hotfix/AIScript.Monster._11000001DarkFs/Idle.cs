using System.Collections.Generic;

namespace AIScript.Monster._11000001DarkFs;

public class Idle : AIBase
{
	private Dictionary<int, string> skillTags = new Dictionary<int, string>
	{
		[0] = "Idle_1",
		[1] = "Idle_2",
		[2] = "Idle_3",
		[3] = "Idle_4"
	};

	public virtual void OnStart()
	{
	}

	public void OnStop()
	{
	}

	public void OnUpdate()
	{
		_actor.Action();
	}
}
