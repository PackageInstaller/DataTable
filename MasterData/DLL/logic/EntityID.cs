using Entitas;
using Entitas.CodeGeneration.Attributes;

[Sim]
[IgnoreClone]
public class EntityID : IComponent
{
	[PrimaryEntityIndex]
	public int mID;
}
