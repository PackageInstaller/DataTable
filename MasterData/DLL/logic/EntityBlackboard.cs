using Entitas;

[Sim]
public class EntityBlackboard : IComponent
{
	[Clone(true, false, "")]
	public SimBlackboard var;
}
