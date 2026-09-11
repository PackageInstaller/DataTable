using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting.Activation;

internal class RemoteActivator : MarshalByRefObject, IActivator
{
	public IActivator NextActivator
	{
		get
		{
			throw new NotSupportedException();
		}
	}

	public IConstructionReturnMessage Activate(IConstructionCallMessage msg)
	{
		if (!RemotingConfiguration.IsActivationAllowed(msg.ActivationType))
		{
			throw new RemotingException("The type " + msg.ActivationTypeName + " is not allowed to be client activated");
		}
		object[] activationAttributes = null;
		if (msg.ActivationType.IsContextful)
		{
			activationAttributes = new object[1]
			{
				new RemoteActivationAttribute(msg.ContextProperties)
			};
		}
		return new ConstructionResponse(RemotingServices.Marshal((MarshalByRefObject)Activator.CreateInstance(msg.ActivationType, msg.Args, activationAttributes)), null, msg);
	}
}
