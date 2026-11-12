using UnityEngine;

namespace AIScript.Monster.Activity.BreakOut;

public class BreakOut_Idle : AIBase
{
	public void OnEnable()
	{
	}

	public void OnStart()
	{
		_actor.Action();
		Debug.Log("进入idle");
	}

	public void OnUpdate()
	{
	}
}
