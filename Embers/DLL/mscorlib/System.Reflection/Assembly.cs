using System.Collections.Generic;
using System.Configuration.Assemblies;
using System.Globalization;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Security;
using System.Security.Policy;
using System.Text;
using System.Threading;
using Mono;
using Unity;

namespace System.Reflection;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[ComDefaultInterface(typeof(_Assembly))]
[ComVisible(true)]
[ClassInterface(ClassInterfaceType.None)]
public class Assembly : ICustomAttributeProvider, ISerializable, _Assembly, IEvidenceFactory
{
	internal class ResolveEventHolder
	{
		public event ModuleResolveEventHandler ModuleResolve;
	}

	public virtual string CodeBase
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public virtual string EscapedCodeBase
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public virtual string FullName
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public virtual MethodInfo EntryPoint
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public virtual Evidence Evidence
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	internal virtual IntPtr MonoAssembly
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	internal virtual bool FromByteArray
	{
		set
		{
			throw new NotImplementedException();
		}
	}

	public virtual string Location
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	[ComVisible(false)]
	public virtual string ImageRuntimeVersion
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	[ComVisible(false)]
	[MonoTODO("Currently it always returns zero")]
	public virtual long HostContext => 0L;

	[ComVisible(false)]
	public virtual bool ReflectionOnly
	{
		get
		{
			throw new NotImplementedException();
		}
	}

	public virtual SecurityRuleSet SecurityRuleSet
	{
		get
		{
			throw CreateNIE();
		}
	}

	[MonoTODO]
	public bool IsFullyTrusted => true;

	public virtual Module ManifestModule
	{
		get
		{
			throw CreateNIE();
		}
	}

	public virtual bool GlobalAssemblyCache
	{
		get
		{
			throw CreateNIE();
		}
	}

	public virtual bool IsDynamic => false;

	public virtual IEnumerable<TypeInfo> DefinedTypes
	{
		get
		{
			Type[] types = GetTypes();
			foreach (Type type in types)
			{
				yield return type.GetTypeInfo();
			}
		}
	}

	public virtual IEnumerable<Type> ExportedTypes => GetExportedTypes();

	public virtual IEnumerable<Module> Modules => GetModules();

	public virtual IEnumerable<CustomAttributeData> CustomAttributes => GetCustomAttributesData();

	public virtual PermissionSet PermissionSet
	{
		get
		{
			ThrowStub.ThrowNotSupportedException();
			return null;
		}
	}

	public virtual event ModuleResolveEventHandler ModuleResolve
	{
		add
		{
			throw new NotImplementedException();
		}
		remove
		{
			throw new NotImplementedException();
		}
	}

	internal virtual Evidence UnprotectedGetEvidence()
	{
		throw new NotImplementedException();
	}

	public virtual void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		throw new NotImplementedException();
	}

	public virtual bool IsDefined(Type attributeType, bool inherit)
	{
		throw new NotImplementedException();
	}

	public virtual object[] GetCustomAttributes(bool inherit)
	{
		throw new NotImplementedException();
	}

	public virtual object[] GetCustomAttributes(Type attributeType, bool inherit)
	{
		throw new NotImplementedException();
	}

	public virtual FileStream[] GetFiles()
	{
		return GetFiles(getResourceModules: false);
	}

	public virtual FileStream[] GetFiles(bool getResourceModules)
	{
		throw new NotImplementedException();
	}

	public virtual FileStream GetFile(string name)
	{
		throw new NotImplementedException();
	}

	public virtual Stream GetManifestResourceStream(string name)
	{
		throw new NotImplementedException();
	}

	public virtual Stream GetManifestResourceStream(Type type, string name)
	{
		throw new NotImplementedException();
	}

	internal Stream GetManifestResourceStream(Type type, string name, bool skipSecurityCheck, ref StackCrawlMark stackMark)
	{
		StringBuilder stringBuilder = new StringBuilder();
		if (type == null)
		{
			if (name == null)
			{
				throw new ArgumentNullException("type");
			}
		}
		else
		{
			string text = type.Namespace;
			if (text != null)
			{
				stringBuilder.Append(text);
				if (name != null)
				{
					stringBuilder.Append(Type.Delimiter);
				}
			}
		}
		if (name != null)
		{
			stringBuilder.Append(name);
		}
		return GetManifestResourceStream(stringBuilder.ToString());
	}

	internal Stream GetManifestResourceStream(string name, ref StackCrawlMark stackMark, bool skipSecurityCheck)
	{
		return GetManifestResourceStream(null, name, skipSecurityCheck, ref stackMark);
	}

	internal string GetSimpleName()
	{
		return GetName(copiedName: true).Name;
	}

	internal byte[] GetPublicKey()
	{
		return GetName(copiedName: true).GetPublicKey();
	}

	internal Version GetVersion()
	{
		return GetName(copiedName: true).Version;
	}

	private AssemblyNameFlags GetFlags()
	{
		return GetName(copiedName: true).Flags;
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal virtual extern Type[] GetTypes(bool exportedOnly);

	public virtual Type[] GetTypes()
	{
		return GetTypes(exportedOnly: false);
	}

	public virtual Type[] GetExportedTypes()
	{
		throw new NotImplementedException();
	}

	public virtual Type GetType(string name, bool throwOnError)
	{
		return GetType(name, throwOnError, ignoreCase: false);
	}

	public virtual Type GetType(string name)
	{
		return GetType(name, throwOnError: false, ignoreCase: false);
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal extern Type InternalGetType(Module module, string name, bool throwOnError, bool ignoreCase);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern void InternalGetAssemblyName(string assemblyFile, out MonoAssemblyName aname, out string codebase);

	public virtual AssemblyName GetName(bool copiedName)
	{
		throw new NotImplementedException();
	}

	public virtual AssemblyName GetName()
	{
		return GetName(copiedName: false);
	}

	public override string ToString()
	{
		return base.ToString();
	}

	public static string CreateQualifiedName(string assemblyName, string typeName)
	{
		return typeName + ", " + assemblyName;
	}

	public static Assembly GetAssembly(Type type)
	{
		if (type != null)
		{
			return type.Assembly;
		}
		throw new ArgumentNullException("type");
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern Assembly GetEntryAssembly();

	internal Assembly GetSatelliteAssembly(CultureInfo culture, Version version, bool throwOnError, ref StackCrawlMark stackMark)
	{
		if (culture == null)
		{
			throw new ArgumentNullException("culture");
		}
		string name = GetSimpleName() + ".resources";
		return InternalGetSatelliteAssembly(name, culture, version, throwOnFileNotFound: true, ref stackMark);
	}

	internal RuntimeAssembly InternalGetSatelliteAssembly(string name, CultureInfo culture, Version version, bool throwOnFileNotFound, ref StackCrawlMark stackMark)
	{
		AssemblyName assemblyName = new AssemblyName();
		assemblyName.SetPublicKey(GetPublicKey());
		assemblyName.Flags = GetFlags() | AssemblyNameFlags.PublicKey;
		if (version == null)
		{
			assemblyName.Version = GetVersion();
		}
		else
		{
			assemblyName.Version = version;
		}
		assemblyName.CultureInfo = culture;
		assemblyName.Name = name;
		try
		{
			Assembly assembly = AppDomain.CurrentDomain.LoadSatellite(assemblyName, throwOnError: false, ref stackMark);
			if (assembly != null)
			{
				return (RuntimeAssembly)assembly;
			}
		}
		catch (FileNotFoundException)
		{
			Assembly assembly = null;
		}
		if (string.IsNullOrEmpty(Location))
		{
			return null;
		}
		string text = Path.Combine(Path.GetDirectoryName(Location), Path.Combine(culture.Name, assemblyName.Name + ".dll"));
		try
		{
			return (RuntimeAssembly)LoadFrom(text, refOnly: false, ref stackMark);
		}
		catch
		{
			if (!throwOnFileNotFound && !File.Exists(text))
			{
				return null;
			}
			throw;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Assembly LoadFrom(string assemblyFile, bool refOnly, ref StackCrawlMark stackMark);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Assembly LoadFile_internal(string assemblyFile, ref StackCrawlMark stackMark);

	[MethodImpl((MethodImplOptions)8)]
	public static Assembly LoadFrom(string assemblyFile)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return LoadFrom(assemblyFile, refOnly: false, ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	[Obsolete]
	public static Assembly LoadFrom(string assemblyFile, Evidence securityEvidence)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return LoadFrom(assemblyFile, refOnly: false, ref stackMark);
	}

	[MonoTODO("This overload is not currently implemented")]
	[Obsolete]
	public static Assembly LoadFrom(string assemblyFile, Evidence securityEvidence, byte[] hashValue, AssemblyHashAlgorithm hashAlgorithm)
	{
		throw new NotImplementedException();
	}

	[MonoTODO]
	public static Assembly LoadFrom(string assemblyFile, byte[] hashValue, AssemblyHashAlgorithm hashAlgorithm)
	{
		throw new NotImplementedException();
	}

	[MethodImpl((MethodImplOptions)8)]
	public static Assembly UnsafeLoadFrom(string assemblyFile)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return LoadFrom(assemblyFile, refOnly: false, ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	[Obsolete]
	public static Assembly LoadFile(string path, Evidence securityEvidence)
	{
		if (path == null)
		{
			throw new ArgumentNullException("path");
		}
		if (path == string.Empty)
		{
			throw new ArgumentException("Path can't be empty", "path");
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		Assembly assembly = LoadFile_internal(path, ref stackMark);
		if (assembly != null && securityEvidence != null)
		{
			throw new NotImplementedException();
		}
		return assembly;
	}

	public static Assembly LoadFile(string path)
	{
		return LoadFile(path, null);
	}

	public static Assembly Load(string assemblyString)
	{
		return AppDomain.CurrentDomain.Load(assemblyString);
	}

	[Obsolete]
	public static Assembly Load(string assemblyString, Evidence assemblySecurity)
	{
		return AppDomain.CurrentDomain.Load(assemblyString, assemblySecurity);
	}

	public static Assembly Load(AssemblyName assemblyRef)
	{
		return AppDomain.CurrentDomain.Load(assemblyRef);
	}

	[Obsolete]
	public static Assembly Load(AssemblyName assemblyRef, Evidence assemblySecurity)
	{
		return AppDomain.CurrentDomain.Load(assemblyRef, assemblySecurity);
	}

	public static Assembly Load(byte[] rawAssembly)
	{
		return AppDomain.CurrentDomain.Load(rawAssembly);
	}

	public static Assembly Load(byte[] rawAssembly, byte[] rawSymbolStore)
	{
		return AppDomain.CurrentDomain.Load(rawAssembly, rawSymbolStore);
	}

	[Obsolete]
	public static Assembly Load(byte[] rawAssembly, byte[] rawSymbolStore, Evidence securityEvidence)
	{
		return AppDomain.CurrentDomain.Load(rawAssembly, rawSymbolStore, securityEvidence);
	}

	[MonoLimitation("Argument securityContextSource is ignored")]
	public static Assembly Load(byte[] rawAssembly, byte[] rawSymbolStore, SecurityContextSource securityContextSource)
	{
		return AppDomain.CurrentDomain.Load(rawAssembly, rawSymbolStore);
	}

	public static Assembly ReflectionOnlyLoad(byte[] rawAssembly)
	{
		return AppDomain.CurrentDomain.Load(rawAssembly, null, null, refonly: true);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static Assembly ReflectionOnlyLoad(string assemblyString)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return AppDomain.CurrentDomain.Load(assemblyString, null, refonly: true, ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	public static Assembly ReflectionOnlyLoadFrom(string assemblyFile)
	{
		if (assemblyFile == null)
		{
			throw new ArgumentNullException("assemblyFile");
		}
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return LoadFrom(assemblyFile, refOnly: true, ref stackMark);
	}

	[Obsolete("This method has been deprecated. Please use Assembly.Load() instead. http://go.microsoft.com/fwlink/?linkid=14202")]
	public static Assembly LoadWithPartialName(string partialName)
	{
		return LoadWithPartialName(partialName, null);
	}

	[MonoTODO("Not implemented")]
	public Module LoadModule(string moduleName, byte[] rawModule)
	{
		throw new NotImplementedException();
	}

	[MonoTODO("Not implemented")]
	public virtual Module LoadModule(string moduleName, byte[] rawModule, byte[] rawSymbolStore)
	{
		throw new NotImplementedException();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern Assembly load_with_partial_name(string name, Evidence e);

	[Obsolete("This method has been deprecated. Please use Assembly.Load() instead. http://go.microsoft.com/fwlink/?linkid=14202")]
	public static Assembly LoadWithPartialName(string partialName, Evidence securityEvidence)
	{
		return LoadWithPartialName(partialName, securityEvidence, oldBehavior: true);
	}

	internal static Assembly LoadWithPartialName(string partialName, Evidence securityEvidence, bool oldBehavior)
	{
		if (!oldBehavior)
		{
			throw new NotImplementedException();
		}
		if (partialName == null)
		{
			throw new NullReferenceException();
		}
		return load_with_partial_name(partialName, securityEvidence);
	}

	public object CreateInstance(string typeName)
	{
		return CreateInstance(typeName, ignoreCase: false);
	}

	public object CreateInstance(string typeName, bool ignoreCase)
	{
		Type type = GetType(typeName, throwOnError: false, ignoreCase);
		if (type == null)
		{
			return null;
		}
		try
		{
			return Activator.CreateInstance(type);
		}
		catch (InvalidOperationException)
		{
			throw new ArgumentException("It is illegal to invoke a method on a Type loaded via ReflectionOnly methods.");
		}
	}

	public virtual object CreateInstance(string typeName, bool ignoreCase, BindingFlags bindingAttr, Binder binder, object[] args, CultureInfo culture, object[] activationAttributes)
	{
		Type type = GetType(typeName, throwOnError: false, ignoreCase);
		if (type == null)
		{
			return null;
		}
		try
		{
			return Activator.CreateInstance(type, bindingAttr, binder, args, culture, activationAttributes);
		}
		catch (InvalidOperationException)
		{
			throw new ArgumentException("It is illegal to invoke a method on a Type loaded via ReflectionOnly methods.");
		}
	}

	public Module[] GetLoadedModules()
	{
		return GetLoadedModules(getResourceModules: false);
	}

	public Module[] GetModules()
	{
		return GetModules(getResourceModules: false);
	}

	internal virtual Module[] GetModulesInternal()
	{
		throw new NotImplementedException();
	}

	[MethodImpl((MethodImplOptions)4096)]
	public static extern Assembly GetExecutingAssembly();

	[MethodImpl((MethodImplOptions)4096)]
	public static extern Assembly GetCallingAssembly();

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern IntPtr InternalGetReferencedAssemblies(Assembly module);

	public virtual string[] GetManifestResourceNames()
	{
		throw new NotImplementedException();
	}

	internal unsafe static AssemblyName[] GetReferencedAssemblies(Assembly module)
	{
		using SafeGPtrArrayHandle safeGPtrArrayHandle = new SafeGPtrArrayHandle(InternalGetReferencedAssemblies(module));
		int length = safeGPtrArrayHandle.Length;
		try
		{
			AssemblyName[] array = new AssemblyName[length];
			for (int i = 0; i < length; i++)
			{
				AssemblyName assemblyName = new AssemblyName();
				MonoAssemblyName* native = (MonoAssemblyName*)(void*)safeGPtrArrayHandle[i];
				assemblyName.FillName(native, null, addVersion: true, addPublickey: false, defaultToken: true, assemblyRef: true);
				array[i] = assemblyName;
			}
			return array;
		}
		finally
		{
			for (int j = 0; j < length; j++)
			{
				MonoAssemblyName* ptr = (MonoAssemblyName*)(void*)safeGPtrArrayHandle[j];
				RuntimeMarshal.FreeAssemblyName(ref *ptr, freeStruct: true);
			}
		}
	}

	public virtual ManifestResourceInfo GetManifestResourceInfo(string resourceName)
	{
		throw new NotImplementedException();
	}

	internal virtual Module GetManifestModule()
	{
		throw new NotImplementedException();
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public override bool Equals(object o)
	{
		return base.Equals(o);
	}

	private static Exception CreateNIE()
	{
		return new NotImplementedException("Derived classes must implement it");
	}

	public virtual IList<CustomAttributeData> GetCustomAttributesData()
	{
		throw new NotImplementedException();
	}

	public virtual Type GetType(string name, bool throwOnError, bool ignoreCase)
	{
		throw CreateNIE();
	}

	public virtual Module GetModule(string name)
	{
		throw CreateNIE();
	}

	public virtual AssemblyName[] GetReferencedAssemblies()
	{
		throw CreateNIE();
	}

	public virtual Module[] GetModules(bool getResourceModules)
	{
		throw CreateNIE();
	}

	[MonoTODO("Always returns the same as GetModules")]
	public virtual Module[] GetLoadedModules(bool getResourceModules)
	{
		throw CreateNIE();
	}

	public virtual Assembly GetSatelliteAssembly(CultureInfo culture)
	{
		throw CreateNIE();
	}

	public virtual Assembly GetSatelliteAssembly(CultureInfo culture, Version version)
	{
		throw CreateNIE();
	}

	public static bool operator ==(Assembly left, Assembly right)
	{
		if ((object)left == right)
		{
			return true;
		}
		if (((object)left == null) ^ ((object)right == null))
		{
			return false;
		}
		return left.Equals(right);
	}

	public static bool operator !=(Assembly left, Assembly right)
	{
		if ((object)left == right)
		{
			return false;
		}
		if (((object)left == null) ^ ((object)right == null))
		{
			return true;
		}
		return !left.Equals(right);
	}

	public virtual Type[] GetForwardedTypes()
	{
		throw new PlatformNotSupportedException();
	}

	Type _Assembly.GetType()
	{
		ThrowStub.ThrowNotSupportedException();
		return null;
	}
}
