namespace YooAsset;

internal abstract class FSLoadPackageManifestOperation : AsyncOperationBase
{
	internal PackageManifest Manifest { get; set; }
}
