using Entitas;
using Entitas.CodeGeneration.Attributes;

[Sim]
[Unique]
public class SEntityWorldState : IComponent
{
	public SimWorldState status;
}
