using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Security.Policy;
using System.Threading;

namespace System.Reflection;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[ComDefaultInterface(typeof(_Assembly))]
[ClassInterface(ClassInterfaceType.None)]
[ComVisible(true)]
internal class RuntimeAssembly : Assembly
{
	internal class UnmanagedMemoryStreamForModule : UnmanagedMemoryStream
	{
		private Module module;

		public unsafe UnmanagedMemoryStreamForModule(byte* pointer, long length, Module module)
			: base(pointer, length)
		{
			this.module = module;
		}

		protected override void Dispose(bool disposing)
		{
			if (_isOpen)
			{
				module = null;
			}
			base.Dispose(disposing);
		}
	}

	internal IntPtr _mono_assembly;

	private object _evidence;

	internal ResolveEventHolder resolve_event_holder;

	private object _minimum;

	private object _optional;

	private object _refuse;

	private object _granted;

	private object _denied;

	internal bool fromByteArray;

	internal string assemblyName;

	[ComVisible(false)]
	public override Module ManifestModule => GetManifestModule();

	public override bool GlobalAssemblyCache => get_global_assembly_cache();

	public override extern MethodInfo EntryPoint
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	[ComVisible(false)]
	public override extern bool ReflectionOnly
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public override string CodeBase => GetCodeBase(this, escaped: false);

	public override string EscapedCodeBase => GetCodeBase(this, escaped: true);

	public override string FullName => get_fullname(this);

	[ComVisible(false)]
	public override string ImageRuntimeVersion => InternalImageRuntimeVersion(this);

	internal override IntPtr MonoAssembly => _mono_assembly;

	internal override bool FromByteArray
	{
		set
		{
			fromByteArray = value;
		}
	}

	public override string Location
	{
		get
		{
			if (fromByteArray)
			{
				return string.Empty;
			}
			return get_location();
		}
	}

	public override Evidence Evidence => UnprotectedGetEvidence();

	public override event ModuleResolveEventHandler ModuleResolve
	{
		add
		{
			resolve_event_holder.ModuleResolve += value;
		}
		remove
		{
			resolve_event_holder.ModuleResolve -= value;
		}
	}

	protected RuntimeAssembly()
	{
		resolve_event_holder = new ResolveEventHolder();
	}

	public override void GetObjectData(SerializationInfo info, StreamingContext context)
	{
		if (info == null)
		{
			throw new ArgumentNullException("info");
		}
		UnitySerializationHolder.GetUnitySerializationInfo(info, 6, FullName, this);
	}

	internal static RuntimeAssembly GetExecutingAssembly(ref StackCrawlMark stackMark)
	{
		throw new NotSupportedException();
	}

	internal static AssemblyName CreateAssemblyName(string assemblyString, bool forIntrospection, out RuntimeAssembly assemblyFromResolveEvent)
	{
		if (assemblyString == null)
		{
			throw new ArgumentNullException("assemblyString");
		}
		if (assemblyString.Length == 0 || assemblyString[0] == '\0')
		{
			throw new ArgumentException(Environment.GetResourceString("String cannot have zero length."));
		}
		if (forIntrospection)
		{
			AppDomain.CheckReflectionOnlyLoadSupported();
		}
		AssemblyName result = new AssemblyName
		{
			Name = assemblyString
		};
		assemblyFromResolveEvent = null;
		return result;
	}

	internal static RuntimeAssembly InternalLoadAssemblyName(AssemblyName assemblyRef, Evidence assemblySecurity, RuntimeAssembly reqAssembly, ref StackCrawlMark stackMark, bool throwOnFileNotFound, bool forIntrospection, bool suppressSecurityChecks)
	{
		if (assemblyRef == null)
		{
			throw new ArgumentNullException("assemblyRef");
		}
		if (assemblyRef.CodeBase != null)
		{
			AppDomain.CheckLoadFromSupported();
		}
		assemblyRef = (AssemblyName)assemblyRef.Clone();
		if (assemblySecurity != null)
		{
		}
		return (RuntimeAssembly)Assembly.Load(assemblyRef);
	}

	internal static RuntimeAssembly LoadWithPartialNameInternal(string partialName, Evidence securityEvidence, ref StackCrawlMark stackMark)
	{
		return (RuntimeAssembly)Assembly.LoadWithPartialName(partialName, securityEvidence);
	}

	internal static RuntimeAssembly LoadWithPartialNameInternal(AssemblyName an, Evidence securityEvidence, ref StackCrawlMark stackMark)
	{
		return LoadWithPartialNameInternal(an.ToString(), securityEvidence, ref stackMark);
	}

	public override AssemblyName GetName(bool copiedName)
	{
		return AssemblyName.Create(this, fillCodebase: true);
	}

	public override Type GetType(string name, bool throwOnError, bool ignoreCase)
	{
		if (name == null)
		{
			throw new ArgumentNullException(name);
		}
		if (name.Length == 0)
		{
			throw new ArgumentException("name", "Name cannot be empty");
		}
		return InternalGetType(null, name, throwOnError, ignoreCase);
	}

	public override Module GetModule(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		if (name.Length == 0)
		{
			throw new ArgumentException("Name can't be empty");
		}
		Module[] modules = GetModules(getResourceModules: true);
		foreach (Module module in modules)
		{
			if (module.ScopeName == name)
			{
				return module;
			}
		}
		return null;
	}

	public override AssemblyName[] GetReferencedAssemblies()
	{
		return Assembly.GetReferencedAssemblies(this);
	}

	public override Module[] GetModules(bool getResourceModules)
	{
		Module[] modulesInternal = GetModulesInternal();
		if (!getResourceModules)
		{
			List<Module> list = new List<Module>(modulesInternal.Length);
			Module[] array = modulesInternal;
			foreach (Module module in array)
			{
				if (!module.IsResource())
				{
					list.Add(module);
				}
			}
			return list.ToArray();
		}
		return modulesInternal;
	}

	[MonoTODO("Always returns the same as GetModules")]
	public override Module[] GetLoadedModules(bool getResourceModules)
	{
		return GetModules(getResourceModules);
	}

	[MethodImpl((MethodImplOptions)8)]
	public override Assembly GetSatelliteAssembly(CultureInfo culture)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return GetSatelliteAssembly(culture, null, throwOnError: true, ref stackMark);
	}

	[MethodImpl((MethodImplOptions)8)]
	public override Assembly GetSatelliteAssembly(CultureInfo culture, Version version)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return GetSatelliteAssembly(culture, version, throwOnError: true, ref stackMark);
	}

	public override Type[] GetExportedTypes()
	{
		return GetTypes(exportedOnly: true);
	}

	internal static byte[] GetAotId()
	{
		byte[] array = new byte[16];
		if (GetAotIdInternal(array))
		{
			return array;
		}
		return null;
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern string get_code_base(Assembly a, bool escaped);

	[MethodImpl((MethodImplOptions)4096)]
	private extern string get_location();

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern string get_fullname(Assembly a);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern bool GetAotIdInternal(byte[] aotid);

	[MethodImpl((MethodImplOptions)4096)]
	internal static extern string InternalImageRuntimeVersion(Assembly a);

	[MethodImpl((MethodImplOptions)4096)]
	internal extern bool get_global_assembly_cache();

	internal static string GetCodeBase(Assembly a, bool escaped)
	{
		return get_code_base(a, escaped);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private extern bool GetManifestResourceInfoInternal(string name, ManifestResourceInfo info);

	public override ManifestResourceInfo GetManifestResourceInfo(string resourceName)
	{
		if (resourceName == null)
		{
			throw new ArgumentNullException("resourceName");
		}
		if (resourceName.Length == 0)
		{
			throw new ArgumentException("String cannot have zero length.");
		}
		ManifestResourceInfo manifestResourceInfo = new ManifestResourceInfo(null, null, (ResourceLocation)0);
		if (GetManifestResourceInfoInternal(resourceName, manifestResourceInfo))
		{
			return manifestResourceInfo;
		}
		return null;
	}

	[MethodImpl((MethodImplOptions)4096)]
	public override extern string[] GetManifestResourceNames();

	[MethodImpl((MethodImplOptions)4096)]
	internal extern IntPtr GetManifestResourceInternal(string name, out int size, out Module module);

	public unsafe override Stream GetManifestResourceStream(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		if (name.Length == 0)
		{
			throw new ArgumentException("String cannot have zero length.", "name");
		}
		ManifestResourceInfo manifestResourceInfo = GetManifestResourceInfo(name);
		if (manifestResourceInfo == null)
		{
			Assembly assembly = AppDomain.CurrentDomain.DoResourceResolve(name, this);
			if (assembly != null && assembly != this)
			{
				return assembly.GetManifestResourceStream(name);
			}
			return null;
		}
		if (manifestResourceInfo.ReferencedAssembly != null)
		{
			return manifestResourceInfo.ReferencedAssembly.GetManifestResourceStream(name);
		}
		if (manifestResourceInfo.FileName != null && manifestResourceInfo.ResourceLocation == (ResourceLocation)0)
		{
			if (fromByteArray)
			{
				throw new FileNotFoundException(manifestResourceInfo.FileName);
			}
			return new FileStream(Path.Combine(Path.GetDirectoryName(Location), manifestResourceInfo.FileName), FileMode.Open, FileAccess.Read);
		}
		IntPtr manifestResourceInternal = GetManifestResourceInternal(name, out var size, out var module);
		if (manifestResourceInternal == (IntPtr)0)
		{
			return null;
		}
		return new UnmanagedMemoryStreamForModule((byte*)(void*)manifestResourceInternal, size, module);
	}

	[MethodImpl((MethodImplOptions)8)]
	public override Stream GetManifestResourceStream(Type type, string name)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return GetManifestResourceStream(type, name, skipSecurityCheck: false, ref stackMark);
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

	public override IList<CustomAttributeData> GetCustomAttributesData()
	{
		return CustomAttributeData.GetCustomAttributes(this);
	}

	internal override Module GetManifestModule()
	{
		return GetManifestModuleInternal();
	}

	[MethodImpl((MethodImplOptions)4096)]
	internal extern Module GetManifestModuleInternal();

	[MethodImpl((MethodImplOptions)4096)]
	internal override extern Module[] GetModulesInternal();

	[MethodImpl((MethodImplOptions)4096)]
	private extern object GetFilesInternal(string name, bool getResourceModules);

	public override FileStream[] GetFiles(bool getResourceModules)
	{
		string[] array = (string[])GetFilesInternal(null, getResourceModules);
		if (array == null)
		{
			return EmptyArray<FileStream>.Value;
		}
		string location = Location;
		FileStream[] array2;
		if (location != string.Empty)
		{
			array2 = new FileStream[array.Length + 1];
			array2[0] = new FileStream(location, FileMode.Open, FileAccess.Read);
			for (int i = 0; i < array.Length; i++)
			{
				array2[i + 1] = new FileStream(array[i], FileMode.Open, FileAccess.Read);
			}
		}
		else
		{
			array2 = new FileStream[array.Length];
			for (int j = 0; j < array.Length; j++)
			{
				array2[j] = new FileStream(array[j], FileMode.Open, FileAccess.Read);
			}
		}
		return array2;
	}

	public override FileStream GetFile(string name)
	{
		if (name == null)
		{
			throw new ArgumentNullException(null, "Name cannot be null.");
		}
		if (name.Length == 0)
		{
			throw new ArgumentException("Empty name is not valid");
		}
		string text = (string)GetFilesInternal(name, getResourceModules: true);
		if (text != null)
		{
			return new FileStream(text, FileMode.Open, FileAccess.Read);
		}
		return null;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public override bool Equals(object o)
	{
		if (this == o)
		{
			return true;
		}
		if (o == null)
		{
			return false;
		}
		if (!(o is RuntimeAssembly))
		{
			return false;
		}
		return ((RuntimeAssembly)o)._mono_assembly == _mono_assembly;
	}

	public override string ToString()
	{
		if (assemblyName != null)
		{
			return assemblyName;
		}
		assemblyName = FullName;
		return assemblyName;
	}

	internal override Evidence UnprotectedGetEvidence()
	{
		return null;
	}
}
