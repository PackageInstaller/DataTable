using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取配置半径(Callable)", 0)]
[Category("Logic/Config")]
[Description("根据配置ID(例如2017)获取配置半径(例如500)")]
public class GetRadius : CallableFunctionNode<int, int>
{
	public override int Invoke(int roleID)
	{
		return ConfigHelper.GetInstance().GetConfig<RoleConfig>(roleID).Radius.get_Item(0);
	}
}
