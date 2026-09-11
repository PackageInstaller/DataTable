using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("矩形区域搜索(过时)", 0)]
[Category("Logic/PosAndRot")]
[Description("搜索所有进入矩形区域的单位")]
[ExposeAsDefinition]
public class OverlapBox : CallableFunctionNode<List<int>, Int3, Int3, Int3, Int3, List<int>, int>
{
	public override List<int> Invoke(Int3 position, Int3 forward, Int3 center, Int3 size, List<int> collisions, int layer)
	{
		SimPhysics.OverlapBox(position, forward, center, size, collisions, (uint)layer);
		return collisions;
	}
}
