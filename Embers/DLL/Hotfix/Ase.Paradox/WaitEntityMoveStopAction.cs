using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("等待实体移动到目标结束", 0)]
[Description("等待实体移动到目标位置结束")]
[Category("✫ DragonLost/Transform")]
public class WaitEntityMoveStopAction : ActionTaskBase
{
	private PathfindingComponent _pathFindingComponent;

	protected override void OnExecute()
	{
		base.OnExecute();
		_pathFindingComponent = ownerEntity.GetComponent<PathfindingComponent>();
		if (_pathFindingComponent == null)
		{
			OnActionFail();
		}
	}

	protected override void OnUpdate()
	{
		if (!_pathFindingComponent.IsMoving)
		{
			OnActionFinish();
		}
	}
}
