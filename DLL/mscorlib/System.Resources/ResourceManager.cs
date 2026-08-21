using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;
using System.Text;
using System.Threading;

namespace System.Resources;

[Serializable]
[ComVisible(true)]
public class ResourceManager
{
	internal class CultureNameResourceSetPair
	{
		public string lastCultureName;

		public ResourceSet lastResourceSet;
	}

	internal class ResourceManagerMediator
	{
		private ResourceManager _rm;

		internal string ModuleDir => _rm.moduleDir;

		internal Type LocationInfo => _rm._locationInfo;

		internal Type UserResourceSet => _rm._userResourceSet;

		internal string BaseNameField => _rm.BaseNameField;

		internal CultureInfo NeutralResourcesCulture => _rm._neutralResourcesCulture;

		internal bool LookedForSatelliteContractVersion
		{
			get
			{
				return _rm._lookedForSatelliteContractVersion;
			}
			set
			{
				_rm._lookedForSatelliteContractVersion = value;
			}
		}

		internal Version SatelliteContractVersion
		{
			get
			{
				return _rm._satelliteContractVersion;
			}
			set
			{
				_rm._satelliteContractVersion = value;
			}
		}

		internal UltimateResourceFallbackLocation FallbackLoc => _rm.FallbackLocation;

		internal RuntimeAssembly CallingAssembly => _rm.m_callingAssembly;

		internal RuntimeAssembly MainAssembly => (RuntimeAssembly)_rm.MainAssembly;

		internal string BaseName => _rm.BaseName;

		internal ResourceManagerMediator(ResourceManager rm)
		{
			if (rm == null)
			{
				throw new ArgumentNullException("rm");
			}
			_rm = rm;
		}

		internal string GetResourceFileName(CultureInfo culture)
		{
			return _rm.GetResourceFileName(culture);
		}

		internal Version ObtainSatelliteContractVersion(Assembly a)
		{
			return GetSatelliteContractVersion(a);
		}
	}

	protected string BaseNameField;

	[Obsolete("call InternalGetResourceSet instead")]
	protected Hashtable ResourceSets;

	[NonSerialized]
	private Dictionary<string, ResourceSet> _resourceSets;

	private string moduleDir;

	protected Assembly MainAssembly;

	private Type _locationInfo;

	private Type _userResourceSet;

	private CultureInfo _neutralResourcesCulture;

	[NonSerialized]
	private CultureNameResourceSetPair _lastUsedResourceCache;

	private bool _ignoreCase;

	private bool UseManifest;

	[OptionalField(VersionAdded = 1)]
	private bool UseSatelliteAssem;

	[OptionalField]
	private UltimateResourceFallbackLocation _fallbackLoc;

	[OptionalField]
	private Version _satelliteContractVersion;

	[OptionalField]
	private bool _lookedForSatelliteContractVersion;

	[OptionalField(VersionAdded = 1)]
	private Assembly _callingAssembly;

	[OptionalField(VersionAdded = 4)]
	private RuntimeAssembly m_callingAssembly;

	[NonSerialized]
	private IResourceGroveler resourceGroveler;

	public static readonly int MagicNumber = -1091581234;

	public static readonly int HeaderVersionNumber = 1;

	private static readonly Type _minResourceSet = typeof(ResourceSet);

	internal static readonly string ResReaderTypeName = typeof(ResourceReader).FullName;

	internal static readonly string ResSetTypeName = typeof(RuntimeResourceSet).FullName;

	internal static readonly string MscorlibName = typeof(ResourceReader).Assembly.FullName;

	internal static readonly int DEBUG = 0;

	public virtual string BaseName => BaseNameField;

	protected UltimateResourceFallbackLocation FallbackLocation => _fallbackLoc;

	[MethodImpl((MethodImplOptions)8)]
	private void Init()
	{
		try
		{
			m_callingAssembly = (RuntimeAssembly)Assembly.GetCallingAssembly();
		}
		catch
		{
		}
	}

	protected ResourceManager()
	{
		Init();
		_lastUsedResourceCache = new CultureNameResourceSetPair();
		ResourceManagerMediator mediator = new ResourceManagerMediator(this);
		resourceGroveler = new ManifestBasedResourceGroveler(mediator);
	}

	[MethodImpl((MethodImplOptions)8)]
	public ResourceManager(string baseName, Assembly assembly)
	{
		if (baseName == null)
		{
			throw new ArgumentNullException("baseName");
		}
		if (null == assembly)
		{
			throw new ArgumentNullException("assembly");
		}
		if (!(assembly is RuntimeAssembly))
		{
			throw new ArgumentException(Environment.GetResourceString("Assembly must be a runtime Assembly object."));
		}
		MainAssembly = assembly;
		BaseNameField = baseName;
		SetAppXConfiguration();
		CommonAssemblyInit();
		try
		{
			m_callingAssembly = (RuntimeAssembly)Assembly.GetCallingAssembly();
			if (assembly == typeof(object).Assembly && m_callingAssembly != assembly)
			{
				m_callingAssembly = null;
			}
		}
		catch
		{
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	public ResourceManager(Type resourceSource)
	{
		if (null == resourceSource)
		{
			throw new ArgumentNullException("resourceSource");
		}
		if (!(resourceSource is RuntimeType))
		{
			throw new ArgumentException(Environment.GetResourceString("Type must be a runtime Type object."));
		}
		_locationInfo = resourceSource;
		MainAssembly = _locationInfo.Assembly;
		BaseNameField = resourceSource.Name;
		SetAppXConfiguration();
		CommonAssemblyInit();
		try
		{
			m_callingAssembly = (RuntimeAssembly)Assembly.GetCallingAssembly();
			if (MainAssembly == typeof(object).Assembly && m_callingAssembly != MainAssembly)
			{
				m_callingAssembly = null;
			}
		}
		catch
		{
		}
	}

	[OnDeserializing]
	private void OnDeserializing(StreamingContext ctx)
	{
		_resourceSets = null;
		resourceGroveler = null;
		_lastUsedResourceCache = null;
	}

	[OnDeserialized]
	private void OnDeserialized(StreamingContext ctx)
	{
		_resourceSets = new Dictionary<string, ResourceSet>();
		_lastUsedResourceCache = new CultureNameResourceSetPair();
		ResourceManagerMediator mediator = new ResourceManagerMediator(this);
		if (UseManifest)
		{
			resourceGroveler = new ManifestBasedResourceGroveler(mediator);
		}
		else
		{
			resourceGroveler = new FileBasedResourceGroveler(mediator);
		}
		if (m_callingAssembly == null)
		{
			m_callingAssembly = (RuntimeAssembly)_callingAssembly;
		}
		if (UseManifest && _neutralResourcesCulture == null)
		{
			_neutralResourcesCulture = ManifestBasedResourceGroveler.GetNeutralResourcesLanguage(MainAssembly, ref _fallbackLoc);
		}
	}

	[OnSerializing]
	private void OnSerializing(StreamingContext ctx)
	{
		_callingAssembly = m_callingAssembly;
		UseSatelliteAssem = UseManifest;
		ResourceSets = new Hashtable();
	}

	private void CommonAssemblyInit()
	{
		UseManifest = true;
		_resourceSets = new Dictionary<string, ResourceSet>();
		_lastUsedResourceCache = new CultureNameResourceSetPair();
		_fallbackLoc = UltimateResourceFallbackLocation.MainAssembly;
		ResourceManagerMediator mediator = new ResourceManagerMediator(this);
		resourceGroveler = new ManifestBasedResourceGroveler(mediator);
		_neutralResourcesCulture = ManifestBasedResourceGroveler.GetNeutralResourcesLanguage(MainAssembly, ref _fallbackLoc);
		ResourceSets = new Hashtable();
	}

	protected virtual string GetResourceFileName(CultureInfo culture)
	{
		StringBuilder stringBuilder = new StringBuilder(255);
		stringBuilder.Append(BaseNameField);
		if (!culture.HasInvariantCultureName)
		{
			CultureInfo.VerifyCultureName(culture.Name, throwException: true);
			stringBuilder.Append('.');
			stringBuilder.Append(culture.Name);
		}
		stringBuilder.Append(".resources");
		return stringBuilder.ToString();
	}

	internal ResourceSet GetFirstResourceSet(CultureInfo culture)
	{
		if (_neutralResourcesCulture != null && culture.Name == _neutralResourcesCulture.Name)
		{
			culture = CultureInfo.InvariantCulture;
		}
		if (_lastUsedResourceCache != null)
		{
			lock (_lastUsedResourceCache)
			{
				if (culture.Name == _lastUsedResourceCache.lastCultureName)
				{
					return _lastUsedResourceCache.lastResourceSet;
				}
			}
		}
		Dictionary<string, ResourceSet> resourceSets = _resourceSets;
		ResourceSet value = null;
		if (resourceSets != null)
		{
			lock (resourceSets)
			{
				resourceSets.TryGetValue(culture.Name, out value);
			}
		}
		if (value != null)
		{
			if (_lastUsedResourceCache != null)
			{
				lock (_lastUsedResourceCache)
				{
					_lastUsedResourceCache.lastCultureName = culture.Name;
					_lastUsedResourceCache.lastResourceSet = value;
				}
			}
			return value;
		}
		return null;
	}

	[MethodImpl((MethodImplOptions)8)]
	protected virtual ResourceSet InternalGetResourceSet(CultureInfo culture, bool createIfNotExists, bool tryParents)
	{
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return InternalGetResourceSet(culture, createIfNotExists, tryParents, ref stackMark);
	}

	private ResourceSet InternalGetResourceSet(CultureInfo requestedCulture, bool createIfNotExists, bool tryParents, ref StackCrawlMark stackMark)
	{
		Dictionary<string, ResourceSet> resourceSets = _resourceSets;
		ResourceSet value = null;
		CultureInfo cultureInfo = null;
		lock (resourceSets)
		{
			if (resourceSets.TryGetValue(requestedCulture.Name, out value))
			{
				return value;
			}
		}
		ResourceFallbackManager resourceFallbackManager = new ResourceFallbackManager(requestedCulture, _neutralResourcesCulture, tryParents);
		foreach (CultureInfo item in resourceFallbackManager)
		{
			lock (resourceSets)
			{
				if (resourceSets.TryGetValue(item.Name, out value))
				{
					if (requestedCulture != item)
					{
						cultureInfo = item;
					}
					break;
				}
			}
			value = resourceGroveler.GrovelForResourceSet(item, resourceSets, tryParents, createIfNotExists, ref stackMark);
			if (value != null)
			{
				cultureInfo = item;
				break;
			}
		}
		if (value != null && cultureInfo != null)
		{
			foreach (CultureInfo item2 in resourceFallbackManager)
			{
				AddResourceSet(resourceSets, item2.Name, ref value);
				if (item2 == cultureInfo)
				{
					break;
				}
			}
		}
		return value;
	}

	private static void AddResourceSet(Dictionary<string, ResourceSet> localResourceSets, string cultureName, ref ResourceSet rs)
	{
		lock (localResourceSets)
		{
			if (localResourceSets.TryGetValue(cultureName, out var value))
			{
				if (value != rs)
				{
					if (!localResourceSets.ContainsValue(rs))
					{
						rs.Dispose();
					}
					rs = value;
				}
			}
			else
			{
				localResourceSets.Add(cultureName, rs);
			}
		}
	}

	protected static Version GetSatelliteContractVersion(Assembly a)
	{
		if (a == null)
		{
			throw new ArgumentNullException("a", Environment.GetResourceString("Assembly cannot be null."));
		}
		string text = null;
		if (a.ReflectionOnly)
		{
			foreach (CustomAttributeData customAttribute in CustomAttributeData.GetCustomAttributes(a))
			{
				if (customAttribute.Constructor.DeclaringType == typeof(SatelliteContractVersionAttribute))
				{
					text = (string)customAttribute.ConstructorArguments[0].Value;
					break;
				}
			}
			if (text == null)
			{
				return null;
			}
		}
		else
		{
			object[] customAttributes = a.GetCustomAttributes(typeof(SatelliteContractVersionAttribute), inherit: false);
			if (customAttributes.Length == 0)
			{
				return null;
			}
			text = ((SatelliteContractVersionAttribute)customAttributes[0]).Version;
		}
		try
		{
			return new Version(text);
		}
		catch (ArgumentOutOfRangeException innerException)
		{
			if (a == typeof(object).Assembly)
			{
				return null;
			}
			throw new ArgumentException(Environment.GetResourceString("Satellite contract version attribute on the assembly '{0}' specifies an invalid version: {1}.", a.ToString(), text), innerException);
		}
	}

	internal static bool CompareNames(string asmTypeName1, string typeName2, AssemblyName asmName2)
	{
		int num = asmTypeName1.IndexOf(',');
		if (((num == -1) ? asmTypeName1.Length : num) != typeName2.Length)
		{
			return false;
		}
		if (string.Compare(asmTypeName1, 0, typeName2, 0, typeName2.Length, StringComparison.Ordinal) != 0)
		{
			return false;
		}
		if (num == -1)
		{
			return true;
		}
		while (char.IsWhiteSpace(asmTypeName1[++num]))
		{
		}
		AssemblyName assemblyName = new AssemblyName(asmTypeName1.Substring(num));
		if (string.Compare(assemblyName.Name, asmName2.Name, StringComparison.OrdinalIgnoreCase) != 0)
		{
			return false;
		}
		if (string.Compare(assemblyName.Name, "mscorlib", StringComparison.OrdinalIgnoreCase) == 0)
		{
			return true;
		}
		if (assemblyName.CultureInfo != null && asmName2.CultureInfo != null && assemblyName.CultureInfo.LCID != asmName2.CultureInfo.LCID)
		{
			return false;
		}
		byte[] publicKeyToken = assemblyName.GetPublicKeyToken();
		byte[] publicKeyToken2 = asmName2.GetPublicKeyToken();
		if (publicKeyToken != null && publicKeyToken2 != null)
		{
			if (publicKeyToken.Length != publicKeyToken2.Length)
			{
				return false;
			}
			for (int i = 0; i < publicKeyToken.Length; i++)
			{
				if (publicKeyToken[i] != publicKeyToken2[i])
				{
					return false;
				}
			}
		}
		return true;
	}

	private void SetAppXConfiguration()
	{
	}

	public virtual string GetString(string name)
	{
		return GetString(name, null);
	}

	public virtual string GetString(string name, CultureInfo culture)
	{
		if (name == null)
		{
			throw new ArgumentNullException("name");
		}
		if (culture == null)
		{
			culture = Thread.CurrentThread.GetCurrentUICultureNoAppX();
		}
		ResourceSet resourceSet = GetFirstResourceSet(culture);
		if (resourceSet != null)
		{
			string text = resourceSet.GetString(name, _ignoreCase);
			if (text != null)
			{
				return text;
			}
		}
		foreach (CultureInfo item in new ResourceFallbackManager(culture, _neutralResourcesCulture, useParents: true))
		{
			ResourceSet resourceSet2 = InternalGetResourceSet(item, createIfNotExists: true, tryParents: true);
			if (resourceSet2 == null)
			{
				break;
			}
			if (resourceSet2 == resourceSet)
			{
				continue;
			}
			string text2 = resourceSet2.GetString(name, _ignoreCase);
			if (text2 != null)
			{
				if (_lastUsedResourceCache != null)
				{
					lock (_lastUsedResourceCache)
					{
						_lastUsedResourceCache.lastCultureName = item.Name;
						_lastUsedResourceCache.lastResourceSet = resourceSet2;
					}
				}
				return text2;
			}
			resourceSet = resourceSet2;
		}
		return null;
	}
}
