using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("完成色教学引导组", 0)]
[Category("✫ DragonLost/TeachGuide")]
[Description("完成色教学引导组，走成功流程")]
public class FinishTeachTaskGroupAction : ActionTaskBase
{
	[Name("教学引导组Id", 0)]
	[Description("教学引导组Id")]
	public int teachGuideTaskId;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<TeachGuideSystem>()?.ForceFinshTaskGroup(teachGuideTaskId);
		EndAction();
	}
}
