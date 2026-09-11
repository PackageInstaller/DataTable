using Config;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取词缀参数", 0)]
[Category("Logic/Trigger")]
[Description("获取词缀参数")]
public class GetAffixParam : FlowNode
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
		ValueInput<int> affixIDInput = AddValueInput<int>("词缀ID");
		ValueInput<int> levelInput = AddValueInput<int>("词缀等级");
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
			int value = affixIDInput.value;
			int value2 = levelInput.value;
			affix_type config = ConfigHelper.GetInstance().GetConfig<affix_type>(value);
			for (int j = 0; j < paramNumber; j++)
			{
				res[j] = config.Base.get_Item(j) + (value2 - 1) * config.Factor.get_Item(j);
			}
			f.Call(output);
		});
	}
}
