using System.IO;

namespace YooAsset;

public interface IRawFileDecryptionServices
{
	Stream OpenRawFileStream(DecryptFileInfo fileInfo);

	string GetDecryptedRawFilePath(DecryptFileInfo fileInfo);
}
