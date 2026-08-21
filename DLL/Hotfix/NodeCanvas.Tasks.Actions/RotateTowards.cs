using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("Movement/Direct")]
[Description("Rotate the agent towards the target per frame")]
public class RotateTowards : ActionTask<Transform>
{
	[RequiredField]
	public BBParameter<GameObject> target;

	public BBParameter<float> speed = 2f;

	[SliderField(1, 180)]
	public BBParameter<float> angleDifference = 5f;

	public BBParameter<Vector3> upVector = Vector3.up;

	public bool waitActionFinish;

	protected override void OnUpdate()
	{
		if (Vector3.Angle(target.value.transform.position - base.agent.position, base.agent.forward) <= angleDifference.value)
		{
			EndAction();
			return;
		}
		Vector3 vector = target.value.transform.position - base.agent.position;
		base.agent.rotation = Quaternion.LookRotation(Vector3.RotateTowards(base.agent.forward, vector, speed.value * Time.deltaTime, 0f), upVector.value);
		if (!waitActionFinish)
		{
			EndAction();
		}
	}
}
