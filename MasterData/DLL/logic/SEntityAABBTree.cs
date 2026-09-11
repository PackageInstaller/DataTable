using Entitas;
using Entitas.CodeGeneration.Attributes;

[Unique]
[Sim]
public class SEntityAABBTree : IComponent
{
	public DynamicTree<ISimShape> mDynamicTree;
}
