using System;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public struct CameraFocusProfile
{
	[Tooltip("输入持续时相机焦点在水平方向上提前的最大距离")]
	public float leadingAmount;

	[Tooltip("焦点向外推出 (跟随输入) 的 SmoothDamp 时间")]
	public float smoothTimeOut;

	[Tooltip("焦点返回中心的 SmoothDamp 时间")]
	public float smoothTimeBack;

	[Tooltip("输入需持续该时长后才开始更新焦点偏移，防止误触导致的画面抖动")]
	public float inputBufferTime;

	[Tooltip("战斗时是否根据角色实际位移速度做额外的焦点偏移")]
	public bool useDisplacement;

	[Tooltip("rawVelocity.x 乘以该系数得到原始位移偏移")]
	public float displacementScale;

	[Tooltip("位移偏移的硬上限")]
	public float displacementMax;

	[Range(0f, 1f)]
	[Tooltip("0=纯位移驱动, 1=纯输入驱动, 0.5=各半")]
	public float inputWeight;
}
