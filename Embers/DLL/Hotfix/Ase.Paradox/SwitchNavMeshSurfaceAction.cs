using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("切换寻路面", 0)]
[Description("多个NavMesh情况下，NavMeshSurface分别放在子节点上， “寻路面节点名”填子节点名字\n默认使用显示的那个，如果都显示使用第一个，如果都隐藏会失败")]
[Category("✫ DragonLost/Transform")]
public class SwitchNavMeshSurfaceAction : ActionTaskBase
{
	[Name("寻路面节点名", 0)]
	[Description("要切换到的 NavMeshSurface 节点名")]
	public BBParameter<string> NavMeshSurfaceName = "NavMesh-";

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity == null)
		{
			EndAction(success: false);
			return;
		}
		PathfindingSystem system = ownerEntity.GetSystem<PathfindingSystem>();
		if (system == null)
		{
			EndAction(success: false);
			return;
		}
		int num = system.SwitchNavMeshSurface(NavMeshSurfaceName.value);
		EndAction(num != 0);
	}
}
