using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class TransformParent : IDataToBake
{
	public StateWorldUid parentSwUid = int.MinValue;

	public Vector3 offset;

	public Vector3 rotateOffset;
}
