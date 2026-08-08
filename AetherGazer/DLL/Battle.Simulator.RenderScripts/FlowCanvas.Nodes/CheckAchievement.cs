using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("检查成就(已过时)", 0)]
[Category("Render/UI")]
[Description("检查成就")]
public class CheckAchievement : CallableFunctionNode<int, E_AchievementType>
{
	public override int Invoke(E_AchievementType type)
	{
		return -1;
	}
}
