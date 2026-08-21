using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取掉落信息", 0)]
[Category("Logic/Config")]
[Description("获取掉落信息")]
public class GetDropItemData : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> idInput = AddValueInput<int>("ID");
		int buffConfigID = 0;
		AddValueOutput("buff配置ID", () => buffConfigID);
		int level = 0;
		AddValueOutput("等级", () => level);
		int param1 = 0;
		AddValueOutput("参数1", (ValueHandler<SimVar>)(() => param1), "");
		int param2 = 0;
		AddValueOutput("参数2", (ValueHandler<SimVar>)(() => param1), "");
		int param3 = 0;
		AddValueOutput("参数3", (ValueHandler<SimVar>)(() => param1), "");
		int param4 = 0;
		AddValueOutput("参数4", (ValueHandler<SimVar>)(() => param1), "");
		AddFlowInput("", delegate(Flow f)
		{
			BuffItem config = ConfigHelper.GetInstance().GetConfig<BuffItem>(idInput.value);
			buffConfigID = config.BuffId;
			level = config.Level;
			param1 = config.Param1;
			param2 = config.Param2;
			param3 = config.Param3;
			param4 = config.Param4;
			if (buffConfigID != 0)
			{
				output.Call(f);
			}
			else
			{
				Debug.LogError("掉落配置的buffID为0");
			}
		});
	}
}
