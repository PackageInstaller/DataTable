namespace Capture.Runtime;

public class CaptureScene : CaptureSceneLoader
{
	private WorldManager m_worldMgr;

	public WorldManager WorldMgr
	{
		get
		{
			if (m_worldMgr == null)
			{
				m_worldMgr = new WorldManager();
				m_worldMgr.CloseWorld();
			}
			return m_worldMgr;
		}
	}

	public override void OnSceneEnter()
	{
		base.OnSceneEnter();
		WorldMgr.Init(sceneCtx);
	}

	public override void OnSceneLoaded()
	{
		base.OnSceneLoaded();
		initialized = true;
	}

	public override void CloseLoadUI()
	{
		base.CloseLoadUI();
		LuaHelper.CallFunction("CaptureGameBridge.PreStartCaptureGame");
	}

	public override void OnSceneExit(NScene nextScene)
	{
		WorldMgr.Dispose();
		m_worldMgr = null;
		base.OnSceneExit(nextScene);
	}

	private void Update()
	{
		m_worldMgr?.Execute();
	}

	private void FixedUpdate()
	{
		m_worldMgr?.FixedUpdate();
	}

	private void LateUpdate()
	{
		SetUIProgress(Progress);
		m_worldMgr?.LateUpdate();
	}
}
