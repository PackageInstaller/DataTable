using System.Collections;
using UnityEngine;

public class DormFurObjFSM : IDormFurObjFSM
{
	protected int state;

	protected DormFurObj furObj;

	public override int State => state;

	public DormFurObjFSM(DormFurObj furObj, int state)
	{
		this.furObj = furObj;
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
		return furObj.StartCoroutine(routine);
	}

	protected void StopCoroutine(Coroutine routine)
	{
		furObj.StopCoroutine(routine);
	}
}
