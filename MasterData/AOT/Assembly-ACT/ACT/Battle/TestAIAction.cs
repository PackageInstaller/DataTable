using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class TestAIAction : Action
{
	public string name;

	public float duration;

	public TaskStatus result;

	private float time;

	public override void OnStart()
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log(name + " on start");
		}
		time = Time.time;
	}

	public override TaskStatus OnUpdate()
	{
		if (Time.time - time > duration)
		{
			return result;
		}
		return TaskStatus.Running;
	}

	public override void OnEnd()
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log(name + " on end");
		}
	}
}
