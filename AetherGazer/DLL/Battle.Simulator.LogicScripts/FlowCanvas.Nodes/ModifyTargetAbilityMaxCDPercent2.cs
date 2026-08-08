using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[CD]修改CD上限(千分比)(ID组)", 0)]
[Category("Logic/Attribute")]
[Description("修改一组技能的CD上限(千分比), 只能加减;\n减少传入【负数】")]
public class ModifyTargetAbilityMaxCDPercent2 : FlowControlNodeOfLogic
{
	[Name("ID组(后三位)", 0)]
	public List<int> m_actionIDs = new List<int>();

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		m_actionIDs = options.Resolver.GetFormatter<List<int>>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<List<int>>().Serialize(ref writer, m_actionIDs, options);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> addValueInput = AddValueInput<int>("增量", "addValue");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityConfig || !entityWithEntityID.hasEntityCD)
			{
				errorOut.Call(f);
			}
			else
			{
				for (int i = 0; i < m_actionIDs.Count; i++)
				{
					int num = entityWithEntityID.entityConfig.mId * 1000 + m_actionIDs[i];
					int num2 = 0;
					if (!entityWithEntityID.entityCD.mAbilityMaxCD.TryGetValue(num, out var value))
					{
						if (!ConfigProcessor.TryGetCDConfig(entityWithEntityID, num, out var cd, out var _))
						{
							Debug.LogError(base.graph.name + " 中的【[CD]修改CD上限(千分比)(ID组)】 找不到 " + num + " 的配置");
							continue;
						}
						num2 = 0;
						value.baseValue = cd;
					}
					else
					{
						num2 = value.deltaPercent;
					}
					num2 += addValueInput.value;
					value.deltaPercent = num2;
					entityWithEntityID.entityCD.mAbilityMaxCD[num] = value;
				}
				f.Call(output);
			}
		});
		AddValueOutput("实体ID", () => entityIDInput.value);
	}
}
