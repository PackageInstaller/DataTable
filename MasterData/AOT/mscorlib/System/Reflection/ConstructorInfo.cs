using System.Diagnostics;
using System.Globalization;
using System.Runtime.InteropServices;
using Unity;

namespace System.Reflection;

[Serializable]
public abstract class ConstructorInfo : MethodBase, _ConstructorInfo
{
	public static readonly string ConstructorName = ".ctor";

	public static readonly string TypeConstructorName = ".cctor";

	public override MemberTypes MemberType => MemberTypes.Constructor;

	[DebuggerStepThrough]
	[DebuggerHidden]
	public object Invoke(object[] parameters)
	{
		return Invoke(BindingFlags.CreateInstance, null, parameters, null);
	}

	public abstract object Invoke(BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture);

	public override bool Equals(object obj)
	{
		return base.Equals(obj);
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public static bool operator ==(ConstructorInfo left, ConstructorInfo right)
	{
		if ((object)left == right)
		{
			return true;
		}
		if ((object)left == null || (object)right == null)
		{
			return false;
		}
		return left.Equals(right);
	}

	public static bool operator !=(ConstructorInfo left, ConstructorInfo right)
	{
		return !(left == right);
	}

	void _ConstructorInfo.GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	Type _ConstructorInfo.GetType()
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	void _ConstructorInfo.GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _ConstructorInfo.GetTypeInfoCount(out uint pcTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _ConstructorInfo.Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	object _ConstructorInfo.Invoke_2(object obj, BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture)
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	object _ConstructorInfo.Invoke_3(object obj, object[] parameters)
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	object _ConstructorInfo.Invoke_4(BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture)
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	object _ConstructorInfo.Invoke_5(object[] parameters)
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}
}
