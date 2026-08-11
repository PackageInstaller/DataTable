using System.Collections.Generic;
using UnityEngine;

namespace Ase;

public class BulletTrackedData : BulletMoveDataBase
{
	public int targetId;

	public Vector3 targetPos;

	public bool useTargetIdPoint;

	public Vector3 targetOffset;

	public List<BulletTrackedStageData> stageDataList;

	public override BulletMoveDataBase Clone()
	{
		return new BulletTrackedData
		{
			targetId = targetId,
			targetPos = targetPos,
			useTargetIdPoint = useTargetIdPoint,
			targetOffset = targetOffset,
			stageDataList = stageDataList.ToList()
		};
	}
}
