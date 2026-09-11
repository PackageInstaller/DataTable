using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("更新Buff连线特效", 0)]
[Category("Render/Buff/Buff特效")]
[Description("特效路径距离:Effect/Battle/buff/BUFF_TYPE_FIRECHAIN;\n 【Add In】端调用:【增加】【Out】;\n 【Remove In】端调用:【移除】【Out】")]
public class UpdateBuffUVChainEffect : FlowControlNode
{
	private List<TwoIntOneGo> m_effects = new List<TwoIntOneGo>();

	private List<int> m_agentIDList = new List<int>();

	private ValueInput<string> m_effectPathInput;

	private ValueInput<int> m_agentIDInput;

	private FlowOutput m_addOut;

	private FlowOutput m_removeOut;

	private FlowOutput m_out;

	protected override void RegisterPorts()
	{
		m_effectPathInput = AddValueInput<string>("特效路径", "effectPath");
		m_agentIDInput = AddValueInput<int>("实体ID", "agentID");
		AddValueOutput("实体ID", "agentID", () => m_agentIDInput.GetValue());
		m_addOut = AddFlowOutput("增加", "addOut");
		m_removeOut = AddFlowOutput("移除", "removeOut");
		m_out = AddFlowOutput("Out", "output");
		AddFlowInput("Add In", "input", delegate(Flow f)
		{
			int value = m_agentIDInput.GetValue();
			AgentManager agentManager = (NScene.GetCurrentScene() as BattleScene).GetAgentManager();
			if (!m_agentIDList.Contains(value))
			{
				if (m_agentIDList.Count > 0)
				{
					for (int i = 0; i < m_agentIDList.Count; i++)
					{
						GameObject gameObject = Asset.Instantiate(m_effectPathInput.GetValue());
						if (gameObject != null)
						{
							TwoIntOneGo twoIntOneGo = FrameObjectPool<TwoIntOneGo>.Claim();
							twoIntOneGo.Int1 = m_agentIDList[i];
							twoIntOneGo.Int2 = value;
							twoIntOneGo.Go = gameObject;
							UVChainLightning component = gameObject.GetComponent<UVChainLightning>();
							Transform transform = agentManager.GetAgent(m_agentIDList[i]).transform;
							Transform transform2 = agentManager.GetAgent(value).transform;
							component.PointTransformList.Clear();
							component.PointTransformList.Add(transform);
							component.PointTransformList.Add(transform2);
							m_effects.Add(twoIntOneGo);
						}
					}
				}
				m_agentIDList.Add(value);
			}
			m_addOut.Call(f);
			m_out.Call(f);
		});
		AddFlowInput("Remove In", "input2", delegate(Flow f)
		{
			int value = m_agentIDInput.GetValue();
			for (int num = m_effects.Count - 1; num >= 0; num--)
			{
				TwoIntOneGo twoIntOneGo = m_effects[num];
				if (twoIntOneGo.Int1 == value || twoIntOneGo.Int2 == value)
				{
					GameObject go = twoIntOneGo.Go;
					twoIntOneGo.Go = null;
					PooledAsset.DestroyOrReturn(go);
					m_effects.RemoveAt(num);
					FrameObjectPool<TwoIntOneGo>.Release(twoIntOneGo);
				}
			}
			if (m_agentIDList.Contains(value))
			{
				m_agentIDList.Remove(value);
			}
			m_removeOut.Call(f);
			m_out.Call(f);
		});
	}
}
