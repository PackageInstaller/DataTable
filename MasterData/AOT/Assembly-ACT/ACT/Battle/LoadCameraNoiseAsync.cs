using System;
using UnityEngine;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace ACT.Battle;

public class LoadCameraNoiseAsync
{
	public string name;

	public CameraNoiseType type;

	public Vector3 pos;

	public Vector3 velocity;

	public float force;

	public float sustainTime;

	public bool changeVelocityXZ;

	public Action<CameraNoiseType, string, Vector3, AsyncOperationHandle<GameObject>, Vector3, float, float, bool> Completed;

	public void OnCompleted(AsyncOperationHandle<GameObject> load)
	{
		if (Completed != null)
		{
			Completed(type, name, pos, load, velocity, sustainTime, force, changeVelocityXZ);
		}
		SystemAbility.s_LoadNoisePool.Release(this);
	}

	public void Reset()
	{
		type = CameraNoiseType.AttackBoxTrigger;
		name = string.Empty;
		pos = Vector3.zero;
		velocity = Vector3.zero;
		force = 0f;
		sustainTime = 0f;
		changeVelocityXZ = false;
		Completed = null;
	}
}
