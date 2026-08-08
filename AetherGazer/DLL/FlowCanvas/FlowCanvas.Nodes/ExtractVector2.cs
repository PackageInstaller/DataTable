using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractVector2 : ExtractorNode<Vector2, float, float>
{
	public override void Invoke(Vector2 vector, out float x, out float y)
	{
		x = vector.x;
		y = vector.y;
	}
}
