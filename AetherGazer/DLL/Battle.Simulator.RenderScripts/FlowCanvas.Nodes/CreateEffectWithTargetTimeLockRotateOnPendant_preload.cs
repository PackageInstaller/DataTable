using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("渲染挂件创建特效(自动回收,锁旋转)_preload", 0)]
[Category("Render/函数")]
[Description("创建特效,填写挂点路径,时长为特效持续时间,自动回收;\n路径为:从Effect开始,例如:Effect/Hero/1037/fx_1037_skill1_1;\n挂点名称:gua_Hit;\n时长单位为:秒")]
public class CreateEffectWithTargetTimeLockRotateOnPendant_preload : EffectCreateBaseNode
{
	private ValueInput<bool> _EnableVirtualCamera;

	private ValueInput<Vector3> _ForwardInput;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		ValueInput<int> agentIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => agentIDInput.value);
		ValueInput<int> pendantIDInput = AddValueInput<int>("挂件ID", "pendantIDVar");
		AddValueOutput("挂件ID", "pendantID", () => pendantIDInput.value);
		ValueInput<string> attachPathInput = AddValueInput<string>("挂点名称", "挂点路径").SetDefaultAndSerializedValue(string.Empty);
		ValueInput<bool> isAttachInput = AddValueInput<bool>("是否挂载");
		ValueInput<float> timeInput = AddValueInput<float>("时间(秒)");
		ValueInput<bool> rotateInput = AddValueInput<bool>("是否锁住旋转");
		_EnableVirtualCamera = AddValueInput<bool>("启动虚拟相机", "EnableVirtualCamera").SetDefaultAndSerializedValue(v: false);
		_ForwardInput = AddValueInput<Vector3>("自定义朝向", "forward").SetDefaultAndSerializedValue(Vector3.zero);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(agentIDInput.value);
			if (agent == null)
			{
				errorOut.Call(f);
			}
			else
			{
				List<IPendant>.Enumerator enumerator = agent.gameObject.GetComponent<ComponentPendant>().GetPendants().GetEnumerator();
				while (enumerator.MoveNext())
				{
					RenderPendant renderPendant = enumerator.Current as RenderPendant;
					if (renderPendant != null && renderPendant.PendantID == pendantIDInput.value)
					{
						Transform transform = renderPendant.transform;
						AttachPointSetup attachPointSetup = U3DUtil.Get<AttachPointSetup>(renderPendant.gameObject);
						string value = attachPathInput.GetValue();
						string pParentFullPath = string.Empty;
						if (!string.IsNullOrEmpty(value))
						{
							pParentFullPath = attachPointSetup.GetAttachPointPath(value);
						}
						Vector3 scale = Vector3.one;
						EffectScaleOnAttach component = transform.GetComponent<EffectScaleOnAttach>();
						if (component != null && !component.TryGetEffectScale(value, out scale))
						{
							scale = Vector3.one;
						}
						EffectController effectController = renderPendant.PlayCommonEffect(_effectPathInput.value, pParentFullPath, Vector3.zero, scale, Vector3.zero, transform.forward, isAttachInput.value, pIsLoop: false, pNeedManager: false, 0f, timeInput.value, pUsePosition: false, Vector3.zero, rotateInput.value);
						if (_ForwardInput.GetValue() != Vector3.zero)
						{
							effectController.transform.forward = _ForwardInput.GetValue();
						}
						if (_EnableVirtualCamera.GetValue())
						{
							effectController.EnableVirtualCameras();
						}
						_effectInstance = ((effectController != null) ? effectController.gameObject : null);
					}
				}
				output.Call(f);
			}
		});
	}
}
