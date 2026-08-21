using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("开启新手引导", 0)]
[Category("✫ DragonLost/Scene")]
[Description("开启新手引导")]
public class StartTeachGuideAction : ActionTaskBase
{
	[Name("引导Id", 0)]
	[Description("新手引导Id")]
	public int TeachGuideId;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity?.GetSystem<TeachGuideSystem>().OpenTeachGuideWindow(TeachGuideId, delayShow: false);
		OnActionFinish();
	}
}
