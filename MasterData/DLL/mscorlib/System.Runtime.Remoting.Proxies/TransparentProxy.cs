using System.Reflection;
using System.Runtime.InteropServices;
using System.Runtime.Remoting.Contexts;
using System.Runtime.Remoting.Messaging;
using System.Threading;
using Mono;

namespace System.Runtime.Remoting.Proxies;

[StructLayout(LayoutKind.Sequential)]
internal class TransparentProxy
{
	public RealProxy _rp;

	private RuntimeRemoteClassHandle _class;

	private bool _custom_type_info;

	private bool IsContextBoundObject => GetProxyType().IsContextful;

	private Context TargetContext => _rp._targetContext;

	internal RuntimeType GetProxyType()
	{
		return (RuntimeType)Type.GetTypeFromHandle(_class.ProxyClass.GetTypeHandle());
	}

	private bool InCurrentContext()
	{
		if (IsContextBoundObject)
		{
			return TargetContext == Thread.CurrentContext;
		}
		return false;
	}

	internal object LoadRemoteFieldNew(IntPtr classPtr, IntPtr fieldPtr)
	{
		RuntimeClassHandle runtimeClassHandle = new RuntimeClassHandle(classPtr);
		RuntimeFieldHandle handle = new RuntimeFieldHandle(fieldPtr);
		RuntimeTypeHandle typeHandle = runtimeClassHandle.GetTypeHandle();
		FieldInfo fieldFromHandle = FieldInfo.GetFieldFromHandle(handle);
		if (InCurrentContext())
		{
			object server = _rp._server;
			return fieldFromHandle.GetValue(server);
		}
		string fullName = Type.GetTypeFromHandle(typeHandle).FullName;
		string name = fieldFromHandle.Name;
		object[] in_args = new object[2] { fullName, name };
		object[] out_args = new object[1];
		MethodInfo method = typeof(object).GetMethod("FieldGetter", BindingFlags.Instance | BindingFlags.NonPublic);
		if (method == null)
		{
			throw new MissingMethodException("System.Object", "FieldGetter");
		}
		MonoMethodMessage msg = new MonoMethodMessage(method, in_args, out_args);
		RealProxy.PrivateInvoke(_rp, msg, out var exc, out var out_args2);
		if (exc != null)
		{
			throw exc;
		}
		return out_args2[0];
	}

	internal void StoreRemoteField(IntPtr classPtr, IntPtr fieldPtr, object arg)
	{
		RuntimeClassHandle runtimeClassHandle = new RuntimeClassHandle(classPtr);
		RuntimeFieldHandle handle = new RuntimeFieldHandle(fieldPtr);
		RuntimeTypeHandle typeHandle = runtimeClassHandle.GetTypeHandle();
		FieldInfo fieldFromHandle = FieldInfo.GetFieldFromHandle(handle);
		if (InCurrentContext())
		{
			object server = _rp._server;
			fieldFromHandle.SetValue(server, arg);
			return;
		}
		string fullName = Type.GetTypeFromHandle(typeHandle).FullName;
		string name = fieldFromHandle.Name;
		object[] in_args = new object[3] { fullName, name, arg };
		MethodInfo method = typeof(object).GetMethod("FieldSetter", BindingFlags.Instance | BindingFlags.NonPublic);
		if (method == null)
		{
			throw new MissingMethodException("System.Object", "FieldSetter");
		}
		MonoMethodMessage msg = new MonoMethodMessage(method, in_args, null);
		RealProxy.PrivateInvoke(_rp, msg, out var exc, out var _);
		if (exc == null)
		{
			return;
		}
		throw exc;
	}
}
