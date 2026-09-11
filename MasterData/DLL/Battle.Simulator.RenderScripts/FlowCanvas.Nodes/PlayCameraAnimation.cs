using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放相机动画", 0)]
[Category("Render/Camera")]
[Description("播放相机动画, 只能调一次, 不能每帧都一直调用")]
public class PlayCameraAnimation : FlowNode
{
	private AnimationEvent e = new AnimationEvent();

	protected override void RegisterPorts()
	{
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向");
		ValueInput<string> assetNameInput = AddValueInput<string>("资源名");
		ValueInput<string> animationNameInput = AddValueInput<string>("动画片段名");
		ValueInput<CinemachineBlendDefinition.Style> enterBlendInput = AddValueInput<CinemachineBlendDefinition.Style>("切换方式");
		ValueInput<Transform> lookAtInput = AddValueInput<Transform>("关注对象");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			GameObject gameObject = Asset.Instantiate(assetNameInput.value);
			gameObject.transform.forward = (Vector3)forwardInput.value;
			gameObject.transform.position = (Vector3)positionInput.value;
			Camera.main.gameObject.GetComponent<CinemachineBrain>().m_DefaultBlend.m_Style = enterBlendInput.value;
			Transform transform = lookAtInput.value;
			if (lookAtInput.value != null)
			{
				transform = lookAtInput.value.Find("Bip001");
				if (transform == null)
				{
					transform = lookAtInput.value.Find("MotionRoot/Bip001");
				}
				if (transform == null)
				{
					transform = lookAtInput.value.Find("Dummy002");
				}
			}
			gameObject.transform.Find("VirtualCamera").GetComponent<CinemachineVirtualCamera>().LookAt = transform;
			Animator component = gameObject.GetComponent<Animator>();
			AnimationClip clip = component.GetCurrentAnimatorClipInfo(0)[0].clip;
			CameraAnimationCallBack component2 = gameObject.GetComponent<CameraAnimationCallBack>();
			component2.f = f;
			component2.output = output;
			component2.cameraAsset = gameObject;
			if (clip.events == null || clip.events.Length == 0)
			{
				e.functionName = "CallBack";
				e.time = clip.length;
				clip.AddEvent(e);
			}
			component.Play(animationNameInput.value, 0, 0f);
		});
	}
}
