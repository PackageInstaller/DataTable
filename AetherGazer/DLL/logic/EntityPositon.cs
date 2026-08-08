using Entitas;

[Sim]
public class EntityPositon : IComponent
{
	[VarBinding(EntityVarName.ENTITY_POS, true, false, false, "")]
	public Int3 mPosition;

	[VarBinding(EntityVarName.ENTITY_FOWARD, true, false, false, "")]
	public Int3 mForward;

	public Int mForwardAngle;

	[VarBinding(EntityVarName.ENTITY_UP, true, false, false, "")]
	public Int3 mUp;

	public bool IsTeleport;
}
