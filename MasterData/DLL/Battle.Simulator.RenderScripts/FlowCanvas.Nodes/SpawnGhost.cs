using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("渲染挂件创建", 0)]
[Category("Render/Asset")]
[Description("创建渲染层挂件")]
public class SpawnGhost : FlowControlNode
{
	private ValueInput<int> m_agentIDVar;

	private ValueInput<string> m_pathVar;

	private ValueInput<bool> m_attachInput;

	private ValueInput<string> m_attachNameInput;

	private FlowOutput m_output;

	protected override void RegisterPorts()
	{
		m_agentIDVar = AddValueInput<int>("实体ID", "agentIDVar");
		m_pathVar = AddValueInput<string>("路径", "pathVar");
		m_attachInput = AddValueInput<bool>("挂载", "attach");
		m_attachNameInput = AddValueInput<string>("挂点名称", "attachName").SetDefaultAndSerializedValue(string.Empty);
		m_output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			GameObject gameObject = SpawnPendant.Create<RenderPendant>(m_agentIDVar.GetValue(), m_pathVar.GetValue(), m_attachInput.GetValue(), m_attachNameInput.value);
			if (gameObject != null)
			{
				RenderPendant com = gameObject.GetComponent<RenderPendant>();
				if (com != null && m_attachInput.value)
				{
					com.m_lateInitAction = delegate
					{
						com.transform.localPosition = Vector3.zero;
						com.transform.localRotation = Quaternion.identity;
						com.transform.localScale = Vector3.one;
					};
				}
			}
			m_output.Call(f);
		});
		AddValueOutput("实体ID", "agentID", () => m_agentIDVar.GetValue());
	}
}
