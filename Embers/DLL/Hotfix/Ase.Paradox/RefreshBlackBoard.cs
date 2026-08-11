using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("刷新黑板", 0)]
[Description("刷新当前行为树的黑板变量")]
[Category("✫ DragonLost/Operation")]
public class RefreshBlackBoard : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		base.blackboard?.RefreshVariables();
		EndAction();
	}
}
