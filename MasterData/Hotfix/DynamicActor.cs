using TrueSync;
using UnityEngine;

public class DynamicActor : AdventureActor
{
	public AdventureLevelObjPoolMgr.PoolObj spawnPoolObj;

	public FP MaxSpeed
	{
		get
		{
			return movAgent.maxSpeed;
		}
		set
		{
			movAgent.maxSpeed = value;
		}
	}

	public FP RotationSpeed
	{
		get
		{
			return movAgent.rotationSpeed;
		}
		set
		{
			movAgent.rotationSpeed = value;
		}
	}

	public FP Acceleration
	{
		get
		{
			return movAgent.acceleration;
		}
		set
		{
			movAgent.acceleration = value;
		}
	}

	public bool CanMove
	{
		get
		{
			return movAgent.canMove;
		}
		set
		{
			movAgent.canMove = value;
		}
	}

	public virtual void Recycle()
	{
		if (GroupId != null)
		{
			SceneSingleton<ActorGroupManager>.Instance.QueryEntityGroupByID(GroupId)?.RemoveMember(this);
		}
		if (spawnPoolObj == null)
		{
			Debug.LogError("回收角色时poolObj为空");
			return;
		}
		SceneSingleton<AdventureLevelObjPoolMgr>.Instance.En_Player(spawnPoolObj);
		spawnPoolObj = null;
	}

	public void EnableCollider()
	{
		collider.enabled = true;
	}

	public void DisableCollider()
	{
		collider.enabled = false;
	}
}
