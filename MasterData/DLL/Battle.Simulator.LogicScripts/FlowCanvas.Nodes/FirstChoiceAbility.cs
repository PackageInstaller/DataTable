using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("可以执行的技能", 0)]
[Category("Logic/Abilities")]
[Description("第一个可以执行的技能(后三位), 不在CD中且技能机制值足够, 不能填闪避")]
public class FirstChoiceAbility : FlowNode
{
	public List<int> abilitiesList = new List<int>();

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		abilitiesList = options.Resolver.GetFormatter<List<int>>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<List<int>>().Serialize(ref writer, abilitiesList, options);
	}

	protected override void RegisterPorts()
	{
		FlowOutput[] outputs = new FlowOutput[abilitiesList.Count];
		for (int i = 0; i < abilitiesList.Count; i++)
		{
			outputs[i] = AddFlowOutput(abilitiesList[i].ToString());
		}
		FlowOutput defaultOut = AddFlowOutput("Default");
		FlowOutput errorOut = AddFlowOutput("error");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		int entityID = 0;
		AddValueOutput("实体ID", () => entityID);
		ValueInput<int> pInput = AddValueInput<int>("概率").SetDefaultAndSerializedValue(100);
		AddFlowInput("", delegate(Flow f)
		{
			entityID = entityIDInput.value;
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityID);
			if (entityWithEntityID == null)
			{
				errorOut.Call(f);
			}
			else
			{
				int num = -1;
				int value = pInput.value;
				for (int j = 0; j < abilitiesList.Count; j++)
				{
					int abilityID = entityWithEntityID.entityConfig.mId * 1000 + abilitiesList[j];
					if (!CDProcessor.InCD(entityWithEntityID, abilityID))
					{
						int powerValue = AttributeProcessor.GetPowerValue(entityID);
						AttributeProcessor.TryGetEnergyChangeValue(base.mSimContext, entityID, abilityID, out var energyChangeValue, out var _);
						int num2 = -energyChangeValue;
						if (powerValue >= num2 && DRandom.Random(100u) < value)
						{
							num = j;
							break;
						}
					}
				}
				if (num == -1)
				{
					f.Call(defaultOut);
				}
				else
				{
					f.Call(outputs[num]);
				}
			}
		});
	}
}
