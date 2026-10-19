using System;
using Runtime.Battle.ECS.System.SystemInteract;
using UnityEngine;

namespace ACT.Config;

[Serializable]
public sealed class NpcTriggerDefaultConfig
{
	public Vector3 sphereCenter = new Vector3(0f, 1f, 0f);

	public float sphereRadius = 2f;

	public Vector3 boxCenter = new Vector3(0f, 1f, 0f);

	public Vector3 boxExtent = new Vector3(1f, 1f, 2f);

	public Vector3 capsuleCenter = new Vector3(0f, 1f, 0f);

	public float capsuleRadius = 1f;

	public float capsuleHeight = 3f;

	[Tooltip("0, 1, 2 分别对应 X, Y, Z 轴")]
	public int capsuleDirection = 1;

	public TriggerConfig CreateTriggerConfig()
	{
		return new TriggerConfig
		{
			triggerType = TriggerType.Sphere,
			triggerCenter = sphereCenter,
			radius = sphereRadius,
			bounds = new Bounds(boxCenter, boxExtent * 2f),
			capsuleTriggerCenter = capsuleCenter,
			capsuleTriggerRadius = capsuleRadius,
			capsuleTriggerHeight = capsuleHeight,
			capsuleTriggerDirection = capsuleDirection
		};
	}
}
