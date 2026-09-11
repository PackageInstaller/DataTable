using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("FrameListPoolReleaseFloat", 0)]
[Category("Logic/Control")]
[Description("将Float类型List放回池中")]
public class ReleaseFloatListToPool : CallableActionNode<List<float>>
{
	public override void Invoke(List<float> floatList)
	{
		FrameListPool<float>.Release(floatList);
	}
}
