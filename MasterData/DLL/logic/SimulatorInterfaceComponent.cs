using Entitas;
using Entitas.CodeGeneration.Attributes;

[Sim]
[Unique]
public sealed class SimulatorInterfaceComponent : IComponent
{
	public ISimulatorInferface value;
}
