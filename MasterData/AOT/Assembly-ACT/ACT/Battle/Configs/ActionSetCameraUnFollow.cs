using ACT.Battle.ECS.System;
using Fundamental;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("设置镜头取消跟随", "Action", new string[] { "set", "camera", "unfollow", "fov", "volume" })]
public class ActionSetCameraUnFollow : ConfigAction
{
	public CameraUnFollowedTime cameraUnFollowedTime;

	public override void Do(ActionMemory memory)
	{
		Singleton<GameManager>.instance.ecsManager.systemCamera.SetCameraUnFollow(cameraUnFollowedTime);
	}
}
