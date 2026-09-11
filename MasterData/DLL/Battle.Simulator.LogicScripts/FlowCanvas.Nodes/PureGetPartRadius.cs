using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取指定部位的半径", 0)]
[Category("Logic/Config")]
[Description("根据配置ID(例如2017)获取指定部份(例如Body)的配置半径(例如500)")]
public class PureGetPartRadius : PureFunctionNode<int, int, ShapePartType>
{
	public override int Invoke(int roleID, ShapePartType part)
	{
		RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(roleID);
		for (int i = 0; i < config.ShapePartTypes.Count; i++)
		{
			if (config.ShapePartTypes.get_Item(i) == part)
			{
				return config.Radius.get_Item(i);
			}
		}
		return 0;
	}
}
