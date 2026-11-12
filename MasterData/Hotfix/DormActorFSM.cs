using System.Collections;
using UnityEngine;

public class DormActorFSM : IDormActorFSM
{
	protected int state;

	protected DormActor actor;

	public override int State => state;

	public DormActorFSM(DormActor actor, int state)
	{
		this.actor = actor;
		this.state = state;
	}

	public override void OnEnter(object data = null)
	{
	}

	public override void OnExit()
	{
	}

	public override void OnUpdate()
	{
	}

	protected Coroutine StartCoroutine(IEnumerator routine)
	{
		return actor.StartCoroutine(routine);
	}

	protected void StopCoroutine(Coroutine routine)
	{
		actor.StopCoroutine(routine);
	}
}
