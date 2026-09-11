using System.Collections;
using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Messaging;

[ComVisible(true)]
public interface IMessage
{
	IDictionary Properties { get; }
}
