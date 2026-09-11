using UnityEngine;

namespace T0World;

public class T0CameraCtrlGameLogic : IQWCameraCtrlGameLogic
{
	private T0WorldCameraFlag flag;

	private T0WorldPlayer player;

	private bool isInit;

	private float raidus;

	public Vector3 CurDir => player.transform.forward;

	private bool TryInit()
	{
		if (!isInit)
		{
			T0WorldScene t0WorldScene = NScene.GetCurrentScene() as T0WorldScene;
			if (t0WorldScene != null && t0WorldScene.player != null)
			{
				player = t0WorldScene.player;
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
			player.SetRotation(dragDelta, deltaHeight);
			player.SetScroll(scroll);
		}
	}

	public void Init(QWCameraFlag flag)
	{
	}

	public void ResetCamera()
	{
		TryInit();
	}

	internal void SetDir(Vector3 dir)
	{
		player.SetDir(dir);
	}
}
