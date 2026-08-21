using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("放回Int类型List", 0)]
[Category("Logic/Control")]
[Description("将Int类型List放回池中")]
public class ReleaseIntListToPoool : CallableActionNode<List<int>>
{
	public override void Invoke(List<int> intList)
	{
		FrameListPool<int>.Release(intList);
	}
}
