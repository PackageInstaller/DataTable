using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]增减当前技能CD(逻辑)", 0)]
[Category("Logic/Attribute")]
[Description("增减当前技能CD,该节点仅会修改CD大于0的值,默认可以超过CD最大值,可通过节点上的参数控制约束在最大值;\n参数\"千分之\"记录当前CD保留多少值;\n增量表示增加多少毫秒,填入负值可减少CD;\n当找不到实体时候走Error出口")]
public class ModifyABilityCDWithoutUsedCount2 : FlowControlNode
{
	public bool canMoreThanMaxCD = true;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(canMoreThanMaxCD);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		canMoreThanMaxCD = reader.ReadBoolean();
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "entityID");
		ValueInput<int> abilityIDInput = AddValueInput<int>("TimelineID", "timelineID");
		ValueInput<int> permillInput = AddValueInput<int>("千分之", "permill").SetDefaultAndSerializedValue(1000);
		ValueInput<int> incrementInput = AddValueInput<int>("增量(毫秒)", "addValue");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput none = AddFlowOutput("无CD", "none");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				error.Call(f);
			}
			else
			{
				int abilityID = CDProcessor.CheckAbilityIsAvoid(abilityIDInput.value);
				if (!entityWithEntityID.hasEntityCD || !CDProcessor.GetCD(entityWithEntityID, abilityID, out var abilityCD) || abilityCD.CD <= 0)
				{
					none.Call(f);
				}
				else
				{
					int num = IntMath.Divide(abilityCD.CD * permillInput.value, 1000) + incrementInput.value;
					if (num > 0)
					{
						if (CDProcessor.GetMaxCDAndMaxUseCount(entityWithEntityID, abilityID, out var maxCD, out var _) && !canMoreThanMaxCD && num > maxCD)
						{
							num = maxCD;
						}
						CDProcessor.SetCD(entityWithEntityID, abilityID, num, abilityCD.UsedCount);
					}
					else
					{
						CDProcessor.SetCD(entityWithEntityID, abilityID, 0, abilityCD.UsedCount);
					}
					output.Call(f);
				}
			}
		});
	}
}
