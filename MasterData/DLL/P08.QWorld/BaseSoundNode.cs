using System;
using UnityEngine;

public abstract class BaseSoundNode : MonoBehaviour
{
	protected const int BaseIntervalTick = 10;

	protected const int MaxIntervalTick = 30;

	protected int intervalTick;

	protected int tickCount;

	public Guid guid { get; private set; }

	public BaseSoundNode()
	{
		guid = Guid.NewGuid();
	}

	private void OnEnable()
	{
		if (QWorldScene.Scene != null && QWorldScene.Scene.soundNodeMgr != null)
		{
			QWorldScene.Scene.soundNodeMgr.Register(this);
		}
	}

	private void OnDisable()
	{
		if (QWorldScene.Scene != null && QWorldScene.Scene.soundNodeMgr != null)
		{
			QWorldScene.Scene.soundNodeMgr.UnRegister(this);
		}
	}

	private void Start()
	{
		NodeStart();
		NodeProcess(forceInit: true);
	}

	public void UpdateNode()
	{
		if (tickCount < intervalTick)
		{
			tickCount++;
			return;
		}
		tickCount = 1;
		NodeProcess();
	}

	protected virtual void NodeStart()
	{
	}

	protected virtual void NodeProcess(bool forceInit = false)
	{
	}
}
