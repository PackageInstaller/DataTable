using System;
using System.Collections;
using System.Text;
using ES3Internal;
using UnityEngine;
using UnityEngine.Networking;

public class ES3Cloud : ES3WebClass
{
	private int timeout = 20;

	public Encoding encoding = Encoding.UTF8;

	private byte[] _data;

	public byte[] data => _data;

	public string text
	{
		get
		{
			if (data == null)
			{
				return null;
			}
			return encoding.GetString(data);
		}
	}

	public string[] filenames
	{
		get
		{
			if (data == null || data.Length == 0)
			{
				return new string[0];
			}
			return text.Split(new char[1] { ';' }, StringSplitOptions.RemoveEmptyEntries);
		}
	}

	public DateTime timestamp
	{
		get
		{
			if (data == null || data.Length == 0)
			{
				return new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
			}
			if (!double.TryParse(text, out var result))
			{
				throw new FormatException("Could not convert downloaded data to a timestamp. Data downloaded was: " + text);
			}
			return new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc).AddSeconds(result);
		}
	}

	public ES3Cloud(string url, string apiKey)
		: base(url, apiKey)
	{
	}

	public ES3Cloud(string url, string apiKey, int timeout)
		: base(url, apiKey)
	{
		this.timeout = timeout;
	}

	public IEnumerator Sync()
	{
		return Sync(new ES3Settings(), "", "");
	}

	public IEnumerator Sync(string filePath)
	{
		return Sync(new ES3Settings(filePath), "", "");
	}

	public IEnumerator Sync(string filePath, string user)
	{
		return Sync(new ES3Settings(filePath), user, "");
	}

	public IEnumerator Sync(string filePath, string user, string password)
	{
		return Sync(new ES3Settings(filePath), user, password);
	}

	public IEnumerator Sync(string filePath, ES3Settings settings)
	{
		return Sync(new ES3Settings(filePath, settings), "", "");
	}

	public IEnumerator Sync(string filePath, string user, ES3Settings settings)
	{
		return Sync(new ES3Settings(filePath, settings), user, "");
	}

	public IEnumerator Sync(string filePath, string user, string password, ES3Settings settings)
	{
		return Sync(new ES3Settings(filePath, settings), user, password);
	}

	private IEnumerator Sync(ES3Settings settings, string user, string password)
	{
		Reset();
		yield return DownloadFile(settings, user, password, GetFileTimestamp(settings));
		if (errorCode == 3)
		{
			Reset();
			if (ES3.FileExists(settings))
			{
				yield return UploadFile(settings, user, password);
			}
		}
		isDone = true;
	}

	public IEnumerator UploadFile()
	{
		return UploadFile(new ES3Settings(), "", "");
	}

	public IEnumerator UploadFile(string filePath)
	{
		return UploadFile(new ES3Settings(filePath), "", "");
	}

	public IEnumerator UploadFile(string filePath, string user)
	{
		return UploadFile(new ES3Settings(filePath), user, "");
	}

	public IEnumerator UploadFile(string filePath, string user, string password)
	{
		return UploadFile(new ES3Settings(filePath), user, password);
	}

	public IEnumerator UploadFile(string filePath, ES3Settings settings)
	{
		return UploadFile(new ES3Settings(filePath, settings), "", "");
	}

	public IEnumerator UploadFile(string filePath, string user, ES3Settings settings)
	{
		return UploadFile(new ES3Settings(filePath, settings), user, "");
	}

	public IEnumerator UploadFile(string filePath, string user, string password, ES3Settings settings)
	{
		return UploadFile(new ES3Settings(filePath, settings), user, password);
	}

	public IEnumerator UploadFile(ES3File es3File)
	{
		return UploadFile(es3File.GetBytes(), es3File.settings, "", "", DateTimeToUnixTimestamp(DateTime.Now));
	}

	public IEnumerator UploadFile(ES3File es3File, string user)
	{
		return UploadFile(es3File.GetBytes(), es3File.settings, user, "", DateTimeToUnixTimestamp(DateTime.Now));
	}

	public IEnumerator UploadFile(ES3File es3File, string user, string password)
	{
		return UploadFile(es3File.GetBytes(), es3File.settings, user, password, DateTimeToUnixTimestamp(DateTime.Now));
	}

	public IEnumerator UploadFile(ES3Settings settings, string user, string password)
	{
		return UploadFile(ES3.LoadRawBytes(settings), settings, user, password);
	}

	public IEnumerator UploadFile(byte[] bytes, ES3Settings settings, string user, string password)
	{
		return UploadFile(bytes, settings, user, password, DateTimeToUnixTimestamp(ES3.GetTimestamp(settings)));
	}

	private IEnumerator UploadFile(byte[] bytes, ES3Settings settings, string user, string password, long fileTimestamp)
	{
		Reset();
		WWWForm val = CreateWWWForm();
		val.AddField("apiKey", apiKey);
		val.AddField("putFile", settings.path);
		val.AddField("timestamp", fileTimestamp.ToString());
		val.AddField("user", GetUser(user, password));
		val.AddBinaryData("data", bytes, "data.dat", "multipart/form-data");
		UnityWebRequest webRequest = UnityWebRequest.Post(url, val);
		try
		{
			webRequest.timeout = timeout;
			yield return SendWebRequest(webRequest);
			HandleError(webRequest, errorIfDataIsDownloaded: true);
		}
		finally
		{
			((IDisposable)webRequest)?.Dispose();
		}
		isDone = true;
	}

	public IEnumerator DownloadFile()
	{
		return DownloadFile(new ES3Settings(), "", "", 0L);
	}

	public IEnumerator DownloadFile(string filePath)
	{
		return DownloadFile(new ES3Settings(filePath), "", "", 0L);
	}

	public IEnumerator DownloadFile(string filePath, string user)
	{
		return DownloadFile(new ES3Settings(filePath), user, "", 0L);
	}

	public IEnumerator DownloadFile(string filePath, string user, string password)
	{
		return DownloadFile(new ES3Settings(filePath), user, password, 0L);
	}

	public IEnumerator DownloadFile(string filePath, ES3Settings settings)
	{
		return DownloadFile(new ES3Settings(filePath, settings), "", "", 0L);
	}

	public IEnumerator DownloadFile(string filePath, string user, ES3Settings settings)
	{
		return DownloadFile(new ES3Settings(filePath, settings), user, "", 0L);
	}

	public IEnumerator DownloadFile(string filePath, string user, string password, ES3Settings settings)
	{
		return DownloadFile(new ES3Settings(filePath, settings), user, password, 0L);
	}

	public IEnumerator DownloadFile(ES3File es3File)
	{
		return DownloadFile(es3File, "", "", 0L);
	}

	public IEnumerator DownloadFile(ES3File es3File, string user)
	{
		return DownloadFile(es3File, user, "", 0L);
	}

	public IEnumerator DownloadFile(ES3File es3File, string user, string password)
	{
		return DownloadFile(es3File, user, password, 0L);
	}

	private IEnumerator DownloadFile(ES3File es3File, string user, string password, long timestamp)
	{
		Reset();
		WWWForm val = CreateWWWForm();
		val.AddField("apiKey", apiKey);
		val.AddField("getFile", es3File.settings.path);
		val.AddField("user", GetUser(user, password));
		if (timestamp > 0)
		{
			val.AddField("timestamp", timestamp.ToString());
		}
		UnityWebRequest webRequest = UnityWebRequest.Post(url, val);
		try
		{
			webRequest.timeout = timeout;
			yield return SendWebRequest(webRequest);
			if (!HandleError(webRequest, errorIfDataIsDownloaded: false))
			{
				if (webRequest.downloadedBytes != 0)
				{
					es3File.Clear();
					es3File.SaveRaw(webRequest.downloadHandler.data);
				}
				else
				{
					error = $"File {es3File.settings.path} was not found on the server.";
					errorCode = 3L;
				}
			}
		}
		finally
		{
			((IDisposable)webRequest)?.Dispose();
		}
		isDone = true;
	}

	private IEnumerator DownloadFile(ES3Settings settings, string user, string password, long timestamp)
	{
		Reset();
		WWWForm val = CreateWWWForm();
		val.AddField("apiKey", apiKey);
		val.AddField("getFile", settings.path);
		val.AddField("user", GetUser(user, password));
		if (timestamp > 0)
		{
			val.AddField("timestamp", timestamp.ToString());
		}
		UnityWebRequest webRequest = UnityWebRequest.Post(url, val);
		try
		{
			webRequest.timeout = timeout;
			yield return SendWebRequest(webRequest);
			if (!HandleError(webRequest, errorIfDataIsDownloaded: false))
			{
				if (webRequest.downloadedBytes != 0)
				{
					ES3.SaveRaw(webRequest.downloadHandler.data, settings);
				}
				else
				{
					error = $"File {settings.path} was not found on the server.";
					errorCode = 3L;
				}
			}
		}
		finally
		{
			((IDisposable)webRequest)?.Dispose();
		}
		isDone = true;
	}

	public IEnumerator DeleteFile()
	{
		return DeleteFile(new ES3Settings(), "", "");
	}

	public IEnumerator DeleteFile(string filePath)
	{
		return DeleteFile(new ES3Settings(filePath), "", "");
	}

	public IEnumerator DeleteFile(string filePath, string user)
	{
		return DeleteFile(new ES3Settings(filePath), user, "");
	}

	public IEnumerator DeleteFile(string filePath, string user, string password)
	{
		return DeleteFile(new ES3Settings(filePath), user, password);
	}

	public IEnumerator DeleteFile(string filePath, ES3Settings settings)
	{
		return DeleteFile(new ES3Settings(filePath, settings), "", "");
	}

	public IEnumerator DeleteFile(string filePath, string user, ES3Settings settings)
	{
		return DeleteFile(new ES3Settings(filePath, settings), user, "");
	}

	public IEnumerator DeleteFile(string filePath, string user, string password, ES3Settings settings)
	{
		return DeleteFile(new ES3Settings(filePath, settings), user, password);
	}

	private IEnumerator DeleteFile(ES3Settings settings, string user, string password)
	{
		Reset();
		WWWForm val = CreateWWWForm();
		val.AddField("apiKey", apiKey);
		val.AddField("deleteFile", settings.path);
		val.AddField("user", GetUser(user, password));
		UnityWebRequest webRequest = UnityWebRequest.Post(url, val);
		try
		{
			webRequest.timeout = timeout;
			yield return SendWebRequest(webRequest);
			HandleError(webRequest, errorIfDataIsDownloaded: true);
		}
		finally
		{
			((IDisposable)webRequest)?.Dispose();
		}
		isDone = true;
	}

	public IEnumerator RenameFile(string filePath, string newFilePath)
	{
		return RenameFile(new ES3Settings(filePath), new ES3Settings(newFilePath), "", "");
	}

	public IEnumerator RenameFile(string filePath, string newFilePath, string user)
	{
		return RenameFile(new ES3Settings(filePath), new ES3Settings(newFilePath), user, "");
	}

	public IEnumerator RenameFile(string filePath, string newFilePath, string user, string password)
	{
		return RenameFile(new ES3Settings(filePath), new ES3Settings(newFilePath), user, password);
	}

	public IEnumerator RenameFile(string filePath, string newFilePath, ES3Settings settings)
	{
		return RenameFile(new ES3Settings(filePath, settings), new ES3Settings(newFilePath, settings), "", "");
	}

	public IEnumerator RenameFile(string filePath, string newFilePath, string user, ES3Settings settings)
	{
		return RenameFile(new ES3Settings(filePath, settings), new ES3Settings(newFilePath, settings), user, "");
	}

	public IEnumerator RenameFile(string filePath, string newFilePath, string user, string password, ES3Settings settings)
	{
		return RenameFile(new ES3Settings(filePath, settings), new ES3Settings(newFilePath, settings), user, password);
	}

	private IEnumerator RenameFile(ES3Settings settings, ES3Settings newSettings, string user, string password)
	{
		Reset();
		WWWForm val = CreateWWWForm();
		val.AddField("apiKey", apiKey);
		val.AddField("renameFile", settings.path);
		val.AddField("newFilename", newSettings.path);
		val.AddField("user", GetUser(user, password));
		UnityWebRequest webRequest = UnityWebRequest.Post(url, val);
		try
		{
			webRequest.timeout = timeout;
			yield return SendWebRequest(webRequest);
			HandleError(webRequest, errorIfDataIsDownloaded: true);
		}
		finally
		{
			((IDisposable)webRequest)?.Dispose();
		}
		isDone = true;
	}

	public IEnumerator DownloadFilenames(string user = "", string password = "")
	{
		Reset();
		WWWForm val = CreateWWWForm();
		val.AddField("apiKey", apiKey);
		val.AddField("getFilenames", "");
		val.AddField("user", GetUser(user, password));
		UnityWebRequest webRequest = UnityWebRequest.Post(url, val);
		try
		{
			webRequest.timeout = timeout;
			yield return SendWebRequest(webRequest);
			if (!HandleError(webRequest, errorIfDataIsDownloaded: false))
			{
				_data = webRequest.downloadHandler.data;
			}
		}
		finally
		{
			((IDisposable)webRequest)?.Dispose();
		}
		isDone = true;
	}

	public IEnumerator SearchFilenames(string searchPattern, string user = "", string password = "")
	{
		Reset();
		WWWForm val = CreateWWWForm();
		val.AddField("apiKey", apiKey);
		val.AddField("getFilenames", "");
		val.AddField("user", GetUser(user, password));
		if (!string.IsNullOrEmpty(searchPattern))
		{
			val.AddField("pattern", searchPattern);
		}
		UnityWebRequest webRequest = UnityWebRequest.Post(url, val);
		try
		{
			webRequest.timeout = timeout;
			yield return SendWebRequest(webRequest);
			if (!HandleError(webRequest, errorIfDataIsDownloaded: false))
			{
				_data = webRequest.downloadHandler.data;
			}
		}
		finally
		{
			((IDisposable)webRequest)?.Dispose();
		}
		isDone = true;
	}

	public IEnumerator DownloadTimestamp()
	{
		return DownloadTimestamp(new ES3Settings(), "", "");
	}

	public IEnumerator DownloadTimestamp(string filePath)
	{
		return DownloadTimestamp(new ES3Settings(filePath), "", "");
	}

	public IEnumerator DownloadTimestamp(string filePath, string user)
	{
		return DownloadTimestamp(new ES3Settings(filePath), user, "");
	}

	public IEnumerator DownloadTimestamp(string filePath, string user, string password)
	{
		return DownloadTimestamp(new ES3Settings(filePath), user, password);
	}

	public IEnumerator DownloadTimestamp(string filePath, ES3Settings settings)
	{
		return DownloadTimestamp(new ES3Settings(filePath, settings), "", "");
	}

	public IEnumerator DownloadTimestamp(string filePath, string user, ES3Settings settings)
	{
		return DownloadTimestamp(new ES3Settings(filePath, settings), user, "");
	}

	public IEnumerator DownloadTimestamp(string filePath, string user, string password, ES3Settings settings)
	{
		return DownloadTimestamp(new ES3Settings(filePath, settings), user, password);
	}

	private IEnumerator DownloadTimestamp(ES3Settings settings, string user, string password)
	{
		Reset();
		WWWForm val = CreateWWWForm();
		val.AddField("apiKey", apiKey);
		val.AddField("getTimestamp", settings.path);
		val.AddField("user", GetUser(user, password));
		UnityWebRequest webRequest = UnityWebRequest.Post(url, val);
		try
		{
			webRequest.timeout = timeout;
			yield return SendWebRequest(webRequest);
			if (!HandleError(webRequest, errorIfDataIsDownloaded: false))
			{
				_data = webRequest.downloadHandler.data;
			}
		}
		finally
		{
			((IDisposable)webRequest)?.Dispose();
		}
		isDone = true;
	}

	private long DateTimeToUnixTimestamp(DateTime dt)
	{
		return Convert.ToInt64((dt.ToUniversalTime() - new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc)).TotalSeconds);
	}

	private long GetFileTimestamp(ES3Settings settings)
	{
		return DateTimeToUnixTimestamp(ES3.GetTimestamp(settings));
	}

	protected override void Reset()
	{
		_data = null;
		base.Reset();
	}
}
