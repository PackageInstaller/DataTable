using System;
using UnityEngine;

namespace ACT.World.Behave;

[Serializable]
public struct ElevBehaveCustomData
{
	public bool useSpeed;

	public bool usePathTime;

	public float speed;

	public bool nonautoDirectMovement;

	public bool obstacleDetection;

	[Tooltip("一般检测盒宽度和模型大小一致")]
	public Vector3 boxSize;

	[Tooltip("未使用自定义检测点时，检车点是该物体pos")]
	public float stopDistance;

	public LayerMask colliderLayer;

	public bool x;

	public bool y;

	public bool z;

	public float waitTime;
}
