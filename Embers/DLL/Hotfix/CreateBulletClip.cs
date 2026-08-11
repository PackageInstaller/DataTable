using Ase;
using Ase.ECS;
using UnityEngine;

[ClipName("创建子弹")]
public class CreateBulletClip : TaskClip
{
	[VariableName("子弹坐标")]
	public Vector3 bulletPoint;

	[VariableName("初始位置偏移配置类型")]
	public OffsetConfigurationType configurationType;

	[VariableName("水平距离")]
	public float distance;

	[VariableName("水平角度")]
	public float angle;

	[VariableName("高度偏移")]
	public float heightOffset;

	[VariableName("是否跟随行为树销毁子弹")]
	public bool isFollowDispose;

	[VariableName("位置偏移量")]
	public Vector3 offset = Vector3.zero;

	[VariableName("子弹自身角度Y轴偏移")]
	public float rotationOffsetY;

	[VariableName("子弹Id")]
	public int bulletId;

	[VariableName("基于自身坐标创建")]
	public bool useSelfPoint = true;

	[VariableName("是否当帧创建")]
	public bool isCurrentTickCreate;

	[VariableName("特效是否需要插值运动")]
	public bool viewIsNeedLerp;

	[VariableName("特效移动的插值速度")]
	public float stableMovementSharpness = 0.2f;

	[VariableName("特效旋转的插值速度")]
	public float stableRotationSharpness = 0.033f;

	public override void OnRunTimeEnter(BaseEntity context, int fps, int currentFrameID)
	{
		base.OnRunTimeEnter(context, fps, currentFrameID);
		if (context.GetSystem<BulletSystem>() != null)
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"行为树准备创建子弹  子弹id {bulletId}", context);
			}
			context.GetSystem<BulletSystem>().CreateBulletEntity(context, bulletId, useSelfPoint, bulletPoint, rotationOffsetY, configurationType, offset, distance, angle, heightOffset, isCurrentTickCreate, viewIsNeedLerp, stableMovementSharpness, stableRotationSharpness);
		}
	}

	public override void RunTimeTick(int currentFrameID, int fps, float deltaTime, BaseEntity context)
	{
	}

	public override void EditorTick(int currentFrameID, int fps, float deltaTime, GameObject context)
	{
	}
}
