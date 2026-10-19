using System.Runtime.InteropServices;

namespace System.Runtime.Remoting;

[ComVisible(true)]
[ClassInterface(ClassInterfaceType.AutoDual)]
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
