using System.Collections;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.AI;

namespace FlowCanvas.Nodes;

[Category("Unity")]
[Description("Moves a NavMeshAgent object with pathfinding to target destination")]
public class MoveTo : LatentActionNode<NavMeshAgent, Vector3, float, float>
{
	private NavMeshAgent agent;

	public override IEnumerator Invoke(NavMeshAgent agent, Vector3 destination, float speed, float stoppingDistance)
	{
		this.agent = agent;
		agent.speed = speed;
		agent.stoppingDistance = stoppingDistance;
		if (agent.speed > 0f)
		{
			agent.SetDestination(destination);
		}
		else
		{
			agent.Warp(destination);
		}
		while (agent.pathPending || agent.remainingDistance > stoppingDistance)
		{
			yield return null;
		}
	}

	public override void OnBreak()
	{
		agent.ResetPath();
	}
}
