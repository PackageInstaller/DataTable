using System.IO;
using UnityEngine.Networking;

namespace YooAsset;

internal class DownloadHandlerFileRange : DownloadHandlerScript
{
	private string _fileSavePath;

	private long _fileTotalSize;

	private UnityWebRequest _webRequest;

	private FileStream _fileStream;

	private long _localFileSize;

	private long _curFileSize;

	public DownloadHandlerFileRange(string fileSavePath, long fileTotalSize, UnityWebRequest webRequest)
		: base(new byte[1048576])
	{
		_fileSavePath = fileSavePath;
		_fileTotalSize = fileTotalSize;
		_webRequest = webRequest;
		if (File.Exists(fileSavePath))
		{
			FileInfo fileInfo = new FileInfo(fileSavePath);
			_localFileSize = fileInfo.Length;
		}
		_fileStream = new FileStream(_fileSavePath, FileMode.Append, FileAccess.Write);
		_curFileSize = _localFileSize;
	}

	protected override bool ReceiveData(byte[] data, int dataLength)
	{
		if (data == null || dataLength == 0 || _webRequest.responseCode >= 400)
		{
			return false;
		}
		if (_fileStream == null)
		{
			return false;
		}
		_fileStream.Write(data, 0, dataLength);
		_curFileSize += dataLength;
		return true;
	}

	protected override byte[] GetData()
	{
		return null;
	}

	protected override string GetText()
	{
		return null;
	}

	protected override float GetProgress()
	{
		if (_fileTotalSize != 0L)
		{
			return (float)_curFileSize / (float)_fileTotalSize;
		}
		return 0f;
	}

	public void Cleanup()
	{
		if (_fileStream != null)
		{
			_fileStream.Flush();
			_fileStream.Dispose();
			_fileStream = null;
		}
	}
}
