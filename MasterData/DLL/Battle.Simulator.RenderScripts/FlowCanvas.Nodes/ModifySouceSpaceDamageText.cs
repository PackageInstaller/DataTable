using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("修改修正模式伤害文本(渲染)", 0)]
[Category("Render/SourceSpace")]
[Description("得到修正模式中累积受到的全部伤害(仅减少值记录)")]
public class ModifySouceSpaceDamageText : FlowControlNode
{
	private ValueInput<GameObject> m_resourceInput;

	private ValueInput<float> m_keepTimeInput;

	private ValueInput<int> m_agentIDInput;

	private FlowOutput m_out;

	private FlowOutput m_error;

	protected override void RegisterPorts()
	{
		m_resourceInput = AddValueInput<GameObject>("资源", "resource");
		m_keepTimeInput = AddValueInput<float>("持续时长", "keepTime").SetDefaultAndSerializedValue(0.8f);
		m_agentIDInput = AddValueInput<int>("实体ID", "agentID");
		m_out = AddFlowOutput("Out", "output");
		m_error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			GameObject gameObject = Asset.Instantiate(m_resourceInput.GetValue());
			CustomTextMesh component = gameObject.GetComponent<CustomTextMesh>();
			if (component == null)
			{
				m_error.Call(f);
			}
			else
			{
				U3DHud.mInstance.AddChild(gameObject.transform);
				gameObject.transform.localPosition = Vector3.zero;
				NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(m_agentIDInput.GetValue());
				if (agent == null)
				{
					m_error.Call(f);
				}
				else
				{
					component.SetText(-(int)(agent.Blackboard as BBHumanoid).m_NextSimFrameData.mSourceSpaceDamage);
					for (int i = 0; i < component.mScales.Length; i++)
					{
						component.mScales[i] = 1f;
					}
					component.Rebuild();
					PooledAsset.DestroyOrReturn(gameObject, m_keepTimeInput.GetValue());
				}
			}
		});
	}
}
