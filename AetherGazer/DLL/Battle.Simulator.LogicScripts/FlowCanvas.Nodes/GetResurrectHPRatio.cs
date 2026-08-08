using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取复活时的血量比例", 0)]
[Category("Logic/Spawn")]
[Description("获取复活时的血量比例")]
public class GetResurrectHPRatio : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> defaultValueInput = AddValueInput<int>("默认值").SetDefaultAndSerializedValue(100);
		AddValueOutput("比例", delegate
		{
			int num = CommonProcessor.GetWorldState().resurrectHP;
			if (num == 0)
			{
				num = defaultValueInput.value;
			}
			return num;
		});
	}
}
