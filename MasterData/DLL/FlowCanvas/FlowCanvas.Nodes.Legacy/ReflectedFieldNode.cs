using System.Reflection;

namespace FlowCanvas.Nodes.Legacy;

public abstract class ReflectedFieldNode
{
	public static ReflectedFieldNode Create(FieldInfo field)
	{
		return new PureReflectedFieldNode();
	}

	public abstract void RegisterPorts(FlowNode node, FieldInfo field, ReflectedFieldNodeWrapper.AccessMode accessMode);
}
