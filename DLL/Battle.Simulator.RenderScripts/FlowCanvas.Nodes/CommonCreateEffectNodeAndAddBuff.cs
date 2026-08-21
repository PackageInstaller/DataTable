using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("通用的创建特效节点(添加buffID)", 0)]
[Category("Render/函数")]
[Description("通用的创建特效节点 + 添加BUFF特效节点\n特效路径为:从Effect开始,例如:Effect/Hero/1037/fx_1037_skill1_1;\n挂点路径从tpose开始, 如果要挂在指定点, 可以用 获取挂点路径 先获取\n其他参数意义问文杰\n隐藏部件的时候不会隐藏挂载的特效\n只有在特效onStop的时候才会调接下来的节点, 接下来的节点取参数只能取EffectController, 不能从前面的节点取值")]
public class CommonCreateEffectNodeAndAddBuff : EffectCreateBaseNode
{
	private ValueInput<bool> _EnableVirtualCamera;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		EffectController controller = null;
		AddValueOutput("EffectController", () => controller);
		ValueInput<string> attachPathInput = AddValueInput<string>("挂点路径");
		ValueInput<Vector3> effectOffsetInput = AddValueInput<Vector3>("特效偏移").SetDefaultAndSerializedValue(Vector3.zero);
		ValueInput<Vector3> effectScaleInput = AddValueInput<Vector3>("特效缩放").SetDefaultAndSerializedValue(Vector3.one);
		ValueInput<Vector3> effectRotateInput = AddValueInput<Vector3>("特效旋转").SetDefaultAndSerializedValue(Vector3.zero);
		ValueInput<Vector3> effectForwardInput = AddValueInput<Vector3>("特效朝向").SetDefaultAndSerializedValue(Vector3.forward);
		ValueInput<bool> isAttachInput = AddValueInput<bool>("是否挂载").SetDefaultAndSerializedValue(v: false);
		ValueInput<bool> isLoopInput = AddValueInput<bool>("是否循环").SetDefaultAndSerializedValue(v: false);
		ValueInput<float> timeSceleInput = AddValueInput<float>("时间缩放").SetDefaultAndSerializedValue(1f);
		ValueInput<float> initNormalizeInput = AddValueInput<float>("初始进度").SetDefaultAndSerializedValue(0f);
		ValueInput<float> timeInput = AddValueInput<float>("回收时间(秒)").SetDefaultAndSerializedValue(5f);
		ValueInput<bool> usePositionInput = AddValueInput<bool>("是否使用输入位置").SetDefaultAndSerializedValue(v: false);
		ValueInput<Vector3> centerPositionInput = AddValueInput<Vector3>("中心位置").SetDefaultAndSerializedValue(Vector3.zero);
		ValueInput<bool> lockRotateInput = AddValueInput<bool>("是否锁住旋转").SetDefaultAndSerializedValue(v: false);
		ValueInput<bool> isCameraEffectInput = AddValueInput<bool>("是否相机特效").SetDefaultAndSerializedValue(v: false);
		_EnableVirtualCamera = AddValueInput<bool>("启动虚拟相机", "EnableVirtualCamera").SetDefaultAndSerializedValue(v: false);
		ValueInput<int> buffIDInput = AddValueInput<int>("BuffID", "buffID").SetDefaultAndSerializedValue(0);
		ValueInput<int> buffClassIDInput = AddValueInput<int>("Buff渲染ID", "buffClassID").SetDefaultAndSerializedValue(0);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput done = AddFlowOutput("特效结束调用");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(entityIDInput.value);
			EffectController effectController = CommonEffectClipPlayer.PlayEffect(agent.transform, onStop: delegate(EffectController effectCtrl)
			{
				controller = effectCtrl;
				done.Call(f);
			}, effectName: _effectPathInput.value, handPointPath: attachPathInput.value, offset: effectOffsetInput.value, scale: effectScaleInput.value, rotation: effectRotateInput.value, forward: effectForwardInput.value, isAttach: isAttachInput.value, isLoop: isLoopInput.value, timeScale: timeSceleInput.value, normalize: initNormalizeInput.value, effectKeepTime: timeInput.value, usePosition: usePositionInput.value, centerPos: centerPositionInput.value, isLockEffectRotation: lockRotateInput.value, isCameraEffect: isCameraEffectInput.value, isMainPlayerOrBossOrElitel: CommonEffectClipPlayer.IsMainPlayeOrBossOrElitel(agent.Blackboard as BBHumanoid), isFriend: CommonEffectClipPlayer.IsFriend(agent.Blackboard as BBHumanoid));
			if (_EnableVirtualCamera.GetValue())
			{
				effectController.EnableVirtualCameras();
			}
			_effectInstance = ((null != effectController) ? effectController.gameObject : null);
			if (buffIDInput.value != 0 && buffClassIDInput.value != 0)
			{
				BuffManager.GetBuffManager()?.AddBuffEffect(buffIDInput.value, entityIDInput.value, buffClassIDInput.value, _effectInstance);
			}
			output.Call(f);
		});
	}
}
