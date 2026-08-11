using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.AI;

namespace NodeCanvas.Tasks.Actions;

[Category("Movement/Pathfinding")]
[Description("Move Randomly or Progressively between various game object positions taken from the list provided")]
public class Patrol : ActionTask<NavMeshAgent>
{
	public enum PatrolMode
	{
		Progressive,
		Random
	}

	[RequiredField]
	[Tooltip("A list of gameobjects patrol points.")]
	public BBParameter<List<GameObject>> targetList;

	[Tooltip("The mode to use for patrol (progressive or random)")]
	public BBParameter<PatrolMode> patrolMode = PatrolMode.Random;

	public BBParameter<float> speed = 4f;

	public BBParameter<float> keepDistance = 0.1f;

	private int index = -1;

	private Vector3? lastRequest;

	protected override string info => $"{patrolMode} Patrol {targetList}";

	protected override void OnExecute()
	{
		if (targetList.value.Count == 0)
		{
			EndAction(success: false);
			return;
		}
		if (targetList.value.Count == 1)
		{
			index = 0;
		}
		else
		{
			if (patrolMode.value == PatrolMode.Random)
			{
				int num;
				for (num = index; num == index; num = Random.Range(0, targetList.value.Count))
				{
				}
				index = num;
			}
			if (patrolMode.value == PatrolMode.Progressive)
			{
				index = (int)Mathf.Repeat(index + 1, targetList.value.Count);
			}
		}
		GameObject gameObject = targetList.value[index];
		if (gameObject == null)
		{
			EndAction(success: false);
			return;
		}
		Vector3 position = gameObject.transform.position;
		base.agent.speed = speed.value;
		if ((((Component)(object)base.agent).transform.position - position).magnitude < base.agent.stoppingDistance + keepDistance.value)
		{
			EndAction(success: true);
		}
	}

	protected override void OnUpdate()
	{
		Vector3 position = targetList.value[index].transform.position;
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
		if (lastRequest.HasValue && ((Component)(object)base.agent).gameObject.activeSelf)
		{
			base.agent.ResetPath();
		}
		lastRequest = null;
	}

	public override void OnDrawGizmosSelected()
	{
		if (!(Object)(object)base.agent || targetList.value == null)
		{
			return;
		}
		foreach (GameObject item in targetList.value)
		{
			if (item != null)
			{
				Gizmos.DrawSphere(item.transform.position, 0.1f);
			}
		}
	}
}
