using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("创建特效(镜头前,自动回收)_preload", 0)]
[Category("Render/特效")]
[Description("创建特效,节点填写路径\n例如:Asset/ABResources/Effect/Scene/fx_chuchang_01,只要使用:Effect/Scene/fx_chuchang_01\n时长单位:秒\n偏移 x 负左正右, y 正上负下, z 正远负近\n如果指定的虚拟相机GameObejct不为空, 则挂载在这个虚拟相机下面\n如果指定的虚拟相机GameObejct为空, 则判断是否优先使用虚拟相机\n如果不优先使用虚拟相机, 就挂在主相机下\n否则查找当前激活的虚拟相机\n如果找到, 就挂在当前激活的虚拟相机下\n否则就挂在主相机下")]
public class PlayCameraEffect_preload : EffectCreateBaseNode
{
	private Vector3 m_scale = Vector3.zero;

	private FlowOutput _DelayOut;

	private Flow _Flow;

	private ValueInput<Vector3> _OffsetInput;

	private ValueInput<float> _fieldOfViewInput;

	private ValueInput<Vector2> _aspectRateInput;

	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		FlowOutput output = AddFlowOutput("out");
		_DelayOut = AddFlowOutput("特效销毁时调用");
		ValueInput<float> timeVar = AddValueInput<float>("持续时长(秒)");
		ValueInput<GameObject> targetVirtualCameraInput = AddValueInput<GameObject>("指定的虚拟相机预制体");
		ValueInput<bool> useVirtualCameraFirstInput = AddValueInput<bool>("优先使用虚拟相机").SetDefaultAndSerializedValue(v: true);
		_fieldOfViewInput = AddValueInput<float>("视口", "fieldOfView").SetDefaultAndSerializedValue(55f);
		_aspectRateInput = AddValueInput<Vector2>("屏幕比例", "aspectRate").SetDefaultAndSerializedValue(new Vector2(1920f, 1080f));
		_OffsetInput = AddValueInput<Vector3>("偏移(看备注)", "offset").SetDefaultAndSerializedValue(Vector3.zero);
		ValueInput<string> assignedInput = AddValueInput<string>("指定虚拟相机", "assigned").SetDefaultAndSerializedValue(string.Empty);
		AddFlowInput("In", delegate(Flow f)
		{
			_Flow = f;
			if (m_scale == Vector3.zero)
			{
				m_scale = Vector3.one;
			}
			_effectInstance = null;
			EffectController effectController = CommonEffectClipPlayer.PlayEffect(null, _effectPathInput.GetValue(), string.Empty, Vector3.zero, m_scale, Vector3.zero, Vector3.forward, isAttach: false, isLoop: false, 1f, 0f, timeVar.GetValue(), usePosition: false, Vector3.zero, isLockEffectRotation: false, OnStopFunc, isCameraEffect: true, isMainPlayerOrBossOrElitel: true);
			GameObject targetVirtualCamera = targetVirtualCameraInput.value;
			if (!string.IsNullOrEmpty(assignedInput.value))
			{
				GameObject gameObject = GameObject.Find(assignedInput.value);
				if (gameObject != null)
				{
					targetVirtualCamera = gameObject;
				}
			}
			if (_OffsetInput.GetValue() != Vector3.zero)
			{
				effectController.transform.localPosition = _OffsetInput.GetValue();
			}
			effectController.m_CameraEffectController = U3DUtil.Get<CameraEffectController>(effectController.gameObject);
			effectController.m_CameraEffectController.m_effectController = effectController;
			effectController.m_CameraEffectController.Initalization(m_scale, _fieldOfViewInput.value, _aspectRateInput.value);
			CommonEffectClipPlayer.SetVirtualCameraEffect(effectController.gameObject, targetVirtualCamera, useVirtualCameraFirstInput.value);
			if (effectController != null)
			{
				_effectInstance = effectController.gameObject;
			}
			output.Call(f);
		});
	}

	private void OnStopFunc(EffectController pEffectController)
	{
		_DelayOut.Call(_Flow);
	}
}
