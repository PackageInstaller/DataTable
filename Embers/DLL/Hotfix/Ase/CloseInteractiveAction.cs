using ParadoxNotion.Design;

namespace Ase;

[Name("关闭交互（多人交互使用）", 0)]
[Description("关闭多人交互时的交互图标。")]
[Category("✫ DragonLost/Interactive")]
public class CloseInteractiveAction : ActionTaskBase
{
	protected override async void OnExecute()
	{
		base.OnExecute();
		OnActionFinish();
	}
}
