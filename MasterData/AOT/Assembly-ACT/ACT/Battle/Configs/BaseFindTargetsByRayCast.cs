using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public abstract class BaseFindTargetsByRayCast : BaseFindTargetsByArea
{
	public string attachPoint;

	public Vector3 offset;

	[Space(10f)]
	public Vector3 directionOffset;

	public Vector3 anchorOffest;

	[Tooltip("最大射程")]
	public float distance;

	protected bool NotuseAttachPoint => string.IsNullOrEmpty(attachPoint);

	public (Vector3 pos, Quaternion rot, Vector3 forward, Vector3 anchor) GetEmissionPointInfo(Entity referenceEntity, bool useAttachCurve = false)
	{
		Vector3 vector = default;
		Vector3 item = default;
		Vector3 item2 = default;
		Quaternion quaternion = default;
		if (string.IsNullOrEmpty(attachPoint))
		{
			Transform rootTransform = referenceEntity.GetRootTransform();
			vector = rootTransform.TransformPoint(offset);
			quaternion = rootTransform.rotation * Quaternion.Euler(directionOffset);
			item = rootTransform.rotation * Quaternion.Euler(directionOffset) * Vector3.forward;
			item2 = rootTransform.TransformPoint(anchorOffest);
		}
		else if (useAttachCurve)
		{
			CompMotion compMotion = referenceEntity.GetCompMotion();
			if (compMotion.layer0PeakConfig.attachPointCurve != null)
			{
				float toLogicTime = compMotion.layer0Peak.toLogicTime;
				ConfigAttachPointCurve attachPointCurve = compMotion.layer0PeakConfig.attachPointCurve;
				float x = attachPointCurve.attachPointPosXCurve.Evaluate(toLogicTime);
				float y = attachPointCurve.attachPointPosYCurve.Evaluate(toLogicTime);
				float z = attachPointCurve.attachPointPosZCurve.Evaluate(toLogicTime);
				float x2 = attachPointCurve.attachPointRotXCurve.Evaluate(toLogicTime);
				float y2 = attachPointCurve.attachPointRotYCurve.Evaluate(toLogicTime);
				float z2 = attachPointCurve.attachPointRotZCurve.Evaluate(toLogicTime);
				CompTransform compTransform = referenceEntity.GetCompTransform();
				Quaternion faceRotation = compTransform.FaceRotation;
				vector = faceRotation * new Vector3(x, y, z) + compTransform.physicsPosition;
				quaternion = faceRotation * Quaternion.Euler(x2, y2, z2);
				item = quaternion * Vector3.forward;
				item2 = vector + quaternion * anchorOffest;
			}
		}
		else
		{
			AttachPoint attachPointAll = referenceEntity.GetMono().GetAttachPointAll(attachPoint);
			vector = attachPointAll.GetPos();
			quaternion = attachPointAll.GetRotation();
			item = attachPointAll.GetForward();
			item2 = vector + quaternion * anchorOffest;
		}
		return (pos: vector, rot: quaternion, forward: item, anchor: item2);
	}
}
