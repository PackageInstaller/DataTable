using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace NodeCanvas.Tasks.Actions;

[Category("✫ Utility")]
[Description("Sends an event to all GraphOwners within range of the agent and over time like a shockwave.")]
public class ShoutEvent : ActionTask<Transform>
{
	[RequiredField]
	public BBParameter<string> eventName;

	public BBParameter<float> shoutRange = 10f;

	public BBParameter<float> completionTime = 1f;

	private GraphOwner[] owners;

	private bool[] receivedOwners;

	private float traveledDistance;

	protected override string info => $"Shout Event [{eventName.ToString()}]";

	protected override void OnExecute()
	{
		owners = Object.FindObjectsOfType<GraphOwner>();
		receivedOwners = new bool[owners.Length];
	}

	protected override void OnUpdate()
	{
		traveledDistance = Mathf.Lerp(0f, shoutRange.value, base.elapsedTime / completionTime.value);
		for (int i = 0; i < owners.Length; i++)
		{
			GraphOwner graphOwner = owners[i];
			if ((base.agent.position - graphOwner.transform.position).magnitude <= traveledDistance && !receivedOwners[i])
			{
				graphOwner.SendEvent(eventName.value, null, this);
				receivedOwners[i] = true;
			}
		}
		if (base.elapsedTime >= completionTime.value)
		{
			EndAction();
		}
	}

	public override void OnDrawGizmosSelected()
	{
		if (base.agent != null)
		{
			Gizmos.color = new Color(1f, 1f, 1f, 0.2f);
			Gizmos.DrawWireSphere(base.agent.position, traveledDistance);
			Gizmos.DrawWireSphere(base.agent.position, shoutRange.value);
		}
	}
}
