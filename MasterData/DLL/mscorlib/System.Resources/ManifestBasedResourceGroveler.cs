using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading;

namespace System.Resources;

internal class ManifestBasedResourceGroveler : IResourceGroveler
{
	private ResourceManager.ResourceManagerMediator _mediator;

	public ManifestBasedResourceGroveler(ResourceManager.ResourceManagerMediator mediator)
	{
		_mediator = mediator;
	}

	[MethodImpl((MethodImplOptions)8)]
	public ResourceSet GrovelForResourceSet(CultureInfo culture, Dictionary<string, ResourceSet> localResourceSets, bool tryParents, bool createIfNotExists, ref StackCrawlMark stackMark)
	{
		ResourceSet value = null;
		Stream stream = null;
		RuntimeAssembly runtimeAssembly = null;
		CultureInfo cultureInfo = UltimateFallbackFixup(culture);
		if (cultureInfo.HasInvariantCultureName && _mediator.FallbackLoc == UltimateResourceFallbackLocation.MainAssembly)
		{
			runtimeAssembly = _mediator.MainAssembly;
		}
		else
		{
			runtimeAssembly = GetSatelliteAssembly(cultureInfo, ref stackMark);
			if (runtimeAssembly == null && culture.HasInvariantCultureName && _mediator.FallbackLoc == UltimateResourceFallbackLocation.Satellite)
			{
				HandleSatelliteMissing();
			}
		}
		string resourceFileName = _mediator.GetResourceFileName(cultureInfo);
		if (runtimeAssembly != null)
		{
			lock (localResourceSets)
			{
				localResourceSets.TryGetValue(culture.Name, out value);
			}
			stream = GetManifestResourceStream(runtimeAssembly, resourceFileName, ref stackMark);
		}
		if (createIfNotExists && stream != null && value == null)
		{
			value = CreateResourceSet(stream, runtimeAssembly);
		}
		else if (((stream == null) & tryParents) && culture.HasInvariantCultureName)
		{
			HandleResourceStreamMissing(resourceFileName);
		}
		return value;
	}

	private CultureInfo UltimateFallbackFixup(CultureInfo lookForCulture)
	{
		CultureInfo result = lookForCulture;
		if (lookForCulture.Name == _mediator.NeutralResourcesCulture.Name && _mediator.FallbackLoc == UltimateResourceFallbackLocation.MainAssembly)
		{
			result = CultureInfo.InvariantCulture;
		}
		else if (lookForCulture.HasInvariantCultureName && _mediator.FallbackLoc == UltimateResourceFallbackLocation.Satellite)
		{
			result = _mediator.NeutralResourcesCulture;
		}
		return result;
	}

	internal static CultureInfo GetNeutralResourcesLanguage(Assembly a, ref UltimateResourceFallbackLocation fallbackLocation)
	{
		string cultureName = null;
		short fallbackLocation2 = 0;
		if (GetNeutralResourcesLanguageAttribute(a, ref cultureName, ref fallbackLocation2))
		{
			if (fallbackLocation2 < 0 || fallbackLocation2 > 1)
			{
				throw new ArgumentException(Environment.GetResourceString("The NeutralResourcesLanguageAttribute specifies an invalid or unrecognized ultimate resource fallback location: \"{0}\".", fallbackLocation2));
			}
			fallbackLocation = (UltimateResourceFallbackLocation)fallbackLocation2;
			try
			{
				return CultureInfo.GetCultureInfo(cultureName);
			}
			catch (ArgumentException innerException)
			{
				if (a == typeof(object).Assembly)
				{
					return CultureInfo.InvariantCulture;
				}
				throw new ArgumentException(Environment.GetResourceString("The NeutralResourcesLanguageAttribute on the assembly \"{0}\" specifies an invalid culture name: \"{1}\".", a.ToString(), cultureName), innerException);
			}
		}
		fallbackLocation = UltimateResourceFallbackLocation.MainAssembly;
		return CultureInfo.InvariantCulture;
	}

	internal ResourceSet CreateResourceSet(Stream store, Assembly assembly)
	{
		if (store.CanSeek && store.Length > 4)
		{
			long position = store.Position;
			BinaryReader binaryReader = new BinaryReader(store);
			if (binaryReader.ReadInt32() == ResourceManager.MagicNumber)
			{
				int num = binaryReader.ReadInt32();
				string text = null;
				string text2 = null;
				if (num == ResourceManager.HeaderVersionNumber)
				{
					binaryReader.ReadInt32();
					text = binaryReader.ReadString();
					text2 = binaryReader.ReadString();
				}
				else
				{
					if (num <= ResourceManager.HeaderVersionNumber)
					{
						throw new NotSupportedException(Environment.GetResourceString("Found an obsolete .resources file in assembly '{0}'. Rebuild that .resources file then rebuild that assembly.", _mediator.MainAssembly.GetSimpleName()));
					}
					int num2 = binaryReader.ReadInt32();
					long offset = binaryReader.BaseStream.Position + num2;
					text = binaryReader.ReadString();
					text2 = binaryReader.ReadString();
					binaryReader.BaseStream.Seek(offset, SeekOrigin.Begin);
				}
				store.Position = position;
				if (CanUseDefaultResourceClasses(text, text2))
				{
					return new RuntimeResourceSet(store);
				}
				IResourceReader resourceReader = (IResourceReader)Activator.CreateInstance(Type.GetType(text, throwOnError: true), store);
				object[] args = new object[1] { resourceReader };
				Type type = ((!(_mediator.UserResourceSet == null)) ? _mediator.UserResourceSet : Type.GetType(text2, throwOnError: true, ignoreCase: false));
				return (ResourceSet)Activator.CreateInstance(type, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.CreateInstance, null, args, null, null);
			}
			store.Position = position;
		}
		if (_mediator.UserResourceSet == null)
		{
			return new RuntimeResourceSet(store);
		}
		object[] args2 = new object[2] { store, assembly };
		try
		{
			try
			{
				return (ResourceSet)Activator.CreateInstance(_mediator.UserResourceSet, args2);
			}
			catch (MissingMethodException)
			{
			}
			return (ResourceSet)Activator.CreateInstance(args: new object[1] { store }, type: _mediator.UserResourceSet);
		}
		catch (MissingMethodException innerException)
		{
			throw new InvalidOperationException(Environment.GetResourceString("'{0}': ResourceSet derived classes must provide a constructor that takes a String file name and a constructor that takes a Stream.", _mediator.UserResourceSet.AssemblyQualifiedName), innerException);
		}
	}

	private Stream GetManifestResourceStream(RuntimeAssembly satellite, string fileName, ref StackCrawlMark stackMark)
	{
		bool skipSecurityCheck = _mediator.MainAssembly == satellite && _mediator.CallingAssembly == _mediator.MainAssembly;
		Stream stream = satellite.GetManifestResourceStream(_mediator.LocationInfo, fileName, skipSecurityCheck, ref stackMark);
		if (stream == null)
		{
			stream = CaseInsensitiveManifestResourceStreamLookup(satellite, fileName);
		}
		return stream;
	}

	[MethodImpl((MethodImplOptions)8)]
	private Stream CaseInsensitiveManifestResourceStreamLookup(RuntimeAssembly satellite, string name)
	{
		StringBuilder stringBuilder = new StringBuilder();
		if (_mediator.LocationInfo != null)
		{
			string text = _mediator.LocationInfo.Namespace;
			if (text != null)
			{
				stringBuilder.Append(text);
				if (name != null)
				{
					stringBuilder.Append(Type.Delimiter);
				}
			}
		}
		stringBuilder.Append(name);
		string text2 = stringBuilder.ToString();
		CompareInfo compareInfo = CultureInfo.InvariantCulture.CompareInfo;
		string text3 = null;
		string[] manifestResourceNames = satellite.GetManifestResourceNames();
		foreach (string text4 in manifestResourceNames)
		{
			if (compareInfo.Compare(text4, text2, CompareOptions.IgnoreCase) == 0)
			{
				if (text3 != null)
				{
					throw new MissingManifestResourceException(Environment.GetResourceString("A case-insensitive lookup for resource file \"{0}\" in assembly \"{1}\" found multiple entries. Remove the duplicates or specify the exact case.", text2, satellite.ToString()));
				}
				text3 = text4;
			}
		}
		if (text3 == null)
		{
			return null;
		}
		bool skipSecurityCheck = _mediator.MainAssembly == satellite && _mediator.CallingAssembly == _mediator.MainAssembly;
		StackCrawlMark stackMark = StackCrawlMark.LookForMyCaller;
		return satellite.GetManifestResourceStream(text3, ref stackMark, skipSecurityCheck);
	}

	[MethodImpl((MethodImplOptions)8)]
	private RuntimeAssembly GetSatelliteAssembly(CultureInfo lookForCulture, ref StackCrawlMark stackMark)
	{
		if (!_mediator.LookedForSatelliteContractVersion)
		{
			_mediator.SatelliteContractVersion = _mediator.ObtainSatelliteContractVersion(_mediator.MainAssembly);
			_mediator.LookedForSatelliteContractVersion = true;
		}
		RuntimeAssembly result = null;
		string satelliteAssemblyName = GetSatelliteAssemblyName();
		try
		{
			result = _mediator.MainAssembly.InternalGetSatelliteAssembly(satelliteAssemblyName, lookForCulture, _mediator.SatelliteContractVersion, throwOnFileNotFound: false, ref stackMark);
		}
		catch (FileLoadException)
		{
		}
		catch (BadImageFormatException)
		{
		}
		return result;
	}

	private bool CanUseDefaultResourceClasses(string readerTypeName, string resSetTypeName)
	{
		if (_mediator.UserResourceSet != null)
		{
			return false;
		}
		AssemblyName asmName = new AssemblyName(ResourceManager.MscorlibName);
		if (readerTypeName != null && !ResourceManager.CompareNames(readerTypeName, ResourceManager.ResReaderTypeName, asmName))
		{
			return false;
		}
		if (resSetTypeName != null && !ResourceManager.CompareNames(resSetTypeName, ResourceManager.ResSetTypeName, asmName))
		{
			return false;
		}
		return true;
	}

	private string GetSatelliteAssemblyName()
	{
		return _mediator.MainAssembly.GetSimpleName() + ".resources";
	}

	private void HandleSatelliteMissing()
	{
		string text = _mediator.MainAssembly.GetSimpleName() + ".resources.dll";
		if (_mediator.SatelliteContractVersion != null)
		{
			text = text + ", Version=" + _mediator.SatelliteContractVersion.ToString();
		}
		AssemblyName assemblyName = new AssemblyName();
		assemblyName.SetPublicKey(_mediator.MainAssembly.GetPublicKey());
		byte[] publicKeyToken = assemblyName.GetPublicKeyToken();
		int num = publicKeyToken.Length;
		StringBuilder stringBuilder = new StringBuilder(num * 2);
		for (int i = 0; i < num; i++)
		{
			stringBuilder.Append(publicKeyToken[i].ToString("x", CultureInfo.InvariantCulture));
		}
		text = text + ", PublicKeyToken=" + stringBuilder;
		string text2 = _mediator.NeutralResourcesCulture.Name;
		if (text2.Length == 0)
		{
			text2 = "<invariant>";
		}
		throw new MissingSatelliteAssemblyException(Environment.GetResourceString("The satellite assembly named \"{1}\" for fallback culture \"{0}\" either could not be found or could not be loaded. This is generally a setup problem. Please consider reinstalling or repairing the application.", _mediator.NeutralResourcesCulture, text), text2);
	}

	private void HandleResourceStreamMissing(string fileName)
	{
		if (_mediator.MainAssembly == typeof(object).Assembly && _mediator.BaseName.Equals("mscorlib"))
		{
			Environment.FailFast("mscorlib.resources couldn't be found!  Large parts of the BCL won't work!");
		}
		string text = string.Empty;
		if (_mediator.LocationInfo != null && _mediator.LocationInfo.Namespace != null)
		{
			text = _mediator.LocationInfo.Namespace + Type.Delimiter;
		}
		text += fileName;
		throw new MissingManifestResourceException(Environment.GetResourceString("Could not find any resources appropriate for the specified culture or the neutral culture.  Make sure \"{0}\" was correctly embedded or linked into assembly \"{1}\" at compile time, or that all the satellite assemblies required are loadable and fully signed.", text, _mediator.MainAssembly.GetSimpleName()));
	}

	private static bool GetNeutralResourcesLanguageAttribute(Assembly assembly, ref string cultureName, ref short fallbackLocation)
	{
		NeutralResourcesLanguageAttribute customAttribute = assembly.GetCustomAttribute<NeutralResourcesLanguageAttribute>();
		if (customAttribute == null)
		{
			return false;
		}
		cultureName = customAttribute.CultureName;
		fallbackLocation = (short)customAttribute.Location;
		return true;
	}
}
