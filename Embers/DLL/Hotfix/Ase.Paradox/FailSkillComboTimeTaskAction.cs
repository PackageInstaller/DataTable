using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("失败技能连招教学或者计时教学", 0)]
[Category("✫ DragonLost/TeachGuide")]
[Description("失败技能连招教学或者计时教学，走失败流程")]
public class FailSkillComboTimeTaskAction : ActionTaskBase
{
	[Name("教学组类型", 0)]
	[Description("教学组类型3为技能连招 4为计时任务")]
	public int taskGroupType;

	protected override void OnExecute()
	{
		base.OnExecute();
		TeachGuideSystem system = ownerEntity.GetSystem<TeachGuideSystem>();
		if (system != null)
		{
			if (taskGroupType == 3)
			{
				system.ForceCurrentSkillComboFail();
			}
			else if (taskGroupType == 4)
			{
				system.SetTimeTaskFinish(isSuccess: false);
			}
		}
		EndAction();
	}
}
