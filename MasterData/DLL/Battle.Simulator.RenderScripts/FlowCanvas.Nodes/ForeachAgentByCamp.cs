using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历阵营实体(渲染)", 0)]
[Category("Render/Entity")]
[Description("遍历配置的全部阵营对应的实体")]
public class ForeachAgentByCamp : FlowControlNode
{
	private int m_AgentID;

	private ValueInput<RoleType> _RoleTypeInput;

	private FlowOutput _DoOutput;

	private FlowOutput _DoneOutput;

	protected override void RegisterPorts()
	{
		_RoleTypeInput = AddValueInput<RoleType>("阵营", "camp");
		_DoOutput = AddFlowOutput("Do", "do");
		_DoneOutput = AddFlowOutput("Done", "done");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (_RoleTypeInput.GetValue() == RoleType.None)
			{
				_DoneOutput.Call(f);
			}
			else
			{
				AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
				if (agentManager == null)
				{
					_DoneOutput.Call(f);
				}
				else
				{
					uint value = (uint)_RoleTypeInput.GetValue();
					List<NAgent>.Enumerator enumerator = agentManager.Entities.GetEnumerator();
					while (enumerator.MoveNext())
					{
						NAgent current = enumerator.Current;
						m_AgentID = 0;
						if (RoleCampProcessor.Is(value, current.Camp))
						{
							m_AgentID = current.AgentID;
							_DoOutput.Call(f);
						}
					}
					_DoneOutput.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "EntityID", () => m_AgentID);
	}
}
