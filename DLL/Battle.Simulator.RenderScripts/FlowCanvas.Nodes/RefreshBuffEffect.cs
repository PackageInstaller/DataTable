using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("刷新实体buff表现", 0)]
[Category("Render/函数")]
[Description("刷新实体buff表现")]
public class RefreshBuffEffect : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<List<int>> ignoreBuffInput = AddValueInput<List<int>>("忽略刷新的BUFFClassID");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			BuffManager buffManager = BuffManager.GetBuffManager();
			if (buffManager == null)
			{
				output.Call(f);
			}
			else
			{
				buffManager.RefreshBuffEffectByEntityID(entityIDInput.value, ignoreBuffInput.value);
			}
		});
	}
}
