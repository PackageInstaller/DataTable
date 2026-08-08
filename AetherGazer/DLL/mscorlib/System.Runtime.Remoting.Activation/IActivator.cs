using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Activation;

[ComVisible(true)]
public interface IActivator
{
	IActivator NextActivator { get; }

	IConstructionReturnMessage Activate(IConstructionCallMessage msg);
}
