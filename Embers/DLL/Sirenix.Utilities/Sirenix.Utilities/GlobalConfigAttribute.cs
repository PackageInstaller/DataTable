using System;
using System.ComponentModel;
using UnityEngine;

namespace Sirenix.Utilities;

[AttributeUsage(AttributeTargets.Class)]
public class GlobalConfigAttribute : Attribute
{
	private string assetPath;

	[Obsolete("It's a bit more complicated than that as it's not always possible to know the full path, so try and make due without it if you can, only using the AssetDatabase.")]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public string FullPath => Application.dataPath + "/" + AssetPath;

	public string AssetPath => assetPath.Trim().TrimEnd('/', '\\').TrimStart('/', '\\')
		.Replace('\\', '/') + "/";

	internal string AssetPathWithAssetsPrefix
	{
		get
		{
			string text = AssetPath;
			if (text.StartsWith("Assets/"))
			{
				return text;
			}
			return "Assets/" + text;
		}
	}

	internal string AssetPathWithoutAssetsPrefix
	{
		get
		{
			string text = AssetPath;
			if (text.StartsWith("Assets/"))
			{
				return text.Substring("Assets/".Length);
			}
			return text;
		}
	}

	public string ResourcesPath
	{
		get
		{
			if (IsInResourcesFolder)
			{
				string text = AssetPath;
				int num = text.LastIndexOf("/resources/", StringComparison.InvariantCultureIgnoreCase);
				if (num >= 0)
				{
					return text.Substring(num + "/resources/".Length);
				}
			}
			return "";
		}
	}

	[Obsolete("This option is obsolete and will have no effect - a GlobalConfig will always have an asset generated now; use a POCO singleton or a ScriptableSingleton<T> instead. Asset-less config objects that are recreated every reload cause UnityEngine.Object leaks.", true)]
	[EditorBrowsable(EditorBrowsableState.Never)]
	public bool UseAsset { get; set; }

	public bool IsInResourcesFolder => StringExtensions.Contains(AssetPath, "/resources/", StringComparison.OrdinalIgnoreCase);

	public GlobalConfigAttribute()
		: this("Assets/Resources/Global Settings")
	{
	}

	public GlobalConfigAttribute(string assetPath)
	{
		this.assetPath = assetPath;
	}
}
