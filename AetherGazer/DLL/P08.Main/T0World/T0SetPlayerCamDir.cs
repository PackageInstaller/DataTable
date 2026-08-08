using UnityEngine;

namespace T0World;

public class T0SetPlayerCamDir : T0InterationFunctionDataBase
{
	public enum Mode
	{
		WorldDir,
		MainCamDir
	}

	public Mode mode;

	public Quaternion rot;

	public T0WorldCameraFlag t0WorldCamera = T0WorldCameraFlag.Player;

	public void SetCamFwd()
	{
		IT0WorldUICamera useCamera = T0WorldCameraManager.Instance.GetUseCamera(t0WorldCamera);
		Vector3 vector = Vector3.forward;
		if (mode == Mode.MainCamDir)
		{
			vector = Camera.main.transform.forward;
		}
		else if (mode == Mode.WorldDir)
		{
			vector = rot * Vector3.forward;
		}
		Debug.DrawLine(Camera.main.transform.position, Camera.main.transform.position + 3f * (useCamera as T0WorldUICamera).Dir, Color.blue, 5f);
		Debug.DrawLine(Camera.main.transform.position, Camera.main.transform.position + 3f * vector, Color.yellow, 5f);
		useCamera.SetDir(vector);
	}

	public override void StartEvent(T0WorldInteractionBehavior _)
	{
		SetCamFwd();
		base.IsFinish = true;
	}
}
