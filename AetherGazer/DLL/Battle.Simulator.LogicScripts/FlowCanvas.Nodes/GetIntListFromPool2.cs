using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("FrameListPoolGetIntList", 0)]
[Category("Logic/Control")]
[Description("从池中获取Int类型List")]
public class GetIntListFromPool2 : CallableFunctionNode<List<int>>
{
	public override List<int> Invoke()
	{
		return FrameListPool<int>.Claim();
	}
}
