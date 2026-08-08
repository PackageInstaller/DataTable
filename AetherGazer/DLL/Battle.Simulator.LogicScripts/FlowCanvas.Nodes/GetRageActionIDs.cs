using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取威吓动作(已过时)", 0)]
[Category("Logic/Config")]
[Description("获取威吓动作列表")]
public class GetRageActionIDs : CallableFunctionNode<List<int>, int>
{
	public override List<int> Invoke(int roleID)
	{
		RoleConfig config = ConfigHelper.GetInstance().GetConfig<RoleConfig>(roleID);
		List<int> list = new List<int>();
		foreach (int item in config.RageAbility)
		{
			list.Add(item);
		}
		return list;
	}
}
