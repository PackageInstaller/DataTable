using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("创建修正模式进入特效(自动回收,锁旋转)_preload", 0)]
[Category("Render/函数")]
[Description("创建特效,填写挂点路径,时长为特效持续时间,自动回收;\n路径为:从Effect开始,例如:Effect/Hero/1037/fx_1037_skill1_1;\n挂点名称:gua_Hit;\n时长单位为:秒")]
public class CreateEnterSourceSpaceEffect : EffectCreateBaseNode
{
	private Flow _Flow;

	private FlowOutput _DelayOut;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => agentIDInput.value);
		ValueInput<string> attachPathInput = AddValueInput<string>("挂点名称", "挂点路径").SetDefaultAndSerializedValue(string.Empty);
		ValueInput<bool> isAttachInput = AddValueInput<bool>("是否挂载");
		ValueInput<float> timeInput = AddValueInput<float>("时间(秒)");
		ValueInput<bool> rotateInput = AddValueInput<bool>("是否锁住旋转");
		FlowOutput output = AddFlowOutput("");
		_DelayOut = AddFlowOutput("特效销毁时调用");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			if (!(null == agent))
			{
				Transform transform = agent.transform;
				AttachPointSetup attachPointSetup = U3DUtil.Get<AttachPointSetup>(agent.gameObject);
				string value = attachPathInput.GetValue();
				string text = string.Empty;
				if (!string.IsNullOrEmpty(value))
				{
					text = attachPointSetup.GetAttachPointPath(value);
				}
				_Flow = f;
				string value2 = _effectPathInput.value;
				string handPointPath = text;
				Vector3 zero = Vector3.zero;
				Vector3 one = Vector3.one;
				Vector3 zero2 = Vector3.zero;
				Vector3 forward = transform.forward;
				bool value3 = isAttachInput.value;
				float value4 = timeInput.value;
				bool value5 = rotateInput.value;
				bool isMainPlayerOrBossOrElitel = CommonEffectClipPlayer.IsMainPlayeOrBossOrElitel(agent.Blackboard as BBHumanoid);
				bool isFriend = CommonEffectClipPlayer.IsFriend(agent.Blackboard as BBHumanoid);
				Action<EffectController> onStop = OnStopFunc;
				EffectController effectController = CommonEffectClipPlayer.PlayEffect(transform, value2, handPointPath, zero, one, zero2, forward, value3, isLoop: false, 1f, 0f, value4, usePosition: false, default(Vector3), value5, onStop, isCameraEffect: false, isMainPlayerOrBossOrElitel, isFriend);
				_effectInstance = ((effectController != null) ? effectController.gameObject : null);
				if (effectController != null)
				{
					effectController.EnableVirtualCameras();
				}
				output.Call(f);
			}
		});
	}

	private void OnStopFunc(EffectController pEffectController)
	{
		_DelayOut.Call(_Flow);
	}
}
