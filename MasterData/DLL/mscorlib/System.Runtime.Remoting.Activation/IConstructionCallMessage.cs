using System.Collections;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting.Activation;

[ComVisible(true)]
public interface IConstructionCallMessage : IMessage, IMethodCallMessage, IMethodMessage
{
	Type ActivationType { get; }

	string ActivationTypeName { get; }

	IActivator Activator { get; set; }

	object[] CallSiteActivationAttributes { get; }

	IList ContextProperties { get; }
}
