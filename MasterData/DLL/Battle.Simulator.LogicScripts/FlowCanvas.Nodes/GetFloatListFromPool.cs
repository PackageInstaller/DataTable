using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("FrameListPoolGetFloatList", 0)]
[Category("Logic/Control")]
[Description("从池中获取Float类型List")]
public class GetFloatListFromPool : CallableFunctionNode<List<float>>
{
	public override List<float> Invoke()
	{
		return FrameListPool<float>.Claim();
	}
}
