using Entitas;

[IgnoreClone]
[Sim]
public class EntityAIMovement : IComponent
{
	public int mPrevAvoidEntityID;

	public int mDirection;

	public int mTimer;
}
