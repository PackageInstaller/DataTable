using System.Collections.Generic;
using Config;
using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("判断多个buff是否存在", 0)]
[Category("Logic/Buff")]
[Description("判断多个buff是否存在,只要有一个存在, 就是true")]
public class HasTargetBuffs : FlowNode
{
	[SerializeField]
	[ExposeField]
	[DelayedField]
	private List<BuffClass> list = new List<BuffClass>();

	[GatherPortsCallback]
	public bool refreshPorts;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<List<BuffClass>>().Serialize(ref writer, list, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		list = options.Resolver.GetFormatter<List<BuffClass>>().Deserialize(ref reader, options);
	}

	public bool EntityHasBuffClass(SimEntity simEntity, BuffClass buffClass)
	{
		for (int i = 0; i < simEntity.entityBuff.mBuffClassIDArray.Count; i++)
		{
			if (!simEntity.entityBuff.IsInPendingRemoveArray(simEntity.entityBuff.mBuffID[i]) && simEntity.entityBuff.mBuffClassIDArray[i] == (int)buffClass)
			{
				return true;
			}
		}
		return false;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.GetValue());
			if (entityWithEntityID == null || !entityWithEntityID.hasEntityBuff)
			{
				falseOut.Call(f);
			}
			else
			{
				for (int i = 0; i < list.Count; i++)
				{
					if (EntityHasBuffClass(entityWithEntityID, list[i]))
					{
						trueOut.Call(f);
						return;
					}
				}
				falseOut.Call(f);
			}
		});
	}
}
