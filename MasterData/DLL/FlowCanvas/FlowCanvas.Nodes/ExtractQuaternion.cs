using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractQuaternion : ExtractorNode<Quaternion, float, float, float, float, Vector3>
{
	public override void Invoke(Quaternion quaternion, out float x, out float y, out float z, out float w, out Vector3 eulerAngles)
	{
		x = quaternion.x;
		y = quaternion.y;
		z = quaternion.z;
		w = quaternion.w;
		eulerAngles = quaternion.eulerAngles;
	}
}
