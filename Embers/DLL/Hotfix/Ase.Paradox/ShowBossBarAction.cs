using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("显示/隐藏Boss血条", 0)]
[Category("✫ Entity")]
[Description("显示或隐藏Boss血条。")]
public class ShowBossBarAction : ActionTaskBase
{
	[RequiredField]
	[Name("显示/隐藏", 0)]
	[Description("指示是否显示或隐藏Boss血条。")]
	public BBParameter<bool> isShow;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<BattleSystem>().ShowBossBarWindow(isShow.value);
		EndAction();
	}
}
