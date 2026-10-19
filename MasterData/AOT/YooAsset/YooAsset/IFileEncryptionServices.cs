namespace YooAsset;

public interface IFileEncryptionServices
{
	bool EncryptFile(EncryptFileInfo fileInfo, string outputFilePath);
}
