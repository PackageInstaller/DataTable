using System.Collections.Generic;

namespace Capture.Runtime;

public class WorldManager
{
	private static WorldManager m_instance;

	private CaptureGameDataForExchange m_worldCtx;

	private List<CaptureLogicBase> logics;

	private bool isInitialize;

	public static WorldManager Instance => m_instance;

	public static ComponentsManager ComponentMgr => m_instance.m_worldCtx.componentMgr;

	public bool IsInitialized
	{
		get
		{
			return isInitialize;
		}
		private set
		{
		}
	}

	public void CloseWorld()
	{
		IsInitialized = false;
	}

	public CaptureGameDataForExchange GetGameContext()
	{
		return m_worldCtx;
	}

	public void Init(CaptureGameDataForExchange ctx)
	{
		m_worldCtx = ctx;
		m_instance = this;
		logics = new List<CaptureLogicBase>();
		logics.Add(new CameraLogic());
		logics.Add(new EntityLogic());
		logics.Add(new TaskLogic());
		LogicSystemInit();
		isInitialize = true;
	}

	private void LogicSystemInit()
	{
		LuaHelper.CallFunction("CaptureGameBridge.CaptureGameStart", m_worldCtx);
		for (int i = 0; i < logics.Count; i++)
		{
			logics[i].Init();
		}
	}

	public void Dispose()
	{
		for (int num = logics.Count - 1; num >= 0; num--)
		{
			logics[num].Dispose();
		}
		LuaHelper.CallFunction("CaptureGameBridge.CaptureGameStop");
		m_worldCtx = null;
		IsInitialized = false;
		m_instance = null;
	}

	public void Execute()
	{
		if (isInitialize)
		{
			for (int i = 0; i < logics.Count; i++)
			{
				logics[i].Execute();
			}
		}
	}

	public void FixedUpdate()
	{
		if (isInitialize)
		{
			for (int i = 0; i < logics.Count; i++)
			{
				logics[i].FixedUpdate();
			}
		}
	}

	public void LateUpdate()
	{
		if (isInitialize)
		{
			for (int i = 0; i < logics.Count; i++)
			{
				logics[i].LateUpdate();
			}
		}
	}
}
