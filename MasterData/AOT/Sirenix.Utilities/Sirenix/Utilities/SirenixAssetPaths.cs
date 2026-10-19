using System.Collections.Generic;
using System.IO;

namespace Sirenix.Utilities;

public static class SirenixAssetPaths
{
	public const string DefaultSirenixPluginPath = "Assets/Plugins/Sirenix/";

	public const string SirenixAssetPathsSOGuid = "08379ccefc05200459f90a1c0711a340";

	public const string LookupAssetName = "OdinPathLookup.asset";

	public static readonly string OdinPath;

	public static readonly string SirenixAssetsPath;

	public static readonly string SirenixPluginPath;

	public static readonly string SirenixAssembliesPath;

	public static readonly string OdinResourcesPath;

	public static readonly string OdinEditorConfigsPath;

	public static readonly string OdinResourcesConfigsPath;

	public static readonly string OdinTempPath;

	private static readonly HashSet<char> IllegalChars;

	static SirenixAssetPaths()
	{
		IllegalChars = new HashSet<char>(Path.GetInvalidFileNameChars()) { '.' };
		SirenixPluginPath = "Assets/Plugins/Sirenix/";
		OdinPath = SirenixPluginPath + "Odin Inspector/";
		SirenixAssetsPath = SirenixPluginPath + "Assets/";
		SirenixAssembliesPath = SirenixPluginPath + "Assemblies/";
		OdinResourcesPath = OdinPath + "Config/Resources/Sirenix/";
		OdinEditorConfigsPath = OdinPath + "Config/Editor/";
		OdinResourcesConfigsPath = OdinResourcesPath;
	}

	private static string ReplaceIllegalCharacters(string source, char replacement)
	{
		char[] array = source.ToCharArray();
		for (int i = 0; i < array.Length; i++)
		{
			if (IllegalChars.Contains(array[i]))
			{
				array[i] = replacement;
			}
		}
		return new string(array);
	}
}
