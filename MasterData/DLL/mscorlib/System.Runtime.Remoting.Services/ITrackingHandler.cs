using System.Runtime.InteropServices;

namespace System.Runtime.Remoting.Services;

[ComVisible(true)]
public interface ITrackingHandler
{
	void DisconnectedObject(object obj);

	void MarshaledObject(object obj, ObjRef or);

	void UnmarshaledObject(object obj, ObjRef or);
}
