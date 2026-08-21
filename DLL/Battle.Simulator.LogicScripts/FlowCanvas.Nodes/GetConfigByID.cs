using Google.Protobuf;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取配置信息", 0)]
[Category("Logic/Config")]
[Description("根据ID和类型获取配置信息")]
public class GetConfigByID<T> : FlowNode where T : IMessage
{
	protected override void RegisterPorts()
	{
		ValueInput<int> IDInput = AddValueInput<int>("ID");
		AddValueOutput("配置", () => ConfigHelper.GetInstance().GetConfig<T>(IDInput.value));
	}
}
