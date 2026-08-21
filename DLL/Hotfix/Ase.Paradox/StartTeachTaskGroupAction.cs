using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("开启角色教学引导组", 0)]
[Category("✫ DragonLost/TeachGuide")]
[Description("强制覆盖当前教学")]
public class StartTeachTaskGroupAction : ActionTaskBase
{
	[Name("教学引导组Id", 0)]
	[Description("教学引导组Id")]
	public int teachGuideTaskId;

	[Name("是否需要暂停", 0)]
	[Description("在引导界面出现之前暂停游戏，等待界面出现")]
	public bool NeedPauseGame;

	protected override void OnExecute()
	{
		base.OnExecute();
		TeachGuideSystem system = ownerEntity.GetSystem<TeachGuideSystem>();
		if (system != null)
		{
			if (NeedPauseGame)
			{
				ownerEntity.GetWorld().GamePause();
			}
			system.StartNewTeach(teachGuideTaskId, coverCurrentTeach: true);
		}
		EndAction();
	}
}
