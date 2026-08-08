using System.Configuration.Assemblies;
using System.Diagnostics;
using System.Globalization;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Remoting;
using System.Security.Policy;
using System.Threading;

namespace System;

[ClassInterface(ClassInterfaceType.None)]
[ComVisible(true)]
[ComDefaultInterface(typeof(_Activator))]
public sealed class Activator : _Activator
{
	internal const int LookupMask = 255;

	internal const BindingFlags ConLookup = BindingFlags.Instance | BindingFlags.Public;

	internal const BindingFlags ConstructorDefault = BindingFlags.Instance | BindingFlags.Public | BindingFlags.CreateInstance;

	private Activator()
	{
	}

	public static object CreateInstance(Type type, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture)
	{
		return CreateInstance(type, bindingAttr, binder, args, culture, null);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static object CreateInstance(Type type, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes)
	{
		if ((object)type == null)
		{
			throw new ArgumentNullException("type");
		}
		if ((bindingAttr & (BindingFlags)0xFF) == 0)
		{
			bindingAttr |= BindingFlags.Instance | BindingFlags.Public | BindingFlags.CreateInstance;
		}
		if (activationAttributes != null && activationAttributes.Length != 0)
		{
			throw new NotSupportedException(Environment.GetResourceString("Activation Attributes are not supported for types not deriving from MarshalByRefObject."));
		}
		RuntimeType obj = type.UnderlyingSystemType as RuntimeType;
		if (obj == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "type");
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return obj.CreateInstanceImpl(bindingAttr, binder, args, culture, activationAttributes, ref stackMark);
	}

	public static object CreateInstance(Type type, params object[] args)
	{
		return CreateInstance(type, BindingFlags.Instance | BindingFlags.Public | BindingFlags.CreateInstance, null, args, null, null);
	}

	public static object CreateInstance(Type type, object[] args, object[] activationAttributes)
	{
		return CreateInstance(type, BindingFlags.Instance | BindingFlags.Public | BindingFlags.CreateInstance, null, args, null, activationAttributes);
	}

	public static object CreateInstance(Type type)
	{
		return CreateInstance(type, nonPublic: false);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static ObjectHandle CreateInstance(string assemblyName, string typeName)
	{
		if (assemblyName == null)
		{
			assemblyName = Assembly.GetCallingAssembly().GetName().Name;
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return CreateInstance(assemblyName, typeName, ignoreCase: false, BindingFlags.Instance | BindingFlags.Public | BindingFlags.CreateInstance, null, null, null, null, null, ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static ObjectHandle CreateInstance(string assemblyName, string typeName, object[] activationAttributes)
	{
		if (assemblyName == null)
		{
			assemblyName = Assembly.GetCallingAssembly().GetName().Name;
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return CreateInstance(assemblyName, typeName, ignoreCase: false, BindingFlags.Instance | BindingFlags.Public | BindingFlags.CreateInstance, null, null, null, activationAttributes, null, ref stackMark);
	}

	public static object CreateInstance(Type type, bool nonPublic)
	{
		return CreateInstance(type, nonPublic, wrapExceptions: true);
	}

	[MethodImpl((MethodImplOptions)8)]
	internal static object CreateInstance(Type type, bool nonPublic, bool wrapExceptions)
	{
		if ((object)type == null)
		{
			throw new ArgumentNullException("type");
		}
		RuntimeType obj = type.UnderlyingSystemType as RuntimeType;
		if (obj == null)
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a type provided by the runtime."), "type");
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return obj.CreateInstanceDefaultCtor(!nonPublic, skipCheckThis: false, fillCache: true, wrapExceptions, ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static T CreateInstance<T>()
	{
		RuntimeType obj = typeof(T) as RuntimeType;
		if (obj.HasElementType)
		{
			throw new MissingMethodException(Environment.GetResourceString("No parameterless constructor defined for this object."));
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return (T)obj.CreateInstanceDefaultCtor(publicOnly: true, skipCheckThis: true, fillCache: true, wrapExceptions: true, ref stackMark);
	}

	public static ObjectHandle CreateInstanceFrom(string assemblyFile, string typeName)
	{
		return CreateInstanceFrom(assemblyFile, typeName, null);
	}

	public static ObjectHandle CreateInstanceFrom(string assemblyFile, string typeName, object[] activationAttributes)
	{
		return CreateInstanceFrom(assemblyFile, typeName, ignoreCase: false, BindingFlags.Instance | BindingFlags.Public | BindingFlags.CreateInstance, null, null, null, activationAttributes);
	}

	[MethodImpl((MethodImplOptions)8)]
	[Obsolete("Methods which use evidence to sandbox are obsolete and will be removed in a future release of the .NET Framework. Please use an overload of CreateInstance which does not take an Evidence parameter. See http://go.microsoft.com/fwlink/?LinkID=155570 for more information.")]
	public static ObjectHandle CreateInstance(string assemblyName, string typeName, bool ignoreCase, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes, Evidence securityInfo)
	{
		if (assemblyName == null)
		{
			assemblyName = Assembly.GetCallingAssembly().GetName().Name;
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return CreateInstance(assemblyName, typeName, ignoreCase, bindingAttr, binder, args, culture, activationAttributes, securityInfo, ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static ObjectHandle CreateInstance(string assemblyName, string typeName, bool ignoreCase, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes)
	{
		if (assemblyName == null)
		{
			assemblyName = Assembly.GetCallingAssembly().GetName().Name;
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return CreateInstance(assemblyName, typeName, ignoreCase, bindingAttr, binder, args, culture, activationAttributes, null, ref stackMark);
	}

	internal static ObjectHandle CreateInstance(string assemblyString, string typeName, bool ignoreCase, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes, Evidence securityInfo, ref StackCrawlMark stackMark)
	{
		Type type = null;
		Assembly assembly = null;
		if (assemblyString == null)
		{
			assembly = RuntimeAssembly.GetExecutingAssembly(ref stackMark);
		}
		else
		{
			AssemblyName assemblyName = RuntimeAssembly.CreateAssemblyName(assemblyString, forIntrospection: false, out var assemblyFromResolveEvent);
			if (assemblyFromResolveEvent != null)
			{
				assembly = assemblyFromResolveEvent;
			}
			else if (assemblyName.ContentType == AssemblyContentType.WindowsRuntime)
			{
				type = Type.GetType(typeName + ", " + assemblyString, throwOnError: true, ignoreCase);
			}
			else
			{
				assembly = RuntimeAssembly.InternalLoadAssemblyName(assemblyName, securityInfo, null, ref stackMark, throwOnFileNotFound: true, forIntrospection: false, suppressSecurityChecks: false);
			}
		}
		if (type == null)
		{
			if (assembly == null)
			{
				return null;
			}
			type = assembly.GetType(typeName, throwOnError: true, ignoreCase);
		}
		object obj = CreateInstance(type, bindingAttr, binder, args, culture, activationAttributes);
		if (obj == null)
		{
			return null;
		}
		return new ObjectHandle(obj);
	}

	[Obsolete("Methods which use evidence to sandbox are obsolete and will be removed in a future release of the .NET Framework. Please use an overload of CreateInstanceFrom which does not take an Evidence parameter. See http://go.microsoft.com/fwlink/?LinkID=155570 for more information.")]
	public static ObjectHandle CreateInstanceFrom(string assemblyFile, string typeName, bool ignoreCase, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes, Evidence securityInfo)
	{
		return CreateInstanceFromInternal(assemblyFile, typeName, ignoreCase, bindingAttr, binder, args, culture, activationAttributes, securityInfo);
	}

	public static ObjectHandle CreateInstanceFrom(string assemblyFile, string typeName, bool ignoreCase, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes)
	{
		return CreateInstanceFromInternal(assemblyFile, typeName, ignoreCase, bindingAttr, binder, args, culture, activationAttributes, null);
	}

	private static ObjectHandle CreateInstanceFromInternal(string assemblyFile, string typeName, bool ignoreCase, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes, Evidence securityInfo)
	{
		object obj = CreateInstance(Assembly.LoadFrom(assemblyFile, securityInfo).GetType(typeName, throwOnError: true, ignoreCase), bindingAttr, binder, args, culture, activationAttributes);
		if (obj == null)
		{
			return null;
		}
		return new ObjectHandle(obj);
	}

	public static ObjectHandle CreateInstance(AppDomain domain, string assemblyName, string typeName)
	{
		if (domain == null)
		{
			throw new ArgumentNullException("domain");
		}
		return domain.InternalCreateInstanceWithNoSecurity(assemblyName, typeName);
	}

	[Obsolete("Methods which use evidence to sandbox are obsolete and will be removed in a future release of the .NET Framework. Please use an overload of CreateInstance which does not take an Evidence parameter. See http://go.microsoft.com/fwlink/?LinkID=155570 for more information.")]
	public static ObjectHandle CreateInstance(AppDomain domain, string assemblyName, string typeName, bool ignoreCase, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes, Evidence securityAttributes)
	{
		if (domain == null)
		{
			throw new ArgumentNullException("domain");
		}
		return domain.InternalCreateInstanceWithNoSecurity(assemblyName, typeName, ignoreCase, bindingAttr, binder, args, culture, activationAttributes, securityAttributes);
	}

	public static ObjectHandle CreateInstance(AppDomain domain, string assemblyName, string typeName, bool ignoreCase, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes)
	{
		if (domain == null)
		{
			throw new ArgumentNullException("domain");
		}
		return domain.InternalCreateInstanceWithNoSecurity(assemblyName, typeName, ignoreCase, bindingAttr, binder, args, culture, activationAttributes, null);
	}

	public static ObjectHandle CreateInstanceFrom(AppDomain domain, string assemblyFile, string typeName)
	{
		if (domain == null)
		{
			throw new ArgumentNullException("domain");
		}
		return domain.InternalCreateInstanceFromWithNoSecurity(assemblyFile, typeName);
	}

	[Obsolete("Methods which use Evidence to sandbox are obsolete and will be removed in a future release of the .NET Framework. Please use an overload of CreateInstanceFrom which does not take an Evidence parameter. See http://go.microsoft.com/fwlink/?LinkID=155570 for more information.")]
	public static ObjectHandle CreateInstanceFrom(AppDomain domain, string assemblyFile, string typeName, bool ignoreCase, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes, Evidence securityAttributes)
	{
		if (domain == null)
		{
			throw new ArgumentNullException("domain");
		}
		return domain.InternalCreateInstanceFromWithNoSecurity(assemblyFile, typeName, ignoreCase, bindingAttr, binder, args, culture, activationAttributes, securityAttributes);
	}

	public static ObjectHandle CreateInstanceFrom(AppDomain domain, string assemblyFile, string typeName, bool ignoreCase, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes)
	{
		if (domain == null)
		{
			throw new ArgumentNullException("domain");
		}
		return domain.InternalCreateInstanceFromWithNoSecurity(assemblyFile, typeName, ignoreCase, bindingAttr, binder, args, culture, activationAttributes, null);
	}

	public static ObjectHandle CreateInstance(ActivationContext activationContext)
	{
		AppDomainManager appDomainManager = AppDomain.CurrentDomain.DomainManager;
		if (appDomainManager == null)
		{
			appDomainManager = new AppDomainManager();
		}
		return appDomainManager.ApplicationActivator.CreateInstance(activationContext);
	}

	public static ObjectHandle CreateInstance(ActivationContext activationContext, string[] activationCustomData)
	{
		AppDomainManager appDomainManager = AppDomain.CurrentDomain.DomainManager;
		if (appDomainManager == null)
		{
			appDomainManager = new AppDomainManager();
		}
		return appDomainManager.ApplicationActivator.CreateInstance(activationContext, activationCustomData);
	}

	public static ObjectHandle CreateComInstanceFrom(string assemblyName, string typeName)
	{
		return CreateComInstanceFrom(assemblyName, typeName, null, AssemblyHashAlgorithm.None);
	}

	public static ObjectHandle CreateComInstanceFrom(string assemblyName, string typeName, byte[] hashValue, AssemblyHashAlgorithm hashAlgorithm)
	{
		Assembly assembly = Assembly.LoadFrom(assemblyName, hashValue, hashAlgorithm);
		Type type = assembly.GetType(typeName, throwOnError: true, ignoreCase: false);
		object[] customAttributes = type.GetCustomAttributes(typeof(ComVisibleAttribute), inherit: false);
		if (customAttributes.Length != 0 && !((ComVisibleAttribute)customAttributes[0]).Value)
		{
			throw new TypeLoadException(Environment.GetResourceString("The specified type must be visible from COM."));
		}
		if (assembly == null)
		{
			return null;
		}
		object obj = CreateInstance(type, BindingFlags.Instance | BindingFlags.Public | BindingFlags.CreateInstance, null, null, null, null);
		if (obj == null)
		{
			return null;
		}
		return new ObjectHandle(obj);
	}

	public static object GetObject(Type type, string url)
	{
		return GetObject(type, url, null);
	}

	public static object GetObject(Type type, string url, object state)
	{
		if (type == null)
		{
			throw new ArgumentNullException("type");
		}
		return RemotingServices.Connect(type, url, state);
	}

	[Conditional("_DEBUG")]
	private static void Log(bool test, string title, string success, string failure)
	{
	}

	void _Activator.GetTypeInfoCount(out uint pcTInfo)
	{
		throw new NotImplementedException();
	}

	void _Activator.GetTypeInfo(uint iTInfo, uint lcid, IntPtr ppTInfo)
	{
		throw new NotImplementedException();
	}

	void _Activator.GetIDsOfNames([In] ref Guid riid, IntPtr rgszNames, uint cNames, uint lcid, IntPtr rgDispId)
	{
		throw new NotImplementedException();
	}

	void _Activator.Invoke(uint dispIdMember, [In] ref Guid riid, uint lcid, short wFlags, IntPtr pDispParams, IntPtr pVarResult, IntPtr pExcepInfo, IntPtr puArgErr)
	{
		throw new NotImplementedException();
	}
}
