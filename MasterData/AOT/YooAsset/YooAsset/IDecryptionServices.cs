namespace YooAsset;

public interface IDecryptionServices
{
	DecryptResult LoadAssetBundle(DecryptFileInfo fileInfo);

	DecryptResult LoadAssetBundleAsync(DecryptFileInfo fileInfo);

	DecryptResult LoadAssetBundleFallback(DecryptFileInfo fileInfo);

	byte[] ReadFileData(DecryptFileInfo fileInfo);

	string ReadFileText(DecryptFileInfo fileInfo);
}
