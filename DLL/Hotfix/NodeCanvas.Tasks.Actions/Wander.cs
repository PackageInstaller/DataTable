using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.AI;

namespace NodeCanvas.Tasks.Actions;

[Category("Movement/Pathfinding")]
[Description("Makes the agent wander randomly within the navigation map")]
public class Wander : ActionTask<NavMeshAgent>
{
	[Tooltip("The speed to wander with.")]
	public BBParameter<float> speed = 4f;

	[Tooltip("The distance to keep from each wander point.")]
	public BBParameter<float> keepDistance = 0.1f;

	[Tooltip("A wander point can't be closer than this distance")]
	public BBParameter<float> minWanderDistance = 5f;

	[Tooltip("A wander point can't be further than this distance")]
	public BBParameter<float> maxWanderDistance = 20f;

	[Tooltip("If enabled, will keep wandering forever. If not, only one wander point will be performed.")]
	public bool repeat = true;

	protected override void OnExecute()
	{
		base.agent.speed = speed.value;
		DoWander();
	}

	protected override void OnUpdate()
	{
		if (!base.agent.pathPending && base.agent.remainingDistance <= base.agent.stoppingDistance + keepDistance.value)
		{
			if (repeat)
			{
				DoWander();
			}
			else
			{
				EndAction();
			}
		}
	}

	private void DoWander()
	{
		float value = minWanderDistance.value;
		float value2 = maxWanderDistance.value;
		value = Mathf.Clamp(value, 0.01f, value2);
		value2 = Mathf.Clamp(value2, value, value2);
		Vector3 vector = ((Component)(object)base.agent).transform.position;
		while ((vector - ((Component)(object)base.agent).transform.position).magnitude < value)
		{
			vector = Random.insideUnitSphere * value2 + ((Component)(object)base.agent).transform.position;
		}
		NavMeshHit val = default(NavMeshHit);
		if (NavMesh.SamplePosition(vector, ref val, base.agent.height * 2f, -1))
		{
			base.agent.SetDestination(((NavMeshHit)(ref val)).position);
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
