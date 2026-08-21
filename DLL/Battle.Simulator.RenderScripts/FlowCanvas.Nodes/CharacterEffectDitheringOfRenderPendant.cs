using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("隐身特效开关(渲染挂件)", 0)]
[Category("Render/CharacterEffect")]
[Description("隐身特效开关")]
public class CharacterEffectDitheringOfRenderPendant : FlowControlNodeOfRender
{
	private ValueInput<int> m_agentIDInput;

	private ValueInput<int> _renderPendantIDInput;

	private FlowOutput m_output;

	private RenderPendant _renderPendant;

	protected override void RegisterPorts()
	{
		m_agentIDInput = AddValueInput<int>("实体ID", "AgentID");
		_renderPendantIDInput = AddValueInput<int>("渲染挂件索引", "pendantID");
		ValueInput<bool> activeInput = AddValueInput<bool>("隐身", "active");
		AddValueOutput("实体ID", "AgentID", () => m_agentIDInput.GetValue());
		AddValueOutput("渲染挂件索引", "pendantID", () => _renderPendantIDInput.value);
		AddValueOutput("渲染挂件", "ghost", () => _renderPendant);
		m_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(m_agentIDInput.GetValue());
			_renderPendant = null;
			if (agent != null)
			{
				List<IPendant>.Enumerator enumerator = agent.gameObject.GetComponent<ComponentPendant>().GetPendants().GetEnumerator();
				while (enumerator.MoveNext())
				{
					_renderPendant = enumerator.Current as RenderPendant;
					if (_renderPendant != null && _renderPendant.PendantID == _renderPendantIDInput.value)
					{
						_renderPendant.SetHideEffect(activeInput.value);
					}
				}
			}
			m_output.Call(f);
		});
	}
}
