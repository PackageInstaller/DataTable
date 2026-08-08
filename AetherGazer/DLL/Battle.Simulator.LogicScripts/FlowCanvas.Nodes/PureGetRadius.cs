using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取配置半径", 0)]
[Category("Test")]
[Description("根据配置ID(例如2017)获取配置半径(例如500)")]
public class PureGetRadius : PureFunctionNode<int, int>
{
	public override int Invoke(int roleID)
	{
		return ConfigHelper.GetInstance().GetConfig<RoleConfig>(roleID).Radius.get_Item(0);
	}
}
