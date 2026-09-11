using System;

namespace UnityEngine;

[Serializable]
public struct FrustumPlanes
{
	public float left;

	public float right;

	public float bottom;

	public float top;

	public float zNear;

	public float zFar;
}
