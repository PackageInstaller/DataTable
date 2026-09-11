using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[VHL]查询战术技能参数", 0)]
[Category("Common/Config")]
[Description("根据指定技能id，查询activity_reforge_skill对应条目的数据，3.0使用")]
[Color("ffffff")]
public class GetVHLSkillParam : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("id");
		ValueInput<List<int>> paramInput = AddValueInput<List<int>>("参数列表");
		FlowOutput output = AddFlowOutput("");
		FlowOutput outputError = AddFlowOutput("error");
		activity_reforge_skill config = null;
		AddValueOutput("技能CD", () => (config != null) ? config.Cd : 0);
		AddValueOutput("使用次数", () => (config != null) ? config.UseCount : 0);
		AddValueOutput("图标名", () => (config == null) ? string.Empty : config.Icon);
		AddFlowInput("", delegate(Flow f)
		{
			if (!ConfigHelper.GetInstance().TryGetConfig<activity_reforge_skill>(idInput.value, out config))
			{
				outputError.Call(f);
			}
			else
			{
				List<int> value = paramInput.value;
				if (value != null)
				{
					value.Clear();
					foreach (int item in config.Param)
					{
						value.Add(item);
					}
				}
				output.Call(f);
			}
		});
	}
}
