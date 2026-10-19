using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行镜头Focus锁定", "Action", new string[] { "camera", "focus", "lock", "fov", "volume" })]
public class ActionCameraFocusLock : ConfigAction
{
	public bool lockCamera = true;

	public float transitionDuration = 0.3f;

	public override void Do(ActionMemory memory)
	{
		if (lockCamera)
		{
			Singleton<GameManager>.instance.ecsManager.systemCamera.SetFocusFixed();
		}
		else
		{
			Singleton<GameManager>.instance.ecsManager.systemCamera.SetFocusTransition(transitionDuration);
		}
	}
}
