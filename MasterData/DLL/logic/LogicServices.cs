using Entitas;
using Entitas.CodeGeneration.Attributes;
using Services;

[Sim]
[Unique]
public class LogicServices : IComponent
{
	public CommonService mService;
}
