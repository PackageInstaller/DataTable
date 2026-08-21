using System.Collections.Generic;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("判断正在执行或将执行的技能ID(后3位)", 0)]
[Category("Logic/Abilities")]
[Description("获取指定实体正在执行的ability,实体为空或者没有执行技能的都走default")]
public class SwitchActionAbility : FlowNode
{
	[SerializeField]
	[ExposeField]
	[GatherPortsCallback]
	[MinValue(2)]
	[DelayedField]
	private int _portCount = 4;

	[SerializeField]
	[ExposeField]
	[DelayedField]
	private List<int> list = new List<int>();

	[GatherPortsCallback]
	public bool refreshPorts;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		_portCount = reader.ReadInt32();
		list = options.Resolver.GetFormatter<List<int>>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(_portCount);
		options.Resolver.GetFormatter<List<int>>().Serialize(ref writer, list, options);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		int res = 0;
		AddValueOutput("结果", () => res);
		FlowOutput[] cases = new FlowOutput[_portCount];
		if (list.Count == _portCount)
		{
			for (int num = 0; num < cases.Length; num++)
			{
				cases[num] = AddFlowOutput(list[num].ToString());
			}
		}
		FlowOutput defaultCase = AddFlowOutput("Default");
		AddFlowInput("In", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
			if (entityWithEntityID == null)
			{
				f.Call(defaultCase);
			}
			else
			{
				res = CommonNodeFunction.GetCurrentShortAbilityID(entityWithEntityID);
				if (res == 0)
				{
					res = CommonNodeFunction.GetNextShortAbilityID(entityWithEntityID);
				}
				for (int i = 0; i < list.Count; i++)
				{
					if (list[i] == res)
					{
						f.Call(cases[i]);
						return;
					}
				}
				f.Call(defaultCase);
			}
		});
	}
}
