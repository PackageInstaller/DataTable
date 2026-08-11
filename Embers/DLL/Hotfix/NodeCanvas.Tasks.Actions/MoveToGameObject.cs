using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.AI;

namespace NodeCanvas.Tasks.Actions;

[Name("Seek (GameObject)", 0)]
[Category("Movement/Pathfinding")]
public class MoveToGameObject : ActionTask<NavMeshAgent>
{
	[RequiredField]
	public BBParameter<GameObject> target;

	public BBParameter<float> speed = 4f;

	public BBParameter<float> keepDistance = 0.1f;

	private Vector3? lastRequest;

	protected override string info => "Seek " + target;

	protected override void OnExecute()
	{
		if (target.value == null)
		{
			EndAction(success: false);
			return;
		}
		base.agent.speed = speed.value;
		if (Vector3.Distance(((Component)(object)base.agent).transform.position, target.value.transform.position) <= base.agent.stoppingDistance + keepDistance.value)
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
		if (lastRequest != position && !base.agent.SetDestination(position))
		{
			EndAction(success: false);
			return;
		}
		lastRequest = position;
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
		if (((Component)(object)base.agent).gameObject.activeSelf)
		{
			base.agent.ResetPath();
		}
		lastRequest = null;
	}

	public override void OnDrawGizmosSelected()
	{
		if (target.value != null)
		{
			Gizmos.DrawWireSphere(target.value.transform.position, keepDistance.value);
		}
	}
}
