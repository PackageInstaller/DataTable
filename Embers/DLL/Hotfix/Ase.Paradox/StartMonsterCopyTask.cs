using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("执行小怪副本任务", 0)]
[Category("✫ DragonLost/Story")]
[Description("执行小怪副本任务。")]
public class StartMonsterCopyTask : ActionTaskBase
{
	protected override async void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetWorld().GetMapData()?.StartMonsterCopyTask();
		OnActionFinish();
	}
}
