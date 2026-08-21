using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("创建曲线移动子弹", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于创建曲线移动的子弹，并设置相关参数")]
public class CreateCurveBullet : ActionTaskBase
{
	[Name("旋转类型", 0)]
	public enum RotateType
	{
		Quaternion,
		Vector3
	}

	[RequiredField]
	[Name("X轴位移曲线", 0)]
	[Description("子弹在X轴上的位移曲线")]
	public BBParameter<AnimationCurve> curveX = new AnimationCurve();

	[RequiredField]
	[Name("Y轴位移曲线", 0)]
	[Description("子弹在Y轴上的位移曲线")]
	public BBParameter<AnimationCurve> curveY = new AnimationCurve();

	[RequiredField]
	[Name("Z轴位移曲线", 0)]
	[Description("子弹在Z轴上的位移曲线")]
	public BBParameter<AnimationCurve> curveZ = new AnimationCurve();

	[Name("是否跟随创建者", 0)]
	[Description("确定子弹是否跟随创建者移动")]
	public bool isFollowParent = true;

	[Name("移动时间", 0)]
	[Description("子弹的移动总时间")]
	public BBParameter<float> moveTime;

	[Name("位移开始时间", 0)]
	[Description("子弹开始移动的时间点")]
	public BBParameter<float> startTime;

	[Name("X轴倍率", 0)]
	[Description("X轴位移曲线的缩放倍率")]
	public BBParameter<float> multipleX = 1f;

	[Name("Y轴倍率", 0)]
	[Description("Y轴位移曲线的缩放倍率")]
	public BBParameter<float> multipleY = 1f;

	[Name("Z轴倍率", 0)]
	[Description("Z轴位移曲线的缩放倍率")]
	public BBParameter<float> multipleZ = 1f;

	[Name("子弹Id", 0)]
	[Description("创建的子弹的ID")]
	public int bulletId;

	[Name("基于自身坐标创建", 0)]
	[Description("确定子弹是否基于自身坐标创建")]
	public bool useSelfPoint = true;

	[Name("子弹坐标", 0)]
	[ShowIf("useSelfPoint", 0)]
	[Description("子弹的初始坐标")]
	public BBParameter<Vector3> bulletPoint;

	[Name("初始坐标偏移", 0)]
	public BBParameter<Vector3> offsetPoint;

	[ParadoxNotion.Design.Header("旋转")]
	[Description("启用曲线旋转功能。")]
	[Name("- 启动曲线旋转", 0)]
	public bool useRotation;

	[ShowIf("useRotation", 0)]
	[Name("子弹Y轴角度，是否为绝对角度", 0)]
	[Description("确定子弹Y轴角度是否为绝对角度")]
	public bool isAbsolutely;

	[ShowIf("useRotation", 0)]
	[Name("角度", 0)]
	[Description("子弹的初始角度")]
	public BBParameter<float> angle;

	[ShowIf("useRotation", 1)]
	[Name("旋转参数类型", 0)]
	public RotateType rotateType;

	[RequiredField]
	[Description("X轴旋转的曲线。")]
	[Name("X轴旋转曲线", 0)]
	[ShowIf("useRotation", 1)]
	public BBParameter<AnimationCurve> curveRotX = new AnimationCurve();

	[RequiredField]
	[Description("Y轴旋转的曲线。")]
	[Name("Y轴旋转曲线", 0)]
	[ShowIf("useRotation", 1)]
	public BBParameter<AnimationCurve> curveRotY = new AnimationCurve();

	[RequiredField]
	[Description("Z轴旋转的曲线。")]
	[Name("Z轴旋转曲线", 0)]
	[ShowIf("useRotation", 1)]
	public BBParameter<AnimationCurve> curveRotZ = new AnimationCurve();

	[RequiredField]
	[Description("W轴旋转的曲线。")]
	[Name("W轴旋转曲线", 0)]
	[ShowIf("useRotation", 1)]
	[HideIf("rotateType", 1)]
	public BBParameter<AnimationCurve> curveRotW = new AnimationCurve();

	[Name("是否启用多维旋转", 0)]
	[ShowIf("useRotation", 1)]
	public bool isMultidimensional;

	[ParadoxNotion.Design.Header("其它")]
	[Name("返回子弹实体Id", 0)]
	[Description("返回创建的子弹实体的ID")]
	public BBParameter<int> returnBulletId;

	[Name("是否跟随行为树销毁子弹", 0)]
	[Description("确定子弹是否在行为树结束时被销毁")]
	public bool isFollowDispose;

	[Name("是否当帧创建", 0)]
	public bool isCurrentTickCreate;

	[Name("特效是否需要插值运动", 0)]
	[Description("子弹加载的特效是否需要插值")]
	public bool ViewIsNeedLerp;

	[Name("特效移动的插值速度", 0)]
	[Description("特效移动的插值速度")]
	[ShowIf("ViewIsNeedLerp", 1)]
	public float StableMovementSharpness = 15f;

	[Name("特效旋转的插值速度", 0)]
	[Description("特效旋转的插值速度")]
	[ShowIf("ViewIsNeedLerp", 1)]
	public float StableRotationSharpness = 0.033f;

	protected override async void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity.GetSystem<BulletSystem>() == null)
		{
			OnActionFail();
			return;
		}
		Vector3 oriPoint = (useSelfPoint ? ownerEntity.transform.position : bulletPoint.value);
		oriPoint += offsetPoint.value;
		Vector3 bornEnu = (isAbsolutely ? new Vector3(0f, angle.value, 0f) : new Vector3(ownerEntity.transform.eulerAngles.x, ownerEntity.transform.eulerAngles.y + angle.value, ownerEntity.transform.eulerAngles.z));
		float timeLength = ((moveTime.value - startTime.value <= 0f) ? 0f : (moveTime.value - startTime.value));
		AnimationCurveRotateDataBase curveRotateData = null;
		if (useRotation)
		{
			if (rotateType == RotateType.Quaternion)
			{
				curveRotateData = AnimationCurveQuaternionData.Create(timeLength, curveRotX.value, curveRotY.value, curveRotZ.value, curveRotW.value);
			}
			else if (rotateType == RotateType.Vector3)
			{
				curveRotateData = AnimationCurveEulerData.Create(timeLength, curveRotX.value, curveRotY.value, curveRotZ.value);
			}
			if (curveRotateData != null)
			{
				curveRotateData.OnUseMultidimensional(isMultidimensional);
				bornEnu = curveRotateData.GetQuaternion(startTime.value).eulerAngles;
			}
		}
		BulletEntity bulletEntity = await ownerEntity.GetSystem<BulletSystem>().CreateBulletEntity(ownerEntity, bulletId, oriPoint, bornEnu, isCurrentTickCreate, null, ViewIsNeedLerp, StableMovementSharpness, StableRotationSharpness);
		if (bulletEntity == null)
		{
			EndAction();
			return;
		}
		returnBulletId.value = bulletEntity.Id;
		AnimationCurveData animationCurveData = AnimationCurveData.Create(curveX.value, timeLength, multipleX.value, startTime.value, oriPoint);
		AnimationCurveData animationCurveData2 = AnimationCurveData.Create(curveY.value, timeLength, multipleY.value, startTime.value, oriPoint);
		AnimationCurveData animationCurveData3 = AnimationCurveData.Create(curveZ.value, timeLength, multipleZ.value, startTime.value, oriPoint);
		bulletEntity.GetComponent<BulletMoveComponent>().SetToCurveMove(animationCurveData, animationCurveData2, animationCurveData3, isFollowParent);
		if (useRotation)
		{
			bulletEntity.GetComponent<BulletMoveComponent>().SetToCurveRotate(curveRotateData);
		}
		EndAction();
	}

	protected override void OnGraphStop()
	{
		base.OnGraphStop();
		if (ownerEntity != null && isFollowDispose)
		{
			BulletEntity bulletEntity = (BulletEntity)ownerEntity.GetSystem<EntitySystem>().GetEntity(returnBulletId.value);
			if (bulletEntity != null && bulletEntity.IsSurvival)
			{
				bulletEntity.DoEntityDead();
			}
		}
	}
}
