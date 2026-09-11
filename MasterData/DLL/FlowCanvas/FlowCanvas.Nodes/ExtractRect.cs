using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractRect : ExtractorNode<Rect, Vector2, float, float, float, float>
{
	public override void Invoke(Rect rect, out Vector2 center, out float xMin, out float xMax, out float yMin, out float yMax)
	{
		center = rect.center;
		xMin = rect.xMin;
		xMax = rect.xMax;
		yMin = rect.yMin;
		yMax = rect.yMax;
	}
}
