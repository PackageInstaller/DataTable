using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.AI;

namespace NodeCanvas.Tasks.Actions;

[Name("Seek (Vector3)", 0)]
[Category("Movement/Pathfinding")]
public class MoveToPosition : ActionTask<NavMeshAgent>
{
	public BBParameter<Vector3> targetPosition;

	public BBParameter<float> speed = 4f;

	public BBParameter<float> keepDistance = 0.1f;

	private Vector3? lastRequest;

	protected override string info => "Seek " + targetPosition;

	protected override void OnExecute()
	{
		base.agent.speed = speed.value;
		if (Vector3.Distance(((Component)(object)base.agent).transform.position, targetPosition.value) < base.agent.stoppingDistance + keepDistance.value)
		{
			EndAction(success: true);
		}
	}

	protected override void OnUpdate()
	{
		if (lastRequest != targetPosition.value && !base.agent.SetDestination(targetPosition.value))
		{
			EndAction(success: false);
			return;
		}
		lastRequest = targetPosition.value;
		if (!base.agent.pathPending && base.agent.remainingDistance <= base.agent.stoppingDistance + keepDistance.value)
		{
			EndAction(success: true);
		}
	}

	protected override void OnPause()
	{
		OnStop();
	}

	protected override void OnStop()
	{
		if (lastRequest.HasValue && ((Component)(object)base.agent).gameObject.activeSelf)
		{
			base.agent.ResetPath();
		}
		lastRequest = null;
	}
}
