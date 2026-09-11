using System;
using System.IO;
using System.Security.Cryptography;
using System.Text;
using UnityEngine;
using UnityEngine.Networking;

public class WWWDownloadHandler : DownloadHandlerScript
{
	protected FileStream fileStream;

	protected ulong localFileSize;

	protected string localFilePath;

	private UnityWebRequest request;

	protected ulong totalFileSize;

	private MD5 md5;

	private string IOError = string.Empty;

	private static string filePath = Platform.GetDownloadPersistentDataPath() + "file_download_status.txt";

	public ulong LocalFileSize => localFileSize;

	public static string SetDownloadStatusLog(string fileName)
	{
		filePath = Platform.GetDownloadPersistentDataPath() + fileName;
		return filePath;
	}

	public static string GetDownloadStatusLog()
	{
		return filePath;
	}

	public void Clean()
	{
		if (fileStream != null)
		{
			fileStream.Dispose();
			fileStream = null;
		}
	}

	~WWWDownloadHandler()
	{
		Clean();
	}

	public WWWDownloadHandler(DownloadRequest wwwRequest, string localFilePath, byte[] buffer)
		: base(buffer)
	{
		request = wwwRequest.GetWWW();
		this.localFilePath = localFilePath;
		md5 = MD5.Create();
		IOError = string.Empty;
		if (File.Exists(localFilePath))
		{
			if (wwwRequest.forceDownload)
			{
				File.Delete(localFilePath);
				localFileSize = 0uL;
			}
			else
			{
				FileInfo fileInfo = new FileInfo(localFilePath);
				localFileSize = (ulong)fileInfo.Length;
			}
		}
		request.SetRequestHeader("Range", "bytes=" + localFileSize + "-");
		request.downloadHandler = this;
		request.certificateHandler = new CustomCertificateHandler();
		request.SendWebRequest();
	}

	public ulong GetTotalSize()
	{
		return totalFileSize;
	}

	protected override void CompleteContent()
	{
		base.CompleteContent();
		Clean();
		if (md5 != null)
		{
			md5.Dispose();
			md5 = null;
		}
	}

	protected override void ReceiveContentLength(int contentLength)
	{
		string responseHeader = request.GetResponseHeader("Content-Length");
		if (!string.IsNullOrEmpty(responseHeader))
		{
			try
			{
				totalFileSize = ulong.Parse(responseHeader);
			}
			catch (FormatException ex)
			{
				Debug.Log("获取文件长度失败,contentLengthStr:" + responseHeader + "," + ex.Message);
				totalFileSize = (ulong)contentLength;
			}
			catch (Exception ex2)
			{
				Debug.Log("获取文件长度失败,contentLengthStr:" + responseHeader + "," + ex2.Message);
				totalFileSize = (ulong)contentLength;
			}
		}
		else
		{
			totalFileSize = (ulong)contentLength;
		}
		totalFileSize += localFileSize;
	}

	protected override bool ReceiveData(byte[] data, int dataLength)
	{
		if (data != null && dataLength > 0 && (request.responseCode == 206 || request.responseCode == 200))
		{
			if (fileStream == null)
			{
				if (localFileSize != 0)
				{
					fileStream = new FileStream(localFilePath, FileMode.OpenOrCreate, FileAccess.Write, FileShare.ReadWrite);
					fileStream.Seek((long)localFileSize, SeekOrigin.Current);
				}
				else
				{
					fileStream = new FileStream(localFilePath, FileMode.Create, FileAccess.Write, FileShare.ReadWrite);
				}
			}
			try
			{
				fileStream.Write(data, 0, dataLength);
				fileStream.Flush();
				localFileSize += (ulong)dataLength;
				if (localFileSize >= totalFileSize)
				{
					md5.TransformFinalBlock(data, 0, dataLength);
					Clean();
				}
				else
				{
					md5.TransformBlock(data, 0, dataLength, data, 0);
				}
			}
			catch (Exception ex)
			{
				IOError = ex.ToString();
				Debug.LogError(IOError);
				return false;
			}
			return true;
		}
		if (data != null && dataLength > 0)
		{
			Debug.LogError(Encoding.Default.GetString(data, 0, dataLength));
		}
		return false;
	}

	public string GetIOError()
	{
		return IOError;
	}

	public static string CalcByteHashToString(byte[] bytes)
	{
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < bytes.Length; i++)
		{
			stringBuilder.Append(bytes[i].ToString("x2"));
		}
		return stringBuilder.ToString();
	}
}
