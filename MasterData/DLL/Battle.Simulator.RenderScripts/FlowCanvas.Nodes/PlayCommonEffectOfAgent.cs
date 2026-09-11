using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("创建特效(通用)(受管控)(渲染)", 0)]
[Category("Render/函数")]
[Description("注意!!!该节点需要和【移除特效(通用)(受管控)】配套使用，否则第二次添加的时候无法添加通过角色身上的通用特效播放器创建特效\n特效路径为:从Effect开始,例如:Effect/Hero/1037/fx_1037_skill1_1;\n挂点路径从tpose开始, 如果要挂在指定点, 可以用 获取挂点路径 先获取\n其他参数意义问文杰\n创建出来的通用特效需要使用【移除角色通用特效】节点进行关闭\n这个节点创建的特效会跟随角色显隐")]
public class PlayCommonEffectOfAgent : EffectCreateBaseNode
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
		ValueInput<bool> usePositionInput = AddValueInput<bool>("是否使用输入位置").SetDefaultAndSerializedValue(v: false);
		ValueInput<Vector3> centerPositionInput = AddValueInput<Vector3>("中心位置").SetDefaultAndSerializedValue(Vector3.zero);
		ValueInput<bool> lockRotateInput = AddValueInput<bool>("是否锁住旋转").SetDefaultAndSerializedValue(v: false);
		_EnableVirtualCamera = AddValueInput<bool>("启动虚拟相机", "EnableVirtualCamera").SetDefaultAndSerializedValue(v: false);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(entityIDInput.value);
			if (agent == null)
			{
				error.Call(f);
			}
			else
			{
				float pEffectKeepTime = 99999f;
				EffectController effectController = agent.ComponentTimeline.PlayCommonEffect(_effectPathInput.value, attachPathInput.value, effectOffsetInput.value, effectScaleInput.value, effectRotateInput.value, effectForwardInput.value, isAttachInput.value, isLoopInput.value, pNeedManager: true, initNormalizeInput.value, pEffectKeepTime, usePositionInput.value, centerPositionInput.value, lockRotateInput.value, timeSceleInput.value);
				if (_EnableVirtualCamera.GetValue())
				{
					effectController.EnableVirtualCameras();
				}
				_effectInstance = ((null != effectController) ? effectController.gameObject : null);
				output.Call(f);
			}
		});
	}
}
