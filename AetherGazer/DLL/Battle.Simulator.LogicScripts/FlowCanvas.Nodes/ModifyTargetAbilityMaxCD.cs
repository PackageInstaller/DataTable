using MessagePack;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[CD]修改单个CD上限(毫秒)", 0)]
[Category("Logic/Attribute")]
[Description("修改单个CD上限(毫秒), 只能加减;\n减少传入【负数】")]
public class ModifyTargetAbilityMaxCD : FlowNode
{
	[HideInInspector]
	public OperationMethod operation;

	public override string name => string.Format("{0}{1}{2}", base.name, OperationTools.GetOperationString(operation), "Value");

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		operation = (OperationMethod)reader.ReadInt32();
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.WriteInt32((int)operation);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<int> abilityIDInput = AddValueInput<int>("技能ID");
		ValueInput<int> valueInput = AddValueInput<int>("Value");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID != null && entityWithEntityID.hasEntityCD)
			{
				int value = abilityIDInput.value;
				int num = 0;
				if (!entityWithEntityID.entityCD.mAbilityMaxCD.TryGetValue(value, out var value2))
				{
					ConfigProcessor.TryGetCDConfig(entityWithEntityID, value, out var cd, out var _);
					num = 0;
					value2.baseValue = cd;
				}
				else
				{
					num = value2.deltaValue;
				}
				num = OperationTools.Operate(num, valueInput.value, operation);
				value2.deltaValue = num;
				entityWithEntityID.entityCD.mAbilityMaxCD[value] = value2;
			}
			f.Call(output);
		});
	}
}
