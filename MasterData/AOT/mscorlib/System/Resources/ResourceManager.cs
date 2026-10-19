using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Runtime.Serialization;

namespace System.Resources;

[Serializable]
[ComVisible(true)]
public class ResourceManager
{
	internal class CultureNameResourceSetPair
	{
	}

	internal class ResourceManagerMediator
	{
		private ResourceManager _rm;

		internal ResourceManagerMediator(ResourceManager rm)
		{
			if (rm == null)
			{
				throw new ArgumentNullException("rm");
			}
			_rm = rm;
		}
	}

	[Obsolete("call InternalGetResourceSet instead")]
	protected Hashtable ResourceSets;

	[NonSerialized]
	private Dictionary<string, ResourceSet> _resourceSets;

	protected Assembly MainAssembly;

	private CultureInfo _neutralResourcesCulture;

	[NonSerialized]
	private CultureNameResourceSetPair _lastUsedResourceCache;

	private bool UseManifest;

	[OptionalField(VersionAdded = 1)]
	private bool UseSatelliteAssem;

	[OptionalField]
	private UltimateResourceFallbackLocation _fallbackLoc;

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
}
