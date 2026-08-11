using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class TrackedTrajectoryData : LinearMoveTrajectoryData
{
	protected BaseEntity bulletEntity;

	protected BulletTrackedData trackedData;

	protected BaseEntity target;

	protected Vector3 curPos;

	public virtual void OnInit()
	{
		if (trackedData == null)
		{
			return;
		}
		target = bulletEntity.GetSystem<EntitySystem>().GetEntity(trackedData.targetId);
		if (target == null || !target.IsSurvival)
		{
			return;
		}
		curPos = _startPos;
		_moveDirect = Vector3.Normalize(target.transform.position + trackedData.targetOffset - curPos);
		if (trackedData != null && trackedData.stageDataList != null)
		{
			trackedData.stageDataList.Sort((BulletTrackedStageData data1, BulletTrackedStageData data2) => data1.priority.CompareTo(data2.priority));
		}
	}

	public override Vector3 GetNextPoint(Vector3 lastPos, float deltaTime)
	{
		curPos = base.GetNextPoint(lastPos, deltaTime);
		return curPos;
	}

	public override Quaternion GetNextQuaternion(Quaternion quaternion, float deltaTime)
	{
		BulletTrackedStageData curStageData = GetCurStageData();
		if (curStageData == null)
		{
			return quaternion;
		}
		if (target == null || !target.IsSurvival)
		{
			return quaternion;
		}
		_velocity = curStageData.moveSpeed;
		Vector3 vector = bulletEntity.transform.rotation * Vector3.forward;
		Vector3 vector2 = target.transform.position + trackedData.targetOffset - curPos;
		vector2.Normalize();
		float angle = Mathf.Min(Vector3.Angle(vector, vector2), curStageData.rotateAngle);
		Vector3 normalized = Vector3.Cross(vector, vector2).normalized;
		Quaternion quaternion2 = Quaternion.AngleAxis(angle, normalized) * quaternion;
		_moveDirect = (quaternion2 * Vector3.forward).normalized;
		if (HitVolumeLog.isLog)
		{
			DrawDebugTools.DrawLine(curPos, curPos + vector * 5f, Color.yellow, Time.fixedDeltaTime);
			DrawDebugTools.DrawLine(curPos, curPos + _moveDirect * 5f, Color.red, Time.fixedDeltaTime);
		}
		return quaternion2;
	}

	protected virtual BulletTrackedStageData GetCurStageData()
	{
		if (target == null || !target.IsSurvival)
		{
			return null;
		}
		if (trackedData.stageDataList == null)
		{
			return null;
		}
		if (trackedData.stageDataList.Count == 1)
		{
			return trackedData.stageDataList[0];
		}
		for (int i = 0; i < trackedData.stageDataList.Count; i++)
		{
			BulletTrackedStageData bulletTrackedStageData = trackedData.stageDataList[i];
			if (bulletTrackedStageData.isDistanceOrTimeTracked)
			{
				Vector3 b = (bulletTrackedStageData.useCreatePoint ? _startPos : target.transform.position);
				float num = Vector3.Distance(curPos, b);
				if (bulletTrackedStageData.GetDistance() >= num)
				{
					return bulletTrackedStageData;
				}
			}
			else
			{
				BulletLifeComponent bulletLifeComponent = bulletEntity?.GetComponent<BulletLifeComponent>();
				if (bulletLifeComponent != null && ConditionExtensions.CompareValueMethod(bulletTrackedStageData.compareType, bulletLifeComponent.LifeTime, bulletTrackedStageData.trackedTime))
				{
					return bulletTrackedStageData;
				}
			}
		}
		if (trackedData.stageDataList.Count > 0)
		{
			return trackedData.stageDataList[0];
		}
		return null;
	}

	public static TrackedTrajectoryData Create(BaseEntity bullet, Vector3 startPos, Quaternion rotation, float oriVel, float oriAcc, float accelerateTime, float time, BulletTrackedData trackedData)
	{
		TrackedTrajectoryData trackedTrajectoryData = ReferencePool.Acquire<TrackedTrajectoryData>();
		trackedTrajectoryData.bulletEntity = bullet;
		trackedTrajectoryData.oriVel = ((oriVel <= 0f) ? 0f : oriVel);
		trackedTrajectoryData.oriAcc = oriAcc;
		trackedTrajectoryData._initialVelocity = rotation * new Vector3(0f, 0f, trackedTrajectoryData.oriVel);
		trackedTrajectoryData._acceleration = rotation * new Vector3(0f, 0f, trackedTrajectoryData.oriAcc);
		trackedTrajectoryData._accelerateTime = accelerateTime;
		trackedTrajectoryData._moveTime = time;
		trackedTrajectoryData._startPos = startPos;
		trackedTrajectoryData._targetPoint = trackedTrajectoryData._startPos + trackedTrajectoryData._initialVelocity * trackedTrajectoryData._moveTime + 0.5f * trackedTrajectoryData._moveTime * trackedTrajectoryData._moveTime * trackedTrajectoryData._acceleration;
		trackedTrajectoryData._curVel = trackedTrajectoryData._initialVelocity;
		trackedTrajectoryData.isAccelerate = false;
		trackedTrajectoryData.curVel = oriVel;
		trackedTrajectoryData.trackedData = trackedData;
		trackedTrajectoryData._endAccelerateVel = ((oriVel + oriAcc * accelerateTime <= 0f) ? Vector3.zero : (rotation * new Vector3(0f, 0f, oriVel + oriAcc * accelerateTime)));
		trackedTrajectoryData._trajectoryTypeEnum = MovementTrajectoryTypeEnum.Tracked;
		trackedTrajectoryData._lastFramePosition = startPos;
		trackedTrajectoryData.OnInit();
		return trackedTrajectoryData;
	}
}
