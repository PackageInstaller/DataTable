using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("创建连线特效(渲染)", 0)]
[Category("Render/函数")]
[Description("创建连线特效,特效上需要有【LineRender】,填写挂点名称;\n路径为:从Effect开始,例如:Effect/Battle/yujing/fx_line_star;\n挂点名称:gua_Hit;")]
public class AddLineEffect : EffectCreateBaseNode
{
	private ValueInput<int> _AgentID1Input;

	private ValueInput<string> _AttachPointName1Input;

	private ValueInput<int> _AgentID2Input;

	private ValueInput<string> _AttachPointName2Input;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_effectPathInput.SetDefaultAndSerializedValue("Effect/Battle/yujing/fx_line_star");
		_AgentID1Input = AddValueInput<int>("实体ID1", "agentID1");
		_AttachPointName1Input = AddValueInput<string>("实体1挂点").SetDefaultAndSerializedValue("gua_Hit");
		_AgentID2Input = AddValueInput<int>("实体ID2", "agentID2");
		_AttachPointName2Input = AddValueInput<string>("实体2挂点").SetDefaultAndSerializedValue("gua_Hit");
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(_AgentID1Input.GetValue());
			NAgent agent2 = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(_AgentID2Input.GetValue());
			if (agent == null || agent2 == null)
			{
				_Error.Call(f);
			}
			else
			{
				AttachPointSetup attachPointSetup = U3DUtil.Get<AttachPointSetup>(agent.gameObject);
				AttachPointSetup attachPointSetup2 = U3DUtil.Get<AttachPointSetup>(agent2.gameObject);
				Transform attachPoint = attachPointSetup.GetAttachPoint(_AttachPointName1Input.GetValue());
				Transform attachPoint2 = attachPointSetup2.GetAttachPoint(_AttachPointName2Input.GetValue());
				EffectController effectController = agent.ComponentTimeline.PlayLineEffect(_effectPathInput.value, attachPoint, attachPoint2, needManager: false, float.MaxValue);
				_effectInstance = ((effectController != null) ? effectController.gameObject : null);
				_Out.Call(f);
			}
		});
	}
}
