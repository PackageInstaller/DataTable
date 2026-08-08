using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Utilities/Constructors")]
[Obsolete]
public class NewVector2 : PureFunctionNode<Vector2, float, float>
{
	public override Vector2 Invoke(float x, float y)
	{
		return new Vector2(x, y);
	}
}
