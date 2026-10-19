using System;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Utility;

public struct TeleportParams
{
	public Vector3 targetPos;

	public bool faceLeft;

	public bool forceToFloor;

	public bool revive;

	public int swid;

	public Func<UniTask> afterPreparePosCallback;
}
