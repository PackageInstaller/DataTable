using System;
using Config;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到钥从数值(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("获取buff数值")]
public class GetWeaponData : FlowNode
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
		ValueInput<int> configIDInput = AddValueInput<int>("钥从效果ID", "weaponeEffectID");
		ValueInput<int> levelInput = AddValueInput<int>("精炼等级", "level").SetDefaultAndSerializedValue(1);
		ValueOutput<int>[] array = new ValueOutput<int>[paramNumber];
		int[] res = new int[paramNumber];
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			int value = configIDInput.value;
			int value2 = levelInput.value;
			if (!ConfigHelper.GetInstance().TryGetConfig<weapon_effect>(value, out var config))
			{
				Debug.Log("钥从配置ID " + value + ", 无数据,请检查配置");
				errorOut.Call(f);
			}
			else if (paramNumber > config.LevelParam.Count)
			{
				Debug.Log("钥从配置ID " + value + ", 参数数量不匹配");
				errorOut.Call(f);
			}
			else
			{
				int num2 = Math.Clamp(value2, 1, 7);
				for (int i = 0; i < paramNumber; i++)
				{
					res[i] = config.LevelParam.get_Item(i).Data.get_Item(num2 - 1);
				}
				f.Call(output);
			}
		});
		for (int num = 0; num < paramNumber; num++)
		{
			int index = num;
			array[num] = AddValueOutput("数值" + num, () => res[index]);
		}
	}
}
