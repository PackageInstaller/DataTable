using UnityEngine;

namespace ACT.Config;

public class ConfigCameraFocus : ScriptableObject
{
	public CameraFocusProfile exploration = new CameraFocusProfile
	{
		leadingAmount = 2f,
		smoothTimeOut = 0.4f,
		smoothTimeBack = 0.7f,
		inputBufferTime = 0.15f,
		useDisplacement = false,
		displacementScale = 0.3f,
		displacementMax = 3f,
		inputWeight = 0.6f
	};

	public CameraFocusProfile combat = new CameraFocusProfile
	{
		leadingAmount = 4f,
		smoothTimeOut = 0.15f,
		smoothTimeBack = 0.4f,
		inputBufferTime = 0.05f,
		useDisplacement = true,
		displacementScale = 0.3f,
		displacementMax = 3f,
		inputWeight = 0.6f
	};

	[Tooltip("非战斗 ⇄ 战斗切换时，Profile 参数平滑 Lerp 的时长")]
	public float profileTransitionTime = 0.5f;

	[Tooltip("技能锁定结束后焦点从冻结位置平滑追赶回角色的时长")]
	public float transitionDuration = 0.3f;

	[Tooltip("焦点相对于角色位置的偏移量 (y=0.9 约等于腰部高度)")]
	public Vector3 focusOffset = new Vector3(0f, 0.9f, 0f);
}
