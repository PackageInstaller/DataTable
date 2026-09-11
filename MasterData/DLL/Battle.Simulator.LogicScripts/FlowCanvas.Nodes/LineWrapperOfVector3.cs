using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("理线器(Vector3)", 0)]
[Category("通用/理线器")]
[Description("传递 Vector3 类型的数值")]
public class LineWrapperOfVector3 : PureFunctionNode<Vector3, Vector3>
{
	public override Vector3 Invoke(Vector3 a)
	{
		return a;
	}
}
