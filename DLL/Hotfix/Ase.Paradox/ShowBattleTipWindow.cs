using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("显示战斗提示窗", 0)]
[Category("✫ Entity")]
[Description("显示战斗提示窗")]
public class ShowBattleTipWindow : ActionTaskBase
{
	[RequiredField]
	[Name("显示帧数", 0)]
	[Description("显示提示窗的时长。")]
	public int ShowFrame;

	[RequiredField]
	[Name("显示内容", 0)]
	[Description("显示提示窗的内容。")]
	public string ShowContent;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<BattleSystem>().ShowBattleTipsWindow((float)ShowFrame * 0.0333f, ShowContent);
		EndAction();
	}
}
