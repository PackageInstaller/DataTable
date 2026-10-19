using System.Diagnostics;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using Unity;

namespace System.Reflection;

[Serializable]
public abstract class MethodBase : MemberInfo, _MethodBase
{
	public abstract MethodAttributes Attributes { get; }

	public virtual MethodImplAttributes MethodImplementationFlags => GetMethodImplementationFlags();

	public virtual CallingConventions CallingConvention => CallingConventions.Standard;

	public bool IsAbstract => (Attributes & MethodAttributes.Abstract) != 0;

	public bool IsConstructor
	{
		get
		{
			if (this is ConstructorInfo && !IsStatic)
			{
				return (Attributes & MethodAttributes.RTSpecialName) == MethodAttributes.RTSpecialName;
			}
			return false;
		}
	}

	public bool IsFinal => (Attributes & MethodAttributes.Final) != 0;

	public bool IsHideBySig => (Attributes & MethodAttributes.HideBySig) != 0;

	public bool IsSpecialName => (Attributes & MethodAttributes.SpecialName) != 0;

	public bool IsStatic => (Attributes & MethodAttributes.Static) != 0;

	public bool IsVirtual => (Attributes & MethodAttributes.Virtual) != 0;

	public bool IsAssembly => (Attributes & MethodAttributes.MemberAccessMask) == MethodAttributes.Assembly;

	public bool IsFamily => (Attributes & MethodAttributes.MemberAccessMask) == MethodAttributes.Family;

	public bool IsFamilyAndAssembly => (Attributes & MethodAttributes.MemberAccessMask) == MethodAttributes.FamANDAssem;

	public bool IsFamilyOrAssembly => (Attributes & MethodAttributes.MemberAccessMask) == MethodAttributes.FamORAssem;

	public bool IsPrivate => (Attributes & MethodAttributes.MemberAccessMask) == MethodAttributes.Private;

	public bool IsPublic => (Attributes & MethodAttributes.MemberAccessMask) == MethodAttributes.Public;

	public virtual bool IsConstructedGenericMethod
	{
		get
		{
			if (IsGenericMethod)
			{
				return !IsGenericMethodDefinition;
			}
			return false;
		}
	}

	public virtual bool IsGenericMethod => false;

	public virtual bool IsGenericMethodDefinition => false;

	public virtual bool ContainsGenericParameters => false;

	public abstract RuntimeMethodHandle MethodHandle { get; }

	public virtual bool IsSecurityCritical
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual bool IsSecuritySafeCritical
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public virtual bool IsSecurityTransparent
	{
		get
		{
			throw NotImplemented.ByDesign;
		}
	}

	public abstract ParameterInfo[] GetParameters();

	public abstract MethodImplAttributes GetMethodImplementationFlags();

	public virtual MethodBody GetMethodBody()
	{
		throw new InvalidOperationException();
	}

	public virtual Type[] GetGenericArguments()
	{
		throw new NotSupportedException("Derived classes must provide an implementation.");
	}

	[DebuggerHidden]
	[DebuggerStepThrough]
	public object Invoke(object obj, object[] parameters)
	{
		return Invoke(obj, BindingFlags.Default, null, parameters, null);
	}

	public abstract object Invoke(object obj, BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture);

	public override bool Equals(object obj)
	{
		return base.Equals(obj);
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public static bool operator ==(MethodBase left, MethodBase right)
	{
		if ((object)left == right)
		{
			return true;
		}
		if ((object)left == null || (object)right == null)
		{
			return false;
		}
		MethodInfo methodInfo;
		MethodInfo methodInfo2;
		if ((methodInfo = left as MethodInfo) != null && (methodInfo2 = right as MethodInfo) != null)
		{
			return methodInfo == methodInfo2;
		}
		ConstructorInfo constructorInfo;
		ConstructorInfo constructorInfo2;
		if ((constructorInfo = left as ConstructorInfo) != null && (constructorInfo2 = right as ConstructorInfo) != null)
		{
			return constructorInfo == constructorInfo2;
		}
		return false;
	}

	public static bool operator !=(MethodBase left, MethodBase right)
	{
		return !(left == right);
	}

	internal virtual ParameterInfo[] GetParametersInternal()
	{
		return GetParameters();
	}

	internal virtual int GetParametersCount()
	{
		return GetParametersInternal().Length;
	}

	internal virtual Type GetParameterType(int pos)
	{
		throw new NotImplementedException();
	}

	internal virtual int get_next_table_index(object obj, int table, int count)
	{
		throw new Exception("Method is not a builder method");
	}

	internal virtual string FormatNameAndSig(bool serialization)
	{
		StringBuilder stringBuilder = new StringBuilder(Name);
		stringBuilder.Append("(");
		stringBuilder.Append(ConstructParameters(GetParameterTypes(), CallingConvention, serialization));
		stringBuilder.Append(")");
		return stringBuilder.ToString();
	}

	internal virtual Type[] GetParameterTypes()
	{
		ParameterInfo[] parametersNoCopy = GetParametersNoCopy();
		Type[] array = new Type[parametersNoCopy.Length];
		for (int i = 0; i < parametersNoCopy.Length; i++)
		{
			array[i] = parametersNoCopy[i].ParameterType;
		}
		return array;
	}

	internal virtual ParameterInfo[] GetParametersNoCopy()
	{
		return GetParameters();
	}

	public static MethodBase GetMethodFromHandle(RuntimeMethodHandle handle)
	{
		if (handle.IsNullHandle())
		{
			throw new ArgumentException(Environment.GetResourceString("The handle is invalid."));
		}
		MethodBase methodFromHandleInternalType = RuntimeMethodInfo.GetMethodFromHandleInternalType(handle.Value, IntPtr.Zero);
		if (methodFromHandleInternalType == null)
		{
			throw new ArgumentException("The handle is invalid.");
		}
		Type declaringType = methodFromHandleInternalType.DeclaringType;
		if (declaringType != null && declaringType.IsGenericType)
		{
			throw new ArgumentException(string.Format(CultureInfo.CurrentCulture, Environment.GetResourceString("Cannot resolve method {0} because the declaring type of the method handle {1} is generic. Explicitly provide the declaring type to GetMethodFromHandle."), methodFromHandleInternalType, declaringType.GetGenericTypeDefinition()));
		}
		return methodFromHandleInternalType;
	}

	[ComVisible(false)]
	public static MethodBase GetMethodFromHandle(RuntimeMethodHandle handle, RuntimeTypeHandle declaringType)
	{
		if (handle.IsNullHandle())
		{
			throw new ArgumentException(Environment.GetResourceString("The handle is invalid."));
		}
		MethodBase methodFromHandleInternalType = RuntimeMethodInfo.GetMethodFromHandleInternalType(handle.Value, declaringType.Value);
		if (methodFromHandleInternalType == null)
		{
			throw new ArgumentException("The handle is invalid.");
		}
		return methodFromHandleInternalType;
	}

	internal static string ConstructParameters(Type[] parameterTypes, CallingConventions callingConvention, bool serialization)
	{
		StringBuilder stringBuilder = new StringBuilder();
		string value = "";
		foreach (Type obj in parameterTypes)
		{
			stringBuilder.Append(value);
			string text = obj.FormatTypeName(serialization);
			if (obj.IsByRef && !serialization)
			{
				stringBuilder.Append(text.TrimEnd(new char[1] { '&' }));
				stringBuilder.Append(" ByRef");
			}
			else
			{
				stringBuilder.Append(text);
			}
			value = ", ";
		}
		if ((callingConvention & CallingConventions.VarArgs) == CallingConventions.VarArgs)
		{
			stringBuilder.Append(value);
			stringBuilder.Append("...");
		}
		return stringBuilder.ToString();
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern MethodBase GetCurrentMethod();

	void _MethodBase.GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	Type _MethodBase.GetType()
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}

	void _MethodBase.GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _MethodBase.GetTypeInfoCount(out uint pcTInfo)
	{
		ThrowStub.ThrowNotSupportedException();
	}

	void _MethodBase.Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr)
	{
		ThrowStub.ThrowNotSupportedException();
	}
}
