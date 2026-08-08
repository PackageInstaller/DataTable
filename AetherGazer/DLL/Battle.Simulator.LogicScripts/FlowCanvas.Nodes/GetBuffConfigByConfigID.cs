using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到BUFF配置时间(配置ID)", 0)]
[Category("Logic/Config")]
[Description("根据配置ID得到buff配置时间")]
public class GetBuffConfigByConfigID : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> configIDInput = AddValueInput<int>("配置ID");
		AddValueOutput("时间", () => ConfigHelper.GetInstance().GetConfig<public_buff>(configIDInput.value).KeepTime);
	}
}
