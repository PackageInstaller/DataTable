using Config;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取buff数值", 0)]
[Category("Logic/Buff")]
[Description("获取buff数值")]
public class GetBuffData : FlowNode
{
	[GatherPortsCallback]
	public int paramNumber;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		paramNumber = reader.ReadInt32();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.WriteInt32(paramNumber);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> buffConfigIDInput = AddValueInput<int>("buff配置ID");
		ValueInput<int> levelInput = AddValueInput<int>("buff等级");
		int[] res = new int[paramNumber];
		ValueOutput<int>[] array = new ValueOutput<int>[paramNumber];
		for (int i = 0; i < paramNumber; i++)
		{
			int index = i;
			array[i] = AddValueOutput("数值" + i, () => res[index]);
		}
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			int value = buffConfigIDInput.value;
			int value2 = levelInput.value;
			public_buff config = ConfigHelper.GetInstance().GetConfig<public_buff>(value);
			if (paramNumber > config.BuffparamBase.Count)
			{
				Debug.Log("buff配置ID " + value + ", 参数数量不匹配");
			}
			else
			{
				for (int j = 0; j < paramNumber; j++)
				{
					res[j] = config.BuffparamBase.get_Item(j) + (value2 - 1) * config.BuffparamFactor.get_Item(j);
				}
				f.Call(output);
			}
		});
	}
}
