using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Utilities/Constructors")]
[Obsolete]
public class NewRect : PureFunctionNode<Rect, float, float, float, float>
{
	public override Rect Invoke(float left, float top, float width, float height)
	{
		return new Rect(left, top, width, height);
	}
}
