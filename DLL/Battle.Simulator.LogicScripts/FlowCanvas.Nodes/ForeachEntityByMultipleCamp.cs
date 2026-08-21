using System.Collections.Generic;
using Config;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历多重阵营实体", 0)]
[Category("Logic/Entity")]
[Description("遍历配置的全部阵营对应的实体")]
public class ForeachEntityByMultipleCamp : FlowControlNode
{
	[Name("角色阵营", 0)]
	public List<RoleType> RoleTypeList = new List<RoleType>();

	private int m_entityID;

	private bool _Break;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<List<RoleType>>().Serialize(ref writer, RoleTypeList, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		RoleTypeList = options.Resolver.GetFormatterWithVerify<List<RoleType>>().Deserialize(ref reader, options);
	}

	protected override void RegisterPorts()
	{
		FlowOutput doOutput = AddFlowOutput("Do", "do");
		FlowOutput doneOutput = AddFlowOutput("Done", "done");
		uint mask = 0u;
		for (int i = 0; i < RoleTypeList.Count; i++)
		{
			mask |= (uint)RoleTypeList[i];
		}
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (mask == 0)
			{
				doneOutput.Call(f);
			}
			else
			{
				_Break = false;
				f.breakCall = delegate
				{
					_Break = true;
				};
				SimEntity[] entities = base.mSimContext.GetEntities();
				SimEntity simEntity = null;
				for (int num = 0; num < entities.Length; num++)
				{
					m_entityID = 0;
					simEntity = entities[num];
					if (simEntity.hasEntityCamp && RoleCampProcessor.Is(mask, simEntity.entityCamp.mRoleTypeCamp) && simEntity.hasEntityRemotePlayer)
					{
						m_entityID = simEntity.creationIndex;
						doOutput.Call(f);
						if (_Break)
						{
							break;
						}
					}
				}
				doneOutput.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => m_entityID);
	}
}
