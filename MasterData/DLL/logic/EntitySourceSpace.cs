using Entitas;
using Entitas.CodeGeneration.Attributes;

[Unique]
[Sim]
public class EntitySourceSpace : IComponent
{
	public bool Enable;

	public int SourceSpaceKeepTime;

	public int SourceSpaceDelayTime;

	public int SourceSpaceExitTime;

	public int SourceSpaceRaceID;

	public int LimitDodgeCD;

	public int BreakEntityID;

	public bool ManualMode;
}
