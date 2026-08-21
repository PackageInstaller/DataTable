using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractVector4 : ExtractorNode<Vector4, float, float, float, float>
{
	public override void Invoke(Vector4 vector, out float x, out float y, out float z, out float w)
	{
		x = vector.x;
		y = vector.y;
		z = vector.z;
		w = vector.w;
	}
}
