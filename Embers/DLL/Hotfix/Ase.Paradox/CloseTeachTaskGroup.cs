using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("关闭角色教学引导组", 0)]
[Category("✫ DragonLost/TeachGuide")]
[Description("直接关闭，不走成功或失败")]
public class CloseTeachTaskGroup : ActionTaskBase
{
	[Name("教学引导组Id", 0)]
	[Description("教学引导组Id")]
	public int teachGuideTaskId;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<TeachGuideSystem>()?.CloseTeachTask(teachGuideTaskId);
		EndAction();
	}
}
