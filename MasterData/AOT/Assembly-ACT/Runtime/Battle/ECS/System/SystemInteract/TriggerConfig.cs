using UnityEngine;

namespace Runtime.Battle.ECS.System.SystemInteract;

public struct TriggerConfig
{
	public TriggerType triggerType;

	public Bounds bounds;

	public Vector3 triggerCenter;

	public float radius;

	public Vector3 capsuleTriggerCenter;

	public float capsuleTriggerRadius;

	public float capsuleTriggerHeight;

	[Tooltip("0,1,2分别对应X,Y,Z轴")]
	public int capsuleTriggerDirection;
}
