using UnityEngine;

namespace YooAsset;

[CreateAssetMenu(fileName = "YooAssetSettings", menuName = "YooAsset/Create YooAsset Settings")]
internal class YooAssetSettings : ScriptableObject
{
	public string DefaultYooFolderName = "yoo";

	public string PackageManifestPrefix = string.Empty;

	public const string OutputFolderName = "OutputCache";
}
