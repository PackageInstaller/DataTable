using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Utilities/Constructors")]
[Obsolete]
public class NewVector4 : PureFunctionNode<Vector4, float, float, float, float>
{
	public override Vector4 Invoke(float x, float y, float z, float w)
	{
		return new Vector4(x, y, z, w);
	}
}
