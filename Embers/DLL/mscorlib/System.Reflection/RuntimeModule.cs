using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Reflection;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[ComDefaultInterface(typeof(_Module))]
[ClassInterface(ClassInterfaceType.None)]
[ComVisible(true)]
internal class RuntimeModule : Module
{
	internal IntPtr _impl;

	internal Assembly assembly;

	internal string fqname;

	internal string name;

	internal string scopename;

	internal bool is_resource;

	internal int token;

	public override Assembly Assembly => assembly;

	public override string ScopeName => scopename;

	public override Guid ModuleVersionId => GetModuleVersionId();

	internal IntPtr MonoModule => _impl;

	public override bool IsResource()
	{
		return is_resource;
	}

	public override object[] GetCustomAttributes(bool inherit)
	{
		return MonoCustomAttrs.GetCustomAttributes(this, inherit);
	}

	public override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		return MonoCustomAttrs.GetCustomAttributes(this, attributeType, inherit);
	}

	internal override ModuleHandle GetModuleHandleImpl()
	{
		return new ModuleHandle(_impl);
	}

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		return MonoCustomAttrs.IsDefined(this, attributeType, inherit);
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		UnitySerializationHolder.GetUnitySerializationInfo(info, 5, ScopeName, GetRuntimeAssembly());
	}

	internal RuntimeAssembly GetRuntimeAssembly()
	{
		return (RuntimeAssembly)assembly;
	}

	internal override Guid GetModuleVersionId()
	{
		byte[] array = new byte[16];
		GetGuidInternal(_impl, array);
		return new Guid(array);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern IntPtr GetHINSTANCE(IntPtr module);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void GetGuidInternal(IntPtr module, byte[] guid);
}
