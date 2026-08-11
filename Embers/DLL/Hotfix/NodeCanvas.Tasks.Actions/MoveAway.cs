using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("Movement/Direct")]
[Description("Moves the agent away from target per frame without pathfinding")]
public class MoveAway : ActionTask<Transform>
{
	[RequiredField]
	public BBParameter<GameObject> target;

	public BBParameter<float> speed = 2f;

	public BBParameter<float> stopDistance = 3f;

	public bool waitActionFinish;

	protected override void OnUpdate()
	{
		if ((base.agent.position - target.value.transform.position).magnitude >= stopDistance.value)
		{
			EndAction();
			return;
		}
		base.agent.position = Vector3.MoveTowards(base.agent.position, target.value.transform.position, (0f - speed.value) * Time.deltaTime);
		if (!waitActionFinish)
		{
			EndAction();
		}
	}
}
