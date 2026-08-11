using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("寻路结束", 0)]
[Description("当寻路到达目标或被取消时，执行此动作来停止寻路。")]
[Category("✫ DragonLost/Transform")]
public class PathfindingEnd : ActionTaskBase
{
	private PathfindingComponent pathfindingComponent;

	protected override void OnExecute()
	{
		base.OnExecute();
		pathfindingComponent = ownerEntity.GetComponent<PathfindingComponent>();
		if (pathfindingComponent == null)
		{
			OnActionFail();
			return;
		}
		pathfindingComponent.NavMeshStop();
		ownerEntity.GetComponent<SurroundRotateComponent>()?.ShieldAll();
		OnActionFinish();
	}
}
