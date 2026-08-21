using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("切换交互物状态", 0)]
[Description("根据指定的目标状态切换交互物体的状态。")]
[Category("✫ DragonLost/Interactive")]
public class ChangeInteractiveStateAction : ActionTaskBase
{
	[Name("目标状态", 0)]
	[Description("要切换到的交互物体的目标状态。")]
	public BBParameter<MapItemState> targetState;

	protected override void OnExecute()
	{
		base.OnExecute();
		GetOwnerEntity().GetComponent<InteractiveStateComponent>()?.ChangeInteractiveState(targetState.value);
		OnActionFinish();
	}
}
