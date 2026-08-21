using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("Movement/Direct")]
[Description("Move & turn the agent based on input values provided ranging from -1 to 1, per second (using delta time)")]
public class InputMove : ActionTask<Transform>
{
	[BlackboardOnly]
	public BBParameter<float> strafe;

	[BlackboardOnly]
	public BBParameter<float> turn;

	[BlackboardOnly]
	public BBParameter<float> forward;

	[BlackboardOnly]
	public BBParameter<float> up;

	public BBParameter<float> moveSpeed = 1f;

	public BBParameter<float> rotationSpeed = 1f;

	public bool repeat;

	protected override void OnUpdate()
	{
		Quaternion b = base.agent.rotation * Quaternion.Euler(Vector3.up * turn.value * 10f);
		base.agent.rotation = Quaternion.Slerp(base.agent.rotation, b, rotationSpeed.value * Time.deltaTime);
		Vector3 vector = base.agent.forward * forward.value * moveSpeed.value * Time.deltaTime;
		Vector3 vector2 = base.agent.right * strafe.value * moveSpeed.value * Time.deltaTime;
		Vector3 vector3 = base.agent.up * up.value * moveSpeed.value * Time.deltaTime;
		base.agent.position += vector2 + vector + vector3;
		if (!repeat)
		{
			EndAction();
		}
	}
}
