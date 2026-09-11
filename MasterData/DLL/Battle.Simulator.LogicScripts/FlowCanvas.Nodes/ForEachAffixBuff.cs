using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历处理词缀buff", 0)]
[Category("Logic/Trigger")]
[Description("遍历处理词缀")]
public class ForEachAffixBuff : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> affixIDInput = AddValueInput<int>("词缀ID");
		ValueInput<int> levelInput = AddValueInput<int>("词缀等级");
		FlowOutput doOutput = AddFlowOutput("do");
		FlowOutput doneOutput = AddFlowOutput("done");
		int buffConfigID = 0;
		AddValueOutput("BUFF配置ID", () => buffConfigID);
		AddFlowInput("", delegate(Flow f)
		{
			_ = levelInput.value;
			affix_type config = ConfigHelper.GetInstance().GetConfig<affix_type>(affixIDInput.value);
			for (int i = 0; i < config.Buffid.Count; i++)
			{
				buffConfigID = config.Buffid.get_Item(i);
				f.Call(doOutput);
			}
			f.Call(doneOutput);
		});
	}
}
