using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("检查成就(直接传值)(已过时)", 0)]
[Category("Render/UI")]
[Description("检查成就")]
public class CheckAchievementByValue : CallableFunctionNode<int, E_AchievementType, int>
{
	public override int Invoke(E_AchievementType type, int count)
	{
		return -1;
	}
}
