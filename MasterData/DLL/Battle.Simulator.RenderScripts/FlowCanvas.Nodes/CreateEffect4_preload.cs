using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("创建特效(字符串)_preload", 0)]
[Category("Render/函数")]
[Description("创建特效,节点填写路径,挂点只需要填写名称,不需要写完整的挂点路径。隐藏部件的时候会隐藏挂载的特效")]
public class CreateEffect4_preload : EffectCreateBaseNode
{
	private ValueInput<bool> _EnableVirtualCamera;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		FlowOutput output = AddFlowOutput("out");
		ValueInput<int> entityIDVar = AddValueInput<int>("实体ID");
		ValueInput<string> attachNameVar = AddValueInput<string>("挂点名称").SetDefaultAndSerializedValue(string.Empty);
		ValueInput<bool> isAttachVar = AddValueInput<bool>("是否挂载");
		ValueInput<bool> isLockEffectRotationVar = AddValueInput<bool>("是否锁住旋转");
		_EnableVirtualCamera = AddValueInput<bool>("启动虚拟相机", "EnableVirtualCamera").SetDefaultAndSerializedValue(v: false);
		AddFlowInput("In", delegate(Flow f)
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(entityIDVar.value);
			if (null == agent)
			{
				Debug.LogError("创建特效(字符串)_preload Agent为空 " + entityIDVar.value);
			}
			else if (agent.ComponentTimeline == null)
			{
				Debug.LogError("创建特效(字符串)_preload 无 ComponentTimeline " + entityIDVar.value);
			}
			else
			{
				Transform transform = agent.transform;
				if (null == transform)
				{
					Debug.LogError("创建特效(字符串)_preload Agent.transform为空 " + entityIDVar.value);
				}
				else
				{
					AttachPointSetup attachPointSetup = U3DUtil.Get<AttachPointSetup>(agent.gameObject);
					if (null == transform)
					{
						Debug.LogError("创建特效(字符串)_preload Agent.AttachPointSetup为空 " + entityIDVar.value);
					}
					else
					{
						string attachPointPath = attachPointSetup.GetAttachPointPath(attachNameVar.value);
						Vector3 scale = Vector3.one;
						EffectScaleOnAttach component = transform.GetComponent<EffectScaleOnAttach>();
						if (component != null && !component.TryGetEffectScale(attachNameVar.GetValue(), out scale))
						{
							scale = Vector3.one;
						}
						EffectController effectController = agent.ComponentTimeline.PlayCommonEffect(_effectPathInput.value, attachPointPath, Vector3.zero, scale, Vector3.zero, transform.forward, isAttachVar.value, pIsLoop: true, pNeedManager: false, 0f, 2.1474836E+09f, pUsePosition: false, Vector3.zero, isLockEffectRotationVar.value);
						if (effectController != null)
						{
							_effectInstance = effectController.gameObject;
							if (_EnableVirtualCamera.GetValue())
							{
								effectController.EnableVirtualCameras();
							}
						}
						output.Call(f);
					}
				}
			}
		});
		AddValueOutput("实体ID", () => entityIDVar.value);
	}
}
