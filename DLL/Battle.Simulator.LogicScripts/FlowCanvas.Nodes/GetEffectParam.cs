using Config;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取装备参数", 0)]
[Category("Common/Trigger")]
[Description("获取装备参数")]
public class GetEffectParam : FlowNode
{
	[GatherPortsCallback]
	public int paramNumber;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(paramNumber);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		paramNumber = reader.ReadInt32();
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> equipIDInput = AddValueInput<int>("装备ID");
		int[] res = new int[paramNumber];
		ValueOutput<int>[] array = new ValueOutput<int>[paramNumber];
		for (int i = 0; i < paramNumber; i++)
		{
			int index = i;
			array[i] = AddValueOutput("参数" + i, () => res[index]);
		}
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = equipIDInput.value;
			equip_effect config = ConfigHelper.GetInstance().GetConfig<equip_effect>(value);
			for (int j = 0; j < paramNumber; j++)
			{
				res[j] = config.Param.get_Item(j);
			}
			f.Call(output);
		});
	}
}
