using System.Runtime.InteropServices;
using System.Runtime.Remoting.Messaging;

namespace System.Runtime.Remoting.Activation;

[ComVisible(true)]
public interface IConstructionReturnMessage : IMethodReturnMessage, IMethodMessage, IMessage
{
}
