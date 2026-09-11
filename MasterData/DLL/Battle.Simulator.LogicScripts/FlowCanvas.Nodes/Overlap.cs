using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("圆形区域搜索(过时)", 0)]
[Category("Logic/PosAndRot")]
[Description("搜索所有进入圆形区域的单位")]
[ExposeAsDefinition]
public class Overlap : CallableFunctionNode<List<int>, Int3, int, List<int>, int>
{
	public override List<int> Invoke(Int3 position, int raidius, List<int> collisions, int layer)
	{
		SimPhysics.Overlap(position, raidius, collisions, (uint)layer);
		return collisions;
	}
}
