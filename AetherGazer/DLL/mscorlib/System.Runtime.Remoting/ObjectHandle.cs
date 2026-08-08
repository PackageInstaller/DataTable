using System.Runtime.InteropServices;

namespace System.Runtime.Remoting;

[ClassInterface(ClassInterfaceType.AutoDual)]
[ComVisible(true)]
public class ObjectHandle : MarshalByRefObject
{
	private object _wrapped;

	public ObjectHandle(object o)
	{
		_wrapped = o;
	}

	public override object InitializeLifetimeService()
	{
		return base.InitializeLifetimeService();
	}

	public object Unwrap()
	{
		return _wrapped;
	}
}
