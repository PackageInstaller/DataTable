using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase;

[Name("交互结果生效（多人交互使用）", 0)]
[Description("标记多人交互的结果生效。")]
[Category("✫ DragonLost/Interactive")]
public class FinishInteractiveAction : ActionTaskBase
{
	[Name("完成的实体ID", 0)]
	[Description("指定交互结果生效的实体ID。")]
	public BBParameter<int> finishedEntityId = new BBParameter<int>();

	protected override async void OnExecute()
	{
		base.OnExecute();
		GetOwnerEntity().GetComponent<BattleInteractiveStateComponent>().FinishInteractive(finishedEntityId.value);
		OnActionFinish();
	}
}
