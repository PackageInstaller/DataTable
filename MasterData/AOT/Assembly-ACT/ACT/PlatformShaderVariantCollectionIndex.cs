using UnityEngine;

namespace ACT;

public sealed class PlatformShaderVariantCollectionIndex : ScriptableObject
{
	[SerializeField]
	private string _win64ShortVersion = string.Empty;

	[SerializeField]
	private string _androidShortVersion = string.Empty;

	[SerializeField]
	private string _iosShortVersion = string.Empty;

	[SerializeField]
	private ShaderVariantCollection _win64;

	[SerializeField]
	private ShaderVariantCollection _android;

	[SerializeField]
	private ShaderVariantCollection _ios;

	public string GetShortVersion(string platform)
	{
		return platform switch
		{
			"Win64" => _win64ShortVersion, 
			"Android" => _androidShortVersion, 
			"iOS" => _iosShortVersion, 
			_ => string.Empty, 
		};
	}

	public ShaderVariantCollection GetCollection(string platform)
	{
		return platform switch
		{
			"Win64" => _win64, 
			"Android" => _android, 
			"iOS" => _ios, 
			_ => null, 
		};
	}
}
