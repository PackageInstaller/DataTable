using Ase;
using Ase.Paradox;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

[Name("相机曲线位移旋转", 0)]
public class CurveRotateCameraAction : ActionTaskBase
{
	[ParadoxNotion.Design.Header("位移")]
	[Description("启用曲线位移功能。")]
	[Name("- 启动曲线位移", 0)]
	public bool useMovement = true;

	[RequiredField]
	[Description("X轴位移的曲线。")]
	[Name("X轴位移曲线", 0)]
	[ShowIf("useMovement", 1)]
	public AnimationCurve curveX;

	[RequiredField]
	[Description("Z轴位移的曲线。")]
	[Name("Z轴位移曲线", 0)]
	[ShowIf("useMovement", 1)]
	public AnimationCurve curveZ;

	[ParadoxNotion.Design.Header("旋转")]
	[Description("启用曲线旋转功能。")]
	[Name("- 启动曲线旋转", 0)]
	public bool useRotation = true;

	[Name("旋转参数类型", 0)]
	public CreateCurveBullet.RotateType rotateType;

	[RequiredField]
	[Description("X轴旋转的曲线。")]
	[Name("X轴旋转曲线", 0)]
	[ShowIf("useRotation", 1)]
	public AnimationCurve curveRotX;

	[RequiredField]
	[Description("Y轴旋转的曲线。")]
	[Name("Y轴旋转曲线", 0)]
	[ShowIf("useRotation", 1)]
	public AnimationCurve curveRotY;

	[RequiredField]
	[Description("Z轴旋转的曲线。")]
	[Name("Z轴旋转曲线", 0)]
	[ShowIf("useRotation", 1)]
	public AnimationCurve curveRotZ;

	[RequiredField]
	[Description("W轴旋转的曲线。")]
	[Name("W轴旋转曲线", 0)]
	[ShowIf("useRotation", 1)]
	[HideIf("rotateType", 1)]
	public AnimationCurve curveRotW;

	[Name("是否开启插值运动", 0)]
	public bool IsOpenInterpolation;

	[Name("是否启用动画运动", 0)]
	public bool IsOpenAnimator;

	[Name("时间类型", 0)]
	public MovementTimeType TimeType;

	[ParadoxNotion.Design.Header("参数")]
	[Description("移动的时间。")]
	[Name("移动时间", 0)]
	[ShowIf("TimeType", 0)]
	public BBParameter<float> moveTime;

	[ParadoxNotion.Design.Header("参数")]
	[Description("移动的帧号。")]
	[Name("移动帧号", 0)]
	[ShowIf("TimeType", 1)]
	public BBParameter<int> MoveTick;

	[Description("Z轴位移的倍率。")]
	[Name("倍率Z", 0)]
	public BBParameter<float> multiple = 1f;

	[Description("X轴位移的倍率。")]
	[Name("倍率X", 0)]
	public BBParameter<float> multiple_X = 1f;

	[Name("Z轴时间倍率", 0)]
	public BBParameter<float> timeScale_z = 1f;

	[Name("X轴时间倍率", 0)]
	public BBParameter<float> timeScale_x = 1f;
}
