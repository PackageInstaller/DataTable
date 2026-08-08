using System.Collections.Generic;
using Config;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("当前技能的detail状态", 0)]
[Category("Logic/Abilities")]
[Description("判断当前技能状态是不是处于某个detail")]
public class AbilityCurrentStateDetail : FlowNode
{
	[SerializeField]
	[ExposeField]
	[DelayedField]
	private List<AbilityDetailClass> list = new List<AbilityDetailClass>();

	[GatherPortsCallback]
	public bool refreshPorts;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		list = options.Resolver.GetFormatter<List<AbilityDetailClass>>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<List<AbilityDetailClass>>().Serialize(ref writer, list, options);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		Dictionary<AbilityDetailClass, FlowOutput> outputList = new Dictionary<AbilityDetailClass, FlowOutput>();
		for (int i = 0; i < list.Count; i++)
		{
			outputList[list[i]] = AddFlowOutput(list[i].ToString());
		}
		FlowOutput defaultOutput = AddFlowOutput("Other");
		AddFlowInput("In", delegate(Flow f)
		{
			AbilityState abilityState = ConfigProcessor.GetAbilityState(base.mSimContext.GetEntityWithEntityID(entityIDInput.value));
			if (outputList.TryGetValue(abilityState.detailClass, out var value))
			{
				value.Call(f);
			}
			else
			{
				defaultOutput.Call(f);
			}
		});
	}
}
