using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.AI;

namespace NodeCanvas.Tasks.Actions;

[Category("Movement/Pathfinding")]
[Description("Flees away from the target")]
public class Flee : ActionTask<NavMeshAgent>
{
	[RequiredField]
	[Tooltip("The target to flee from.")]
	public BBParameter<GameObject> target;

	[Tooltip("The speed to flee.")]
	public BBParameter<float> speed = 4f;

	[Tooltip("The distance to flee at.")]
	public BBParameter<float> fledDistance = 10f;

	[Tooltip("A distance to look away from the target for valid flee destination.")]
	public BBParameter<float> lookAhead = 2f;

	protected override string info => $"Flee from {target}";

	protected override void OnExecute()
	{
		if (target.value == null)
		{
			EndAction(success: false);
			return;
		}
		base.agent.speed = speed.value;
		if ((((Component)(object)base.agent).transform.position - target.value.transform.position).magnitude >= fledDistance.value)
		{
			EndAction(success: true);
		}
	}

	protected override void OnUpdate()
	{
		if (target.value == null)
		{
			EndAction(success: false);
			return;
		}
		Vector3 position = target.value.transform.position;
		if ((((Component)(object)base.agent).transform.position - position).magnitude >= fledDistance.value)
		{
			EndAction(success: true);
			return;
		}
		Vector3 destination = position + (((Component)(object)base.agent).transform.position - position).normalized * (fledDistance.value + lookAhead.value + base.agent.stoppingDistance);
		if (!base.agent.SetDestination(destination))
		{
			EndAction(success: false);
		}
	}

	protected override void OnPause()
	{
		OnStop();
	}

	protected override void OnStop()
	{
		if (((Component)(object)base.agent).gameObject.activeSelf)
		{
			base.agent.ResetPath();
		}
	}
}
