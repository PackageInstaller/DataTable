using System;
using System.Threading;
using P08.T0World.Locomotion;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationLookToEntity : T0InterationFunctionDataBase
{
	public int lookToEntityID;

	private CancellationTokenSource cancel;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		AddRotateEvent(behaviour);
	}

	public async void AddRotateEvent(T0WorldInteractionBehavior behaviour)
	{
		Transform trsByEntityID = T0WorldHelper.GetTrsByEntityID(lookToEntityID);
		GameObject gameObject = behaviour.gameObject;
		T0TimelineMoveBehaviour componentInChildren = gameObject.GetComponentInChildren<T0TimelineMoveBehaviour>();
		CancellationTokenSource cancel = (this.cancel = new CancellationTokenSource());
		Vector3 normalized = (trsByEntityID.position - gameObject.transform.position).normalized;
		Vector2 startVec = new Vector2(normalized.x, normalized.z);
		bool flag = await componentInChildren.TurnTargetDegree(startVec, cancel.Token);
		if (!cancel.IsCancellationRequested)
		{
			if (flag)
			{
				base.IsFinish = true;
			}
			this.cancel = null;
		}
	}
}
