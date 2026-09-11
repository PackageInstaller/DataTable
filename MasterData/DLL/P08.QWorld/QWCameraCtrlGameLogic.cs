public class QWCameraCtrlGameLogic : IQWCameraCtrlGameLogic
{
	private QWCameraFlag flag;

	private QWCharacterCamera characterCamera;

	private bool isInit;

	private float raidus;

	private bool TryInit()
	{
		if (!isInit)
		{
			QWorldScene qWorldScene = NScene.GetCurrentScene() as QWorldScene;
			if (qWorldScene != null && qWorldScene.Agent != null)
			{
				characterCamera = qWorldScene.Agent.GetComponent<QWCharacterCamera>();
				isInit = true;
			}
			return true;
		}
		return false;
	}

	public void UpdateLogic(float dragDelta, float deltaHeight, float scroll)
	{
		if (!TryInit())
		{
			characterCamera.SetRotation(dragDelta, deltaHeight, flag);
			characterCamera.SetScroll(scroll, flag);
		}
	}

	public void Init(QWCameraFlag flag)
	{
		this.flag = flag;
	}

	public void ResetCamera()
	{
		if (!TryInit())
		{
			QWAgentAction a = QWAgentActionFactory.Create(QWAgentAction.E_Type.Camera_Reset);
			characterCamera.OnCameraAction(a);
		}
	}
}
