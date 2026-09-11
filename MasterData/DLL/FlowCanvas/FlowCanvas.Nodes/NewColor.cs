using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Utilities/Constructors")]
[Obsolete]
public class NewColor : PureFunctionNode<Color, float, float, float, float>
{
	public override Color Invoke(float r, float g, float b, float a = 1f)
	{
		return new Color(r, g, b, a);
	}
}
