using System;
using System.Collections;
using ACT.BluePrint;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace ACT.Battle;

public class ActBehaviorTree : BehaviorTree
{
	public bool running;

	private static WaitForFixedUpdate _waitForFixedUpdate = new WaitForFixedUpdate();

	public Entity Entity { get; private set; }

	public void OnSpawn(Entity entity, SpawnMonsterParams smp = null)
	{
		Entity = entity;
		AsynchronousLoad = false;
		if (smp != null && !string.IsNullOrEmpty(smp.bornBehaviorName))
		{
			SharedString sharedString = new SharedString();
			sharedString.SetValue(smp.bornBehaviorName);
			sharedString.IsShared = true;
			SetVariable("要执行的出生行为", sharedString);
		}
		BehaviorManager.instance.EnableBehavior(this);
	}

	internal void Stop()
	{
		BehaviorManager.instance.DisableBehavior(this, paused: false);
	}

	internal void Pause()
	{
		StartCoroutine(PauseBehavior());
	}

	private IEnumerator PauseBehavior()
	{
		while (ExecutionStatus == TaskStatus.Inactive)
		{
			yield return _waitForFixedUpdate;
		}
		BehaviorManager.instance.DisableBehavior(this, paused: true);
	}

	internal void Resume()
	{
		BehaviorManager.instance.EnableBehavior(this);
	}

	internal void Restart()
	{
		BehaviorManager.instance.RestartBehavior(this);
	}

	public bool IsPausedBehavior()
	{
		return BehaviorManager.instance.IsBehaviorEnabled(this);
	}

	public void Tick()
	{
		try
		{
			BehaviorManager.instance.Tick(this);
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
	}

	public void SetEntity(Entity entity)
	{
		Entity = entity;
	}
}
