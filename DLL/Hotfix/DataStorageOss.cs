#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading;
using Aliyun.OSS;
using Aliyun.OSS.Common;
using Aliyun.OSS.Model;
using GameFramework;

public class DataStorageOss
{
	public const string AccessKeyId = "LTAI5tBSaGoSnu5eEhheKEvw";

	public const string AccessKeySecret = "02tlvc6dKF8e00hJd5nbW4vT1EEWdF";

	public const string EndPoint = "oss-cn-hangzhou.aliyuncs.com";

	public const int MaxConnectNumber = 10000;

	private Action<List<string>> _asyncListCallBack;

	private Action<OssObject> _asyncDownLoadCallBack;

	private OssClient _ossClient;

	private AutoResetEvent _event;

	public DataStorageOss()
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Expected O, but got Unknown
		//IL_0027: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Expected O, but got Unknown
		base._002Ector();
		try
		{
			ClientConfiguration val = new ClientConfiguration();
			ClientConfiguration.ConnectionLimit = 10000;
			_ossClient = new OssClient("oss-cn-hangzhou.aliyuncs.com", "LTAI5tBSaGoSnu5eEhheKEvw", "02tlvc6dKF8e00hJd5nbW4vT1EEWdF", val);
			_event = new AutoResetEvent(initialState: false);
		}
		catch (Exception)
		{
		}
	}

	public void PutObject(string objectName, string localFileName, string bucketName)
	{
		try
		{
			_ossClient.PutObject(bucketName, objectName, localFileName);
		}
		catch (Exception)
		{
			Log.Error("上传文件失败");
		}
	}

	public void AsyncPutObject(string bucketName, string objectName, byte[] data)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Expected O, but got Unknown
		try
		{
			ObjectMetadata val = new ObjectMetadata();
			val.ContentType = "text/txt";
			string text = "Notice user: put object finish";
			MemoryStream memoryStream = new MemoryStream(data);
			_ossClient.BeginPutObject(bucketName, objectName, (Stream)memoryStream, val, (AsyncCallback)PutObjectCallback, (object)text.ToCharArray());
			_event.WaitOne();
		}
		catch (OssException)
		{
		}
		catch (Exception)
		{
		}
	}

	private void PutObjectCallback(IAsyncResult ar)
	{
		try
		{
			_ossClient.EndPutObject(ar);
		}
		catch (Exception)
		{
		}
		finally
		{
			_event.Set();
		}
	}

	public void GetObject(string objectName, string downloadFileName, string bucketName)
	{
		try
		{
			using Stream stream = _ossClient.GetObject(bucketName, objectName).Content;
			byte[] buffer = new byte[1024];
			FileStream fileStream = File.Open(downloadFileName, FileMode.OpenOrCreate);
			int num = 0;
			while ((num = stream.Read(buffer, 0, 1024)) != 0)
			{
				fileStream.Write(buffer, 0, num);
			}
			fileStream.Close();
		}
		catch (Exception ex)
		{
			Log.Error("Get object failed. " + ex.Message);
		}
	}

	public byte[] GetObject(string objectName, string bucketName)
	{
		try
		{
			OssObject val = _ossClient.GetObject(bucketName, objectName);
			using Stream stream = val.Content;
			int num = 1024;
			byte[] array = new byte[((GenericResult)val).ContentLength];
			int num2 = 0;
			long num3 = ((GenericResult)val).ContentLength;
			int num4 = 0;
			do
			{
				num4 = ((num3 > num) ? stream.Read(array, num2, num) : stream.Read(array, num2, (int)num3));
				num2 += num4;
				num3 -= num4;
			}
			while (num3 > 0);
			return array;
		}
		catch (Exception ex)
		{
			Log.Error("下载文件失败! " + ex.Message);
			return null;
		}
	}

	public void AsyncGetObject(string bucketName, string downloadPath, Action<OssObject> downloadCallBack)
	{
		_asyncDownLoadCallBack = downloadCallBack;
		try
		{
			_ossClient.BeginGetObject(bucketName, "AsyncGetObject", (AsyncCallback)GetObjectCallback, (object)null);
			_event.WaitOne();
		}
		catch (OssException)
		{
		}
		catch (Exception)
		{
		}
	}

	private void GetObjectCallback(IAsyncResult ar)
	{
		try
		{
			OssObject obj = _ossClient.EndGetObject(ar);
			_asyncDownLoadCallBack?.Invoke(obj);
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message);
		}
		finally
		{
			_event.Set();
		}
	}

	public void AsyncListObjects(string bucketName, Action<List<string>> fileKeyList)
	{
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Expected O, but got Unknown
		try
		{
			List<string> list = new List<string>();
			string text = null;
			do
			{
				ListObjectsRequest val = new ListObjectsRequest(bucketName)
				{
					Marker = text,
					MaxKeys = 1000
				};
				ObjectListing val2 = _ossClient.ListObjects(val);
				foreach (OssObjectSummary objectSummary in val2.ObjectSummaries)
				{
					list.Add(objectSummary.Key);
				}
				text = val2.NextMarker;
			}
			while (!string.IsNullOrEmpty(text));
			fileKeyList?.Invoke(list);
			_event.WaitOne(0);
		}
		catch (OssException)
		{
		}
	}

	private void ListObjectCallback(IAsyncResult ar)
	{
		try
		{
			List<string> list = new List<string>();
			foreach (OssObjectSummary objectSummary in _ossClient.EndListObjects(ar).ObjectSummaries)
			{
				list.Add(objectSummary.Key);
			}
			_asyncListCallBack?.Invoke(list);
		}
		catch (OssException)
		{
		}
		catch (Exception)
		{
		}
		finally
		{
			_event.Set();
		}
	}

	public void Del(string bucketName, List<string> keys)
	{
		//IL_0003: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Expected O, but got Unknown
		try
		{
			DeleteObjectsRequest val = new DeleteObjectsRequest(bucketName, (IList<string>)keys, false);
			DeleteObjectsResult val2 = _ossClient.DeleteObjects(val);
			if (val2.Keys != null)
			{
				DeletedObject[] keys2 = val2.Keys;
				for (int i = 0; i < keys2.Length; i++)
				{
					_ = keys2[i];
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error("Delete objects failed. " + ex.Message);
		}
	}
}
