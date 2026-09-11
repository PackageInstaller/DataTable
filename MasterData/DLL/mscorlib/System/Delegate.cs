using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
public abstract class Delegate : ICloneable, ISerializable
{
	private IntPtr method_ptr;

	private IntPtr invoke_impl;

	private object m_target;

	private IntPtr method;

	private IntPtr delegate_trampoline;

	private IntPtr extra_arg;

	private IntPtr method_code;

	private IntPtr interp_method;

	private IntPtr interp_invoke_impl;

	private MethodInfo method_info;

	private MethodInfo original_method_info;

	private DelegateData data;

	private bool method_is_virtual;

	public MethodInfo Method => GetMethodImpl();

	public object Target => m_target;

	protected Delegate(object target, string method)
	{
		if (target == null)
		{
			throw new ArgumentNullException("target");
		}
		if (method == null)
		{
			throw new ArgumentNullException("method");
		}
		m_target = target;
		data = new DelegateData();
		data.method_name = method;
	}

	protected Delegate(Type target, string method)
	{
		if (target == null)
		{
			throw new ArgumentNullException("target");
		}
		if (method == null)
		{
			throw new ArgumentNullException("method");
		}
		data = new DelegateData();
		data.method_name = method;
		data.target_type = target;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern MethodInfo GetVirtualMethod_internal();

	internal IntPtr GetNativeFunctionPointer()
	{
		return method_ptr;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern Delegate CreateDelegate_internal(Type type, object target, MethodInfo info, bool throwOnBindFailure);

	private static bool arg_type_match(Type delArgType, Type argType)
	{
		bool flag = delArgType == argType;
		if (!flag && !argType.IsValueType && argType.IsAssignableFrom(delArgType))
		{
			flag = true;
		}
		if (!flag)
		{
			if (delArgType.IsEnum && Enum.GetUnderlyingType(delArgType) == argType)
			{
				flag = true;
			}
			else if (argType.IsEnum && Enum.GetUnderlyingType(argType) == delArgType)
			{
				flag = true;
			}
		}
		return flag;
	}

	private static bool arg_type_match_this(Type delArgType, Type argType, bool boxedThis)
	{
		if (argType.IsValueType)
		{
			return (delArgType.IsByRef && delArgType.GetElementType() == argType) || (boxedThis && delArgType == argType);
		}
		return delArgType == argType || argType.IsAssignableFrom(delArgType);
	}

	private static bool return_type_match(Type delReturnType, Type returnType)
	{
		bool flag = returnType == delReturnType;
		if (!flag)
		{
			if (!returnType.IsValueType && delReturnType.IsAssignableFrom(returnType))
			{
				flag = true;
			}
			else
			{
				bool isEnum = delReturnType.IsEnum;
				bool isEnum2 = returnType.IsEnum;
				if (isEnum2 & isEnum)
				{
					flag = Enum.GetUnderlyingType(delReturnType) == Enum.GetUnderlyingType(returnType);
				}
				else if (isEnum && Enum.GetUnderlyingType(delReturnType) == returnType)
				{
					flag = true;
				}
				else if (isEnum2 && Enum.GetUnderlyingType(returnType) == delReturnType)
				{
					flag = true;
				}
			}
		}
		return flag;
	}

	public static Delegate CreateDelegate(Type type, object firstArgument, MethodInfo method, bool throwOnBindFailure)
	{
		return CreateDelegate(type, firstArgument, method, throwOnBindFailure, allowClosed: true);
	}

	private static Delegate CreateDelegate(Type type, object firstArgument, MethodInfo method, bool throwOnBindFailure, bool allowClosed)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (method == null)
		{
			throw new ArgumentNullException("method");
		}
		if (!type.IsSubclassOf(typeof(MulticastDelegate)))
		{
			throw new ArgumentException("type is not a subclass of Multicastdelegate");
		}
		MethodInfo methodInfo = type.GetMethod("Invoke");
		if (!return_type_match(methodInfo.ReturnType, method.ReturnType))
		{
			if (throwOnBindFailure)
			{
				throw new ArgumentException("method return type is incompatible");
			}
			return null;
		}
		ParameterInfo[] parametersInternal = methodInfo.GetParametersInternal();
		ParameterInfo[] parametersInternal2 = method.GetParametersInternal();
		bool flag;
		if (firstArgument != null)
		{
			flag = (method.IsStatic ? (parametersInternal2.Length == parametersInternal.Length + 1) : (parametersInternal2.Length == parametersInternal.Length));
		}
		else if (!method.IsStatic)
		{
			flag = parametersInternal2.Length + 1 == parametersInternal.Length;
			if (!flag)
			{
				flag = parametersInternal2.Length == parametersInternal.Length;
			}
		}
		else
		{
			flag = parametersInternal2.Length == parametersInternal.Length;
			if (!flag)
			{
				flag = parametersInternal2.Length == parametersInternal.Length + 1;
			}
		}
		if (!flag)
		{
			if (throwOnBindFailure)
			{
				throw new TargetParameterCountException("Parameter count mismatch.");
			}
			return null;
		}
		DelegateData delegateData = new DelegateData();
		bool flag2;
		if (firstArgument != null)
		{
			if (!method.IsStatic)
			{
				flag2 = arg_type_match_this(firstArgument.GetType(), method.DeclaringType, boxedThis: true);
				for (int i = 0; i < parametersInternal2.Length; i++)
				{
					flag2 &= arg_type_match(parametersInternal[i].ParameterType, parametersInternal2[i].ParameterType);
				}
			}
			else
			{
				flag2 = arg_type_match(firstArgument.GetType(), parametersInternal2[0].ParameterType);
				for (int j = 1; j < parametersInternal2.Length; j++)
				{
					flag2 &= arg_type_match(parametersInternal[j - 1].ParameterType, parametersInternal2[j].ParameterType);
				}
				delegateData.curried_first_arg = true;
			}
		}
		else if (!method.IsStatic)
		{
			if (parametersInternal2.Length + 1 == parametersInternal.Length)
			{
				flag2 = arg_type_match_this(parametersInternal[0].ParameterType, method.DeclaringType, boxedThis: false);
				for (int k = 0; k < parametersInternal2.Length; k++)
				{
					flag2 &= arg_type_match(parametersInternal[k + 1].ParameterType, parametersInternal2[k].ParameterType);
				}
			}
			else
			{
				flag2 = allowClosed;
				for (int l = 0; l < parametersInternal2.Length; l++)
				{
					flag2 &= arg_type_match(parametersInternal[l].ParameterType, parametersInternal2[l].ParameterType);
				}
			}
		}
		else if (parametersInternal.Length + 1 == parametersInternal2.Length)
		{
			flag2 = (!parametersInternal2[0].ParameterType.IsValueType && !parametersInternal2[0].ParameterType.IsByRef) & allowClosed;
			for (int m = 0; m < parametersInternal.Length; m++)
			{
				flag2 &= arg_type_match(parametersInternal[m].ParameterType, parametersInternal2[m + 1].ParameterType);
			}
			delegateData.curried_first_arg = true;
		}
		else
		{
			flag2 = true;
			for (int n = 0; n < parametersInternal2.Length; n++)
			{
				flag2 &= arg_type_match(parametersInternal[n].ParameterType, parametersInternal2[n].ParameterType);
			}
		}
		if (!flag2)
		{
			if (throwOnBindFailure)
			{
				throw new ArgumentException("method arguments are incompatible");
			}
			return null;
		}
		Delegate obj = CreateDelegate_internal(type, firstArgument, method, throwOnBindFailure);
		if ((object)obj != null)
		{
			obj.original_method_info = method;
		}
		if (delegateData != null)
		{
			obj.data = delegateData;
		}
		return obj;
	}

	public static Delegate CreateDelegate(Type type, object firstArgument, MethodInfo method)
	{
		return CreateDelegate(type, firstArgument, method, throwOnBindFailure: true, allowClosed: true);
	}

	public static Delegate CreateDelegate(Type type, MethodInfo method, bool throwOnBindFailure)
	{
		return CreateDelegate(type, null, method, throwOnBindFailure, allowClosed: false);
	}

	public static Delegate CreateDelegate(Type type, MethodInfo method)
	{
		return CreateDelegate(type, method, throwOnBindFailure: true);
	}

	public static Delegate CreateDelegate(Type type, object target, string method)
	{
		return CreateDelegate(type, target, method, ignoreCase: false);
	}

	private static MethodInfo GetCandidateMethod(Type type, Type target, string method, BindingFlags bflags, bool ignoreCase, bool throwOnBindFailure)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		if (method == null)
		{
			throw new ArgumentNullException("method");
		}
		if (!type.IsSubclassOf(typeof(MulticastDelegate)))
		{
			throw new ArgumentException("type is not subclass of MulticastDelegate.");
		}
		MethodInfo methodInfo = type.GetMethod("Invoke");
		ParameterInfo[] parametersInternal = methodInfo.GetParametersInternal();
		Type[] array = new Type[parametersInternal.Length];
		for (int i = 0; i < parametersInternal.Length; i++)
		{
			array[i] = parametersInternal[i].ParameterType;
		}
		BindingFlags bindingFlags = BindingFlags.DeclaredOnly | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.ExactBinding | bflags;
		if (ignoreCase)
		{
			bindingFlags |= BindingFlags.IgnoreCase;
		}
		MethodInfo methodInfo2 = null;
		Type type2 = target;
		while (type2 != null)
		{
			MethodInfo methodInfo3 = type2.GetMethod(method, bindingFlags, null, array, Array.Empty<ParameterModifier>());
			if (methodInfo3 != null && return_type_match(methodInfo.ReturnType, methodInfo3.ReturnType))
			{
				methodInfo2 = methodInfo3;
				break;
			}
			type2 = type2.BaseType;
		}
		if (methodInfo2 == null)
		{
			if (throwOnBindFailure)
			{
				throw new ArgumentException("Couldn't bind to method '" + method + "'.");
			}
			return null;
		}
		return methodInfo2;
	}

	public static Delegate CreateDelegate(Type type, Type target, string method, bool ignoreCase, bool throwOnBindFailure)
	{
		if (target == null)
		{
			throw new ArgumentNullException("target");
		}
		MethodInfo candidateMethod = GetCandidateMethod(type, target, method, BindingFlags.Static, ignoreCase, throwOnBindFailure);
		if (candidateMethod == null)
		{
			return null;
		}
		return CreateDelegate_internal(type, null, candidateMethod, throwOnBindFailure);
	}

	public static Delegate CreateDelegate(Type type, Type target, string method)
	{
		return CreateDelegate(type, target, method, ignoreCase: false, throwOnBindFailure: true);
	}

	public static Delegate CreateDelegate(Type type, Type target, string method, bool ignoreCase)
	{
		return CreateDelegate(type, target, method, ignoreCase, throwOnBindFailure: true);
	}

	public static Delegate CreateDelegate(Type type, object target, string method, bool ignoreCase, bool throwOnBindFailure)
	{
		if (target == null)
		{
			throw new ArgumentNullException("target");
		}
		MethodInfo candidateMethod = GetCandidateMethod(type, target.GetType(), method, BindingFlags.Instance, ignoreCase, throwOnBindFailure);
		if (candidateMethod == null)
		{
			return null;
		}
		return CreateDelegate_internal(type, target, candidateMethod, throwOnBindFailure);
	}

	public static Delegate CreateDelegate(Type type, object target, string method, bool ignoreCase)
	{
		return CreateDelegate(type, target, method, ignoreCase, throwOnBindFailure: true);
	}

	public object DynamicInvoke(params object[] args)
	{
		return DynamicInvokeImpl(args);
	}

	private void InitializeDelegateData()
	{
		DelegateData delegateData = new DelegateData();
		if (method_info.IsStatic)
		{
			if (m_target != null)
			{
				delegateData.curried_first_arg = true;
			}
			else if (GetType().GetMethod("Invoke").GetParametersCount() + 1 == method_info.GetParametersCount())
			{
				delegateData.curried_first_arg = true;
			}
		}
		data = delegateData;
	}

	protected virtual object DynamicInvokeImpl(object[] args)
	{
		if (Method == null)
		{
			Type[] array = new Type[args.Length];
			for (int i = 0; i < args.Length; i++)
			{
				array[i] = args[i].GetType();
			}
			method_info = m_target.GetType().GetMethod(data.method_name, array);
		}
		object obj = m_target;
		if (data == null)
		{
			InitializeDelegateData();
		}
		if (Method.IsStatic)
		{
			if (data.curried_first_arg)
			{
				if (args == null)
				{
					args = new object[1] { obj };
				}
				else
				{
					Array.Resize(ref args, args.Length + 1);
					Array.Copy(args, 0, args, 1, args.Length - 1);
					args[0] = obj;
				}
				obj = null;
			}
		}
		else if (m_target == null && args != null && args.Length != 0)
		{
			obj = args[0];
			Array.Copy(args, 1, args, 0, args.Length - 1);
			Array.Resize(ref args, args.Length - 1);
		}
		return Method.Invoke(obj, args);
	}

	public virtual object Clone()
	{
		return MemberwiseClone();
	}

	public override bool Equals(object obj)
	{
		if (!(obj is Delegate obj2))
		{
			return false;
		}
		if (obj2.m_target == m_target && obj2.Method == Method)
		{
			if (obj2.data != null || data != null)
			{
				if (obj2.data != null && data != null)
				{
					if (obj2.data.target_type == data.target_type)
					{
						return obj2.data.method_name == data.method_name;
					}
					return false;
				}
				if (obj2.data != null)
				{
					return obj2.data.target_type == null;
				}
				if (data != null)
				{
					return data.target_type == null;
				}
				return false;
			}
			return true;
		}
		return false;
	}

	public override int GetHashCode()
	{
		MethodInfo methodInfo = Method;
		return ((methodInfo != null) ? methodInfo.GetHashCode() : GetType().GetHashCode()) ^ RuntimeHelpers.GetHashCode(m_target);
	}

	protected virtual MethodInfo GetMethodImpl()
	{
		if (method_info != null)
		{
			return method_info;
		}
		if (method != IntPtr.Zero)
		{
			if (!method_is_virtual)
			{
				method_info = (MethodInfo)RuntimeMethodInfo.GetMethodFromHandleNoGenericCheck(new RuntimeMethodHandle(method));
			}
			else
			{
				method_info = GetVirtualMethod_internal();
			}
		}
		return method_info;
	}

	public virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		DelegateSerializationHolder.GetDelegateData(this, info, context);
	}

	public virtual Delegate[] GetInvocationList()
	{
		return new Delegate[1] { this };
	}

	public static Delegate Combine(Delegate a, Delegate b)
	{
		if ((object)a == null)
		{
			return b;
		}
		if ((object)b == null)
		{
			return a;
		}
		if (a.GetType() != b.GetType())
		{
			throw new ArgumentException($"Incompatible Delegate Types. First is {a.GetType().FullName} second is {b.GetType().FullName}.");
		}
		return a.CombineImpl(b);
	}

	[ComVisible(true)]
	public static Delegate Combine(params Delegate[] delegates)
	{
		if (delegates == null)
		{
			return null;
		}
		Delegate obj = null;
		foreach (Delegate b in delegates)
		{
			obj = Combine(obj, b);
		}
		return obj;
	}

	protected virtual Delegate CombineImpl(Delegate d)
	{
		throw new MulticastNotSupportedException(string.Empty);
	}

	public static Delegate Remove(Delegate source, Delegate value)
	{
		if ((object)source == null)
		{
			return null;
		}
		if ((object)value == null)
		{
			return source;
		}
		if (source.GetType() != value.GetType())
		{
			throw new ArgumentException($"Incompatible Delegate Types. First is {source.GetType().FullName} second is {value.GetType().FullName}.");
		}
		return source.RemoveImpl(value);
	}

	protected virtual Delegate RemoveImpl(Delegate d)
	{
		if (Equals(d))
		{
			return null;
		}
		return this;
	}

	public static Delegate RemoveAll(Delegate source, Delegate value)
	{
		Delegate obj = source;
		while ((source = Remove(source, value)) != obj)
		{
			obj = source;
		}
		return obj;
	}

	public static bool operator ==(Delegate d1, Delegate d2)
	{
		if ((object)d1 == null)
		{
			if ((object)d2 == null)
			{
				return true;
			}
			return false;
		}
		if ((object)d2 == null)
		{
			return false;
		}
		return d1.Equals(d2);
	}

	public static bool operator !=(Delegate d1, Delegate d2)
	{
		return !(d1 == d2);
	}

	internal bool IsTransparentProxy()
	{
		return false;
	}

	internal static Delegate CreateDelegateNoSecurityCheck(RuntimeType type, object firstArgument, MethodInfo method)
	{
		return CreateDelegate_internal(type, firstArgument, method, throwOnBindFailure: true);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern MulticastDelegate AllocDelegateLike_internal(Delegate d);
}
