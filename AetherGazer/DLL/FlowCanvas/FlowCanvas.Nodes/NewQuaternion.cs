using System;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Utilities/Constructors")]
[Obsolete]
public class NewQuaternion : PureFunctionNode<Quaternion, float, float, float, float>
{
	public override Quaternion Invoke(float x, float y, float z, float w)
	{
		return new Quaternion(x, y, z, w);
	}
}
