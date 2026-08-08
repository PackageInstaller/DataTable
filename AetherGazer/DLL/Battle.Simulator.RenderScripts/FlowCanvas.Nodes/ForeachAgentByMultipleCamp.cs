using System.Collections.Generic;
using Config;
using MessagePack;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历多重阵营实体(渲染)", 0)]
[Category("Render/Entity")]
[Description("遍历配置的全部阵营对应的实体")]
public class ForeachAgentByMultipleCamp : FlowControlNode
{
	[Name("角色阵营", 0)]
	public List<RoleType> RoleTypeList = new List<RoleType>();

	private int m_AgentID;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		RoleTypeList = options.Resolver.GetFormatter<List<RoleType>>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<List<RoleType>>().Serialize(ref writer, RoleTypeList, options);
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
				AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
				if (agentManager == null)
				{
					doneOutput.Call(f);
				}
				else
				{
					List<NAgent>.Enumerator enumerator = agentManager.Entities.GetEnumerator();
					while (enumerator.MoveNext())
					{
						NAgent current = enumerator.Current;
						m_AgentID = 0;
						if (RoleCampProcessor.Is(mask, current.Camp))
						{
							m_AgentID = current.AgentID;
							doOutput.Call(f);
						}
					}
					doneOutput.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "EntityID", () => m_AgentID);
	}
}
