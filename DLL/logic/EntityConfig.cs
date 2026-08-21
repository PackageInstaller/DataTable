using Entitas;
using Google.Protobuf;

[Sim]
public class EntityConfig : IComponent
{
	public IMessage mConfig;

	[VarBinding(EntityVarName.ENTITY_CONFIG_ID, true, false, false, "")]
	public int mId;
}
