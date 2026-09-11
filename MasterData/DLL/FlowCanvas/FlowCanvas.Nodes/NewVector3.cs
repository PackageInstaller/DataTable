using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Utilities/Constructors")]
[Obsolete]
public class NewVector3 : PureFunctionNode<Vector3, float, float, float>
{
	public override Vector3 Invoke(float x, float y, float z)
	{
		return new Vector3(x, y, z);
	}
}
