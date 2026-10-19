using System;
using System.Threading;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class TriggerActionRotateTo : TriggerActionBase
{
	public enum Direction
	{
		Up,
		Right,
		Forward
	}

	public Transform transform;

	public Direction faceDirection;

	public bool freezeX;

	public bool freezeY;

	public bool freezeZ;

	public float speed;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		if (!context.HasEntity && context.TargetObject == null)
		{
			return UniTask.CompletedTask;
		}
		Vector3 forward = (context.HasEntity ? context.Entity.GetCompTransform().physicsPosition : context.TargetObject.transform.position) - transform.position;
		Quaternion rotation = transform.rotation;
		Quaternion quaternion = Quaternion.LookRotation(forward, Vector3.up) * FaceTo();
		if (freezeX || freezeY || freezeZ)
		{
			Quaternion quaternion2 = quaternion * Quaternion.Inverse(rotation);
			quaternion = rotation * FreezeDirection(quaternion2);
		}
		transform.rotation = Quaternion.RotateTowards(transform.rotation, quaternion, speed * Time.deltaTime);
		return UniTask.CompletedTask;
	}

	private Quaternion FaceTo()
	{
		return faceDirection switch
		{
			Direction.Up => Quaternion.Euler(90f, 0f, 0f), 
			Direction.Right => Quaternion.Euler(0f, -90f, 0f), 
			Direction.Forward => Quaternion.identity, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
	}

	private Quaternion FreezeDirection(Quaternion quaternion)
	{
		Vector3 eulerAngles = quaternion.eulerAngles;
		if (freezeX)
		{
			eulerAngles.x = 0f;
		}
		if (freezeY)
		{
			eulerAngles.y = 0f;
		}
		if (freezeZ)
		{
			eulerAngles.z = 0f;
		}
		return Quaternion.Euler(eulerAngles);
	}
}
