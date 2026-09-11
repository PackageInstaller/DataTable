using System;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Obsolete]
public class ExtractColor : ExtractorNode<Color, float, float, float, float>
{
	public override void Invoke(Color color, out float r, out float g, out float b, out float a)
	{
		r = color.r;
		g = color.g;
		b = color.b;
		a = color.a;
	}
}
