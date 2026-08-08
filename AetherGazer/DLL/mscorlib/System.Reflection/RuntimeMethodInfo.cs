using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Text;
using System.Threading;

namespace System.Reflection;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
internal class RuntimeMethodInfo : MethodInfo, ISerializable
{
	internal IntPtr mhandle;

	private string name;

	private Type reftype;

	internal BindingFlags BindingFlags => BindingFlags.Default;

	public override Module Module => GetRuntimeModule();

	private RuntimeType ReflectedTypeInternal => (RuntimeType)ReflectedType;

	public override ParameterInfo ReturnParameter => MonoMethodInfo.GetReturnParameterInfo(this);

	public override Type ReturnType => MonoMethodInfo.GetReturnType(mhandle);

	public override ICustomAttributeProvider ReturnTypeCustomAttributes => MonoMethodInfo.GetReturnParameterInfo(this);

	public override int MetadataToken => get_metadata_token(this);

	public override RuntimeMethodHandle MethodHandle => new RuntimeMethodHandle(mhandle);

	public override MethodAttributes Attributes => MonoMethodInfo.GetAttributes(mhandle);

	public override CallingConventions CallingConvention => MonoMethodInfo.GetCallingConvention(mhandle);

	public override Type ReflectedType => reftype;

	public override Type DeclaringType => MonoMethodInfo.GetDeclaringType(mhandle);

	public override string Name
	{
		get
		{
			if (name != null)
			{
				return name;
			}
			return get_name(this);
		}
	}

	public override extern bool IsGenericMethodDefinition
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public override extern bool IsGenericMethod
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public override bool ContainsGenericParameters
	{
		get
		{
			if (IsGenericMethod)
			{
				Type[] genericArguments = GetGenericArguments();
				for (int i = 0; i < genericArguments.Length; i++)
				{
					if (genericArguments[i].ContainsGenericParameters)
					{
						return true;
					}
				}
			}
			return DeclaringType.ContainsGenericParameters;
		}
	}

	public override bool IsSecurityTransparent => get_core_clr_security_level() == 0;

	public override bool IsSecurityCritical => get_core_clr_security_level() > 0;

	public override bool IsSecuritySafeCritical => get_core_clr_security_level() == 1;

	internal override string FormatNameAndSig(bool serialization)
	{
		StringBuilder stringBuilder = new StringBuilder(Name);
		TypeNameFormatFlags format = (serialization ? TypeNameFormatFlags.FormatSerialization : TypeNameFormatFlags.FormatBasic);
		if (IsGenericMethod)
		{
			stringBuilder.Append(RuntimeMethodHandle.ConstructInstantiation(this, format));
		}
		stringBuilder.Append("(");
		RuntimeParameterInfo.FormatParameters(stringBuilder, GetParametersNoCopy(), CallingConvention, serialization);
		stringBuilder.Append(")");
		return stringBuilder.ToString();
	}

	public override Delegate CreateDelegate(Type delegateType)
	{
		return Delegate.CreateDelegate(delegateType, this);
	}

	public override Delegate CreateDelegate(Type delegateType, object target)
	{
		return Delegate.CreateDelegate(delegateType, target, this);
	}

	public override string ToString()
	{
		return ReturnType.FormatTypeName() + " " + FormatNameAndSig(serialization: false);
	}

	internal RuntimeModule GetRuntimeModule()
	{
		return ((RuntimeType)DeclaringType).GetRuntimeModule();
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		MemberInfoSerializationHolder.GetSerializationInfo(info, Name, ReflectedTypeInternal, ToString(), SerializationToString(), MemberTypes.Method, (IsGenericMethod & !IsGenericMethodDefinition) ? GetGenericArguments() : null);
	}

	internal string SerializationToString()
	{
		return ReturnType.FormatTypeName(serialization: true) + " " + FormatNameAndSig(serialization: true);
	}

	internal static MethodBase GetMethodFromHandleNoGenericCheck(RuntimeMethodHandle handle)
	{
		return GetMethodFromHandleInternalType_native(handle.Value, IntPtr.Zero, genericCheck: false);
	}

	internal static MethodBase GetMethodFromHandleNoGenericCheck(RuntimeMethodHandle handle, RuntimeTypeHandle reflectedType)
	{
		return GetMethodFromHandleInternalType_native(handle.Value, reflectedType.Value, genericCheck: false);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern MethodBody GetMethodBodyInternal(IntPtr handle);

	internal static MethodBody GetMethodBody(IntPtr handle)
	{
		return GetMethodBodyInternal(handle);
	}

	internal static MethodBase GetMethodFromHandleInternalType(IntPtr method_handle, IntPtr type_handle)
	{
		return GetMethodFromHandleInternalType_native(method_handle, type_handle, genericCheck: true);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern MethodBase GetMethodFromHandleInternalType_native(IntPtr method_handle, IntPtr type_handle, bool genericCheck);

	internal RuntimeMethodInfo()
	{
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern string get_name(MethodBase method);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern RuntimeMethodInfo get_base_method(RuntimeMethodInfo method, bool definition);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern int get_metadata_token(RuntimeMethodInfo method);

	public override MethodInfo GetBaseDefinition()
	{
		return get_base_method(this, definition: true);
	}

	internal MethodInfo GetBaseMethod()
	{
		return get_base_method(this, definition: false);
	}

	public override MethodImplAttributes GetMethodImplementationFlags()
	{
		return MonoMethodInfo.GetMethodImplementationFlags(mhandle);
	}

	public override ParameterInfo[] GetParameters()
	{
		ParameterInfo[] parametersInfo = MonoMethodInfo.GetParametersInfo(mhandle, this);
		if (parametersInfo.Length == 0)
		{
			return parametersInfo;
		}
		ParameterInfo[] array = new ParameterInfo[parametersInfo.Length];
		Array.FastCopy(parametersInfo, 0, array, 0, parametersInfo.Length);
		return array;
	}

	internal override ParameterInfo[] GetParametersInternal()
	{
		return MonoMethodInfo.GetParametersInfo(mhandle, this);
	}

	internal override int GetParametersCount()
	{
		return MonoMethodInfo.GetParametersInfo(mhandle, this).Length;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal extern object InternalInvoke(object obj, object[] parameters, out Exception exc);

	[DebuggerHidden]
	[DebuggerStepThrough]
	public override object Invoke(object obj, BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture)
	{
		if (!base.IsStatic && !DeclaringType.IsInstanceOfType(obj))
		{
			if (obj == null)
			{
				throw new TargetException("Non-static method requires a target.");
			}
			throw new TargetException("Object does not match target type.");
		}
		if (binder == null)
		{
			binder = Type.DefaultBinder;
		}
		ParameterInfo[] parametersInternal = GetParametersInternal();
		ConvertValues(binder, parameters, parametersInternal, culture, invokeAttr);
		if (ContainsGenericParameters)
		{
			throw new InvalidOperationException("Late bound operations cannot be performed on types or methods for which ContainsGenericParameters is true.");
		}
		object obj2 = null;
		Exception exc;
		if ((invokeAttr & BindingFlags.DoNotWrapExceptions) == 0)
		{
			try
			{
				obj2 = InternalInvoke(obj, parameters, out exc);
			}
			catch (ThreadAbortException)
			{
				throw;
			}
			catch (MethodAccessException)
			{
				throw;
			}
			catch (OverflowException)
			{
				throw;
			}
			catch (Exception inner)
			{
				throw new TargetInvocationException(inner);
			}
		}
		else
		{
			obj2 = InternalInvoke(obj, parameters, out exc);
		}
		if (exc != null)
		{
			throw exc;
		}
		return obj2;
	}

	internal static void ConvertValues(Binder binder, object[] args, ParameterInfo[] pinfo, CultureInfo culture, BindingFlags invokeAttr)
	{
		if (args == null)
		{
			if (pinfo.Length != 0)
			{
				throw new TargetParameterCountException();
			}
			return;
		}
		if (pinfo.Length != args.Length)
		{
			throw new TargetParameterCountException();
		}
		for (int i = 0; i < args.Length; i++)
		{
			object obj = args[i];
			ParameterInfo parameterInfo = pinfo[i];
			if (obj == Type.Missing)
			{
				if (parameterInfo.DefaultValue == DBNull.Value)
				{
					throw new ArgumentException(Environment.GetResourceString("Missing parameter does not have a default value."), "parameters");
				}
				args[i] = parameterInfo.DefaultValue;
			}
			else
			{
				RuntimeType runtimeType = (RuntimeType)parameterInfo.ParameterType;
				args[i] = runtimeType.CheckValue(obj, binder, culture, invokeAttr);
			}
		}
	}

	public override bool IsDefined(Type attributeType, bool inherit)
	{
		return MonoCustomAttrs.IsDefined(this, attributeType, inherit);
	}

	public override object[] GetCustomAttributes(bool inherit)
	{
		return MonoCustomAttrs.GetCustomAttributes(this, inherit);
	}

	public override object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		return MonoCustomAttrs.GetCustomAttributes(this, attributeType, inherit);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal extern void GetPInvoke(out PInvokeAttributes flags, out string entryPoint, out string dllName);

	internal object[] GetPseudoCustomAttributes()
	{
		int num = 0;
		MonoMethodInfo methodInfo = MonoMethodInfo.GetMethodInfo(mhandle);
		if ((methodInfo.iattrs & MethodImplAttributes.PreserveSig) != MethodImplAttributes.IL)
		{
			num++;
		}
		if ((methodInfo.attrs & MethodAttributes.PinvokeImpl) != MethodAttributes.PrivateScope)
		{
			num++;
		}
		if (num == 0)
		{
			return null;
		}
		object[] array = new object[num];
		num = 0;
		if ((methodInfo.iattrs & MethodImplAttributes.PreserveSig) != MethodImplAttributes.IL)
		{
			array[num++] = new PreserveSigAttribute();
		}
		if ((methodInfo.attrs & MethodAttributes.PinvokeImpl) != MethodAttributes.PrivateScope)
		{
			array[num++] = DllImportAttribute.GetCustomAttribute(this);
		}
		return array;
	}

	internal CustomAttributeData[] GetPseudoCustomAttributesData()
	{
		int num = 0;
		MonoMethodInfo methodInfo = MonoMethodInfo.GetMethodInfo(mhandle);
		if ((methodInfo.iattrs & MethodImplAttributes.PreserveSig) != MethodImplAttributes.IL)
		{
			num++;
		}
		if ((methodInfo.attrs & MethodAttributes.PinvokeImpl) != MethodAttributes.PrivateScope)
		{
			num++;
		}
		if (num == 0)
		{
			return null;
		}
		CustomAttributeData[] array = new CustomAttributeData[num];
		num = 0;
		if ((methodInfo.iattrs & MethodImplAttributes.PreserveSig) != MethodImplAttributes.IL)
		{
			array[num++] = new CustomAttributeData(typeof(PreserveSigAttribute).GetConstructor(Type.EmptyTypes));
		}
		if ((methodInfo.attrs & MethodAttributes.PinvokeImpl) != MethodAttributes.PrivateScope)
		{
			array[num++] = GetDllImportAttributeData();
		}
		return array;
	}

	private CustomAttributeData GetDllImportAttributeData()
	{
		if ((Attributes & MethodAttributes.PinvokeImpl) == 0)
		{
			return null;
		}
		string dllName = null;
		PInvokeAttributes flags = PInvokeAttributes.CharSetNotSpec;
		GetPInvoke(out flags, out var entryPoint, out dllName);
		CharSet charSet = (flags & PInvokeAttributes.CharSetMask) switch
		{
			PInvokeAttributes.CharSetNotSpec => CharSet.None, 
			PInvokeAttributes.CharSetAnsi => CharSet.Ansi, 
			PInvokeAttributes.CharSetUnicode => CharSet.Unicode, 
			PInvokeAttributes.CharSetMask => CharSet.Auto, 
			_ => CharSet.None, 
		};
		CallingConvention callingConvention = (flags & PInvokeAttributes.CallConvMask) switch
		{
			PInvokeAttributes.CallConvWinapi => System.Runtime.InteropServices.CallingConvention.Winapi, 
			PInvokeAttributes.CallConvCdecl => System.Runtime.InteropServices.CallingConvention.Cdecl, 
			PInvokeAttributes.CallConvStdcall => System.Runtime.InteropServices.CallingConvention.StdCall, 
			PInvokeAttributes.CallConvThiscall => System.Runtime.InteropServices.CallingConvention.ThisCall, 
			PInvokeAttributes.CallConvFastcall => System.Runtime.InteropServices.CallingConvention.FastCall, 
			_ => System.Runtime.InteropServices.CallingConvention.Cdecl, 
		};
		bool flag = (flags & PInvokeAttributes.NoMangle) != 0;
		bool flag2 = (flags & PInvokeAttributes.SupportsLastError) != 0;
		bool flag3 = (flags & PInvokeAttributes.BestFitMask) == PInvokeAttributes.BestFitEnabled;
		bool flag4 = (flags & PInvokeAttributes.ThrowOnUnmappableCharMask) == PInvokeAttributes.ThrowOnUnmappableCharEnabled;
		bool flag5 = (GetMethodImplementationFlags() & MethodImplAttributes.PreserveSig) != 0;
		CustomAttributeTypedArgument[] ctorArgs = new CustomAttributeTypedArgument[1]
		{
			new CustomAttributeTypedArgument(typeof(string), dllName)
		};
		Type typeFromHandle = typeof(DllImportAttribute);
		CustomAttributeNamedArgument[] namedArgs = new CustomAttributeNamedArgument[8]
		{
			new CustomAttributeNamedArgument(typeFromHandle.GetField("EntryPoint"), entryPoint),
			new CustomAttributeNamedArgument(typeFromHandle.GetField("CharSet"), charSet),
			new CustomAttributeNamedArgument(typeFromHandle.GetField("ExactSpelling"), flag),
			new CustomAttributeNamedArgument(typeFromHandle.GetField("SetLastError"), flag2),
			new CustomAttributeNamedArgument(typeFromHandle.GetField("PreserveSig"), flag5),
			new CustomAttributeNamedArgument(typeFromHandle.GetField("CallingConvention"), callingConvention),
			new CustomAttributeNamedArgument(typeFromHandle.GetField("BestFitMapping"), flag3),
			new CustomAttributeNamedArgument(typeFromHandle.GetField("ThrowOnUnmappableChar"), flag4)
		};
		return new CustomAttributeData(typeFromHandle.GetConstructor(new Type[1] { typeof(string) }), ctorArgs, namedArgs);
	}

	public override MethodInfo MakeGenericMethod(params Type[] methodInstantiation)
	{
		if (methodInstantiation == null)
		{
			throw new ArgumentNullException("methodInstantiation");
		}
		if (!IsGenericMethodDefinition)
		{
			throw new InvalidOperationException("not a generic method definition");
		}
		if (GetGenericArguments().Length != methodInstantiation.Length)
		{
			throw new ArgumentException("Incorrect length");
		}
		bool flag = false;
		foreach (Type obj in methodInstantiation)
		{
			if (obj == null)
			{
				throw new ArgumentNullException();
			}
			if (!(obj is RuntimeType))
			{
				flag = true;
			}
		}
		if (flag)
		{
			throw new NotSupportedException("User types are not supported under full aot");
		}
		MethodInfo methodInfo = MakeGenericMethod_impl(methodInstantiation);
		if (methodInfo == null)
		{
			throw new ArgumentException($"The method has {GetGenericArguments().Length} generic parameter(s) but {methodInstantiation.Length} generic argument(s) were provided.");
		}
		return methodInfo;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern MethodInfo MakeGenericMethod_impl(Type[] types);

	[MethodImpl((MethodImplOptions)4096)]
	public override extern Type[] GetGenericArguments();

	[MethodImpl((MethodImplOptions)4096)]
	private extern MethodInfo GetGenericMethodDefinition_impl();

	public override MethodInfo GetGenericMethodDefinition()
	{
		MethodInfo genericMethodDefinition_impl = GetGenericMethodDefinition_impl();
		if (genericMethodDefinition_impl == null)
		{
			throw new InvalidOperationException();
		}
		return genericMethodDefinition_impl;
	}

	public override MethodBody GetMethodBody()
	{
		return GetMethodBody(mhandle);
	}

	public override IList<CustomAttributeData> GetCustomAttributesData()
	{
		return CustomAttributeData.GetCustomAttributes(this);
	}

	private static int get_core_clr_security_level()
	{
		return 1;
	}

	public sealed override bool HasSameMetadataDefinitionAs(MemberInfo other)
	{
		return HasSameMetadataDefinitionAsCore<RuntimeMethodInfo>(other);
	}
}
