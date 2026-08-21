using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取词缀标记buffID", 0)]
[Category("Logic/Trigger")]
[Description("获取词缀标记buffID")]
public class GetAffixBuffID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> affixIDInput = AddValueInput<int>("词缀ID");
		AddValueOutput("标记buffID", () => ConfigHelper.GetInstance().GetConfig<affix_type>(affixIDInput.value).AffixBuffId);
	}
}
