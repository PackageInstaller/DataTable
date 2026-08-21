using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("创建特效(指向)(渲染)", 0)]
[Category("Render/函数")]
[Description("在挂点位置创建指向目标点位置的特效,特效上需要有【LineRender】,填写挂点名称;\n路径为:从Effect开始,例如:Effect/Battle/yujing/fx_line_star;\n挂点名称:gua_Hit;")]
public class AddLaserEffect : EffectCreateBaseNode
{
	private ValueInput<int> _AgentID1Input;

	private ValueInput<string> _AttachPointName1Input;

	private ValueInput<Vector3> _TargetPositionInput;

	private ValueInput<int> _AgentID2Input;

	private ValueInput<string> _AttachPointName2Input;

	private ValueInput<float> _KeepTimeInput;

	private FlowOutput _Out;

	private FlowOutput _Error;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		_effectPathInput.SetDefaultAndSerializedValue("Effect/Monster/4013/fx_4013_attack3_3_zwj");
		_AgentID1Input = AddValueInput<int>("实体ID1", "agentID1");
		_AttachPointName1Input = AddValueInput<string>("实体1挂点").SetDefaultAndSerializedValue("gua_Hit");
		_TargetPositionInput = AddValueInput<Vector3>("目标位置", "targetPos");
		_KeepTimeInput = AddValueInput<float>("时长(秒)", "keepTime").SetDefaultAndSerializedValue(5f);
		_Out = AddFlowOutput("Out", "output");
		_Error = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(_AgentID1Input.GetValue());
			if (agent == null)
			{
				_Error.Call(f);
			}
			else
			{
				AttachPointSetup attachPointSetup = U3DUtil.Get<AttachPointSetup>(agent.gameObject);
				Transform attachPoint = attachPointSetup.GetAttachPoint(_AttachPointName1Input.GetValue());
				string attachPointPath = attachPointSetup.GetAttachPointPath(_AttachPointName1Input.GetValue());
				Transform transform = agent.transform;
				string value = _effectPathInput.value;
				Vector3 zero = Vector3.zero;
				Vector3 one = Vector3.one;
				Vector3 zero2 = Vector3.zero;
				Vector3 forward = agent.transform.forward;
				float value2 = _KeepTimeInput.value;
				bool isMainPlayerOrBossOrElitel = CommonEffectClipPlayer.IsMainPlayeOrBossOrElitel(agent.Blackboard as BBHumanoid);
				bool isFriend = CommonEffectClipPlayer.IsFriend(agent.Blackboard as BBHumanoid);
				EffectController effectController = CommonEffectClipPlayer.PlayEffect(transform, value, attachPointPath, zero, one, zero2, forward, isAttach: false, isLoop: false, 1f, 0f, value2, usePosition: false, default(Vector3), isLockEffectRotation: false, null, isCameraEffect: false, isMainPlayerOrBossOrElitel, isFriend);
				Vector3 normalized = (_TargetPositionInput.GetValue() - attachPoint.position).normalized;
				effectController.transform.forward = normalized;
				_effectInstance = ((effectController != null) ? effectController.gameObject : null);
				_Out.Call(f);
			}
		});
	}
}
