using ACT.Battle;
using ACT.Battle.Configs;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;

namespace ACT.World.Actions;

public class RobotSetActive : InteractAction
{
	public bool closeRobot;

	protected override AbilityAuth auth => AbilityAuth.Both;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
	{
		if (MonoECS.instance.localPlayer.robotEntity.IsValid)
		{
			MonoECS.instance.RobotActive(!closeRobot);
		}
		return UniTask.CompletedTask;
	}
}
