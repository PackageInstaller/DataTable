using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Reflection;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
internal class RuntimeConstructorInfo : ConstructorInfo, ISerializable
{
	internal IntPtr mhandle;

	private string name;

	private Type reftype;

	public override Module Module => GetRuntimeModule();

	internal BindingFlags BindingFlags => BindingFlags.Default;

	private RuntimeType ReflectedTypeInternal => (RuntimeType)ReflectedType;

	public override RuntimeMethodHandle MethodHandle => new RuntimeMethodHandle(mhandle);

	public override MethodAttributes Attributes => MonoMethodInfo.GetAttributes(mhandle);

	public override CallingConventions CallingConvention => MonoMethodInfo.GetCallingConvention(mhandle);

	public override bool ContainsGenericParameters => DeclaringType.ContainsGenericParameters;

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
			return RuntimeMethodInfo.get_name(this);
		}
	}

	public override bool IsSecurityTransparent => get_core_clr_security_level() == 0;

	public override bool IsSecurityCritical => get_core_clr_security_level() > 0;

	public override bool IsSecuritySafeCritical => get_core_clr_security_level() == 1;

	public override int MetadataToken => get_metadata_token(this);

	internal RuntimeModule GetRuntimeModule()
	{
		return RuntimeTypeHandle.GetModule((RuntimeType)DeclaringType);
	}

	public void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		MemberInfoSerializationHolder.GetSerializationInfo(info, Name, ReflectedTypeInternal, ToString(), SerializationToString(), MemberTypes.Constructor, null);
	}

	internal string SerializationToString()
	{
		return FormatNameAndSig(serialization: true);
	}

	internal void SerializationInvoke(object target, SerializationInfo info, StreamingContext context)
	{
		Invoke(target, new object[2] { info, context });
	}

	public override MethodImplAttributes GetMethodImplementationFlags()
	{
		return MonoMethodInfo.GetMethodImplementationFlags(mhandle);
	}

	public override ParameterInfo[] GetParameters()
	{
		return MonoMethodInfo.GetParametersInfo(mhandle, this);
	}

	internal override ParameterInfo[] GetParametersInternal()
	{
		return MonoMethodInfo.GetParametersInfo(mhandle, this);
	}

	internal override int GetParametersCount()
	{
		ParameterInfo[] parametersInfo = MonoMethodInfo.GetParametersInfo(mhandle, this);
		if (parametersInfo != null)
		{
			return parametersInfo.Length;
		}
		return 0;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal extern object InternalInvoke(object obj, object[] parameters, out Exception exc);

	[DebuggerHidden]
	[DebuggerStepThrough]
	public override object Invoke(object obj, BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture)
	{
		if (obj == null)
		{
			if (!base.IsStatic)
			{
				throw new TargetException("Instance constructor requires a target");
			}
		}
		else if (!DeclaringType.IsInstanceOfType(obj))
		{
			throw new TargetException("Constructor does not match target type");
		}
		return DoInvoke(obj, invokeAttr, binder, parameters, culture);
	}

	private object DoInvoke(object obj, BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture)
	{
		if (binder == null)
		{
			binder = Type.DefaultBinder;
		}
		ParameterInfo[] parametersInfo = MonoMethodInfo.GetParametersInfo(mhandle, this);
		RuntimeMethodInfo.ConvertValues(binder, parameters, parametersInfo, culture, invokeAttr);
		if (obj == null && DeclaringType.ContainsGenericParameters)
		{
			throw new MemberAccessException("Cannot create an instance of " + DeclaringType?.ToString() + " because Type.ContainsGenericParameters is true.");
		}
		if ((invokeAttr & BindingFlags.CreateInstance) != BindingFlags.Default && DeclaringType.IsAbstract)
		{
			throw new MemberAccessException($"Cannot create an instance of {DeclaringType} because it is an abstract class");
		}
		return InternalInvoke(obj, parameters, (invokeAttr & BindingFlags.DoNotWrapExceptions) == 0);
	}

	public object InternalInvoke(object obj, object[] parameters, bool wrapExceptions)
	{
		object obj2 = null;
		Exception exc;
		if (wrapExceptions)
		{
			try
			{
				obj2 = InternalInvoke(obj, parameters, out exc);
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
		if (obj != null)
		{
			return null;
		}
		return obj2;
	}

	[DebuggerStepThrough]
	[DebuggerHidden]
	public override object Invoke(BindingFlags invokeAttr, Binder binder, object[] parameters, CultureInfo culture)
	{
		return DoInvoke(null, invokeAttr, binder, parameters, culture);
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

	public override MethodBody GetMethodBody()
	{
		return RuntimeMethodInfo.GetMethodBody(mhandle);
	}

	public override string ToString()
	{
		return "Void " + FormatNameAndSig(serialization: false);
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
		return HasSameMetadataDefinitionAsCore<RuntimeConstructorInfo>(other);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern int get_metadata_token(RuntimeConstructorInfo method);
}
