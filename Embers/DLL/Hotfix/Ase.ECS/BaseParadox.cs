using System;
using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public abstract class BaseParadox : IReference
{
	public int id;

	public GameObject treeObj;

	public BaseEntity ownerEntity;

	public Action<bool> endAction;

	public Action<BaseParadox> treePlayEnd;

	public bool OnStopIsReleaseAssets;

	public abstract void SetVariableValue<T>(string key, T data);

	public abstract T GetVariableValues<T>(string key);

	public virtual void Execute()
	{
	}

	public abstract void Pause();

	public abstract void Resume();

	public virtual void UpdateGraph(float deltaTime, float frozenSpeed)
	{
	}

	public virtual void Finish(bool finish)
	{
	}

	protected virtual void DoStop(bool isExecuteStopLogic = true)
	{
	}

	public virtual void RefreshBlack()
	{
	}

	public virtual void Stop(bool isForceStop, bool isExecuteStopLogic = true)
	{
		if (isForceStop)
		{
			treePlayEnd = null;
			DoStop(isExecuteStopLogic);
			FreeBack();
		}
		else
		{
			DoStop(isExecuteStopLogic);
		}
	}

	public void FreeBack()
	{
		if (!(treeObj == null))
		{
			treeObj.GetComponent<IPooledObject>()?.Free();
			ReferencePool.Release(this);
		}
	}

	public virtual void Clear()
	{
		treeObj = null;
		endAction = null;
		treePlayEnd = null;
	}
}
