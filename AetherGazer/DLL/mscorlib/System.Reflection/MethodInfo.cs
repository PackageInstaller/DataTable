using System.Runtime.InteropServices;
using Unity;

namespace System.Reflection;

[Serializable]
public abstract class MethodInfo : MethodBase, _MethodInfo
{
	public override MemberTypes MemberType => MemberTypes.Method;

	public virtual ParameterInfo ReturnParameter
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual Type ReturnType
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public abstract ICustomAttributeProvider ReturnTypeCustomAttributes { get; }

	internal virtual int GenericParameterCount => GetGenericArguments().Length;

	public override Type[] GetGenericArguments()
	{
		throw new NotSupportedException("Derived classes must provide an implementation.");
	}

	public virtual MethodInfo GetGenericMethodDefinition()
	{
		throw new NotSupportedException("Derived classes must provide an implementation.");
	}

	public virtual MethodInfo MakeGenericMethod(params Type[] typeArguments)
	{
		throw new NotSupportedException("Derived classes must provide an implementation.");
	}

	public abstract MethodInfo GetBaseDefinition();

	public virtual Delegate CreateDelegate(Type delegateType)
	{
		throw new NotSupportedException("Derived classes must provide an implementation.");
	}

	public virtual Delegate CreateDelegate(Type delegateType, object target)
	{
		throw new NotSupportedException("Derived classes must provide an implementation.");
	}

	public override bool Equals(object obj)
	{
		return base.Equals(obj);
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public static bool operator ==(MethodInfo left, MethodInfo right)
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

	public static bool operator !=(MethodInfo left, MethodInfo right)
	{
		return !(left == right);
	}

	void _MethodInfo.GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	Type _MethodInfo.GetType()
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	void _MethodInfo.GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _MethodInfo.GetTypeInfoCount(out uint pcTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _MethodInfo.Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr)
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
