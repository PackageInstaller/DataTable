using System.Collections.Generic;
using CriWare;
using UnityEngine;

public class CriFsServer : CriMonoBehaviour
{
	private static CriFsServer _instance;

	private List<CriFsRequest> requestList;

	public static CriFsServer instance
	{
		get
		{
			CreateInstance();
			return _instance;
		}
	}

	public int installBufferSize { get; private set; }

	public static void CreateInstance()
	{
		if (_instance == null)
		{
			Common.managerObject.AddComponent<CriFsServer>();
			_instance.installBufferSize = CriFsPlugin.installBufferSize;
		}
	}

	public static void DestroyInstance()
	{
		if (_instance != null)
		{
			Object.Destroy(_instance);
		}
	}

	private void Awake()
	{
		if (_instance == null)
		{
			_instance = this;
			requestList = new List<CriFsRequest>();
			CriFsRequest item = new CriFsRequest();
			requestList.Add(item);
			requestList.RemoveAt(0);
		}
		else
		{
			Object.Destroy(this);
		}
	}

	private void OnDestroy()
	{
		if (!(_instance == this))
		{
			return;
		}
		foreach (CriFsRequest request in requestList)
		{
			request.Dispose();
		}
		_instance = null;
	}

	public override void CriInternalUpdate()
	{
		CriFsInstaller.ExecuteMain();
		if (CriFsWebInstaller.isInitialized)
		{
			CriFsWebInstaller.ExecuteMain();
		}
		for (int i = 0; i < requestList.Count; i++)
		{
			requestList[i].Update();
		}
		for (int j = 0; j < requestList.Count; j++)
		{
			if (requestList[j].isDone || requestList[j].isDisposed)
			{
				requestList.Remove(requestList[j]);
			}
		}
	}

	public override void CriInternalLateUpdate()
	{
	}

	public void AddRequest(CriFsRequest request)
	{
		requestList.Add(request);
	}

	public CriFsLoadFileRequest LoadFile(CriFsBinder binder, string path, CriFsRequest.DoneDelegate doneDelegate, int readUnitSize)
	{
		CriFsLoadFileRequest criFsLoadFileRequest = new CriFsLoadFileRequest(binder, path, doneDelegate, readUnitSize);
		AddRequest(criFsLoadFileRequest);
		return criFsLoadFileRequest;
	}

	public CriFsLoadAssetBundleRequest LoadAssetBundle(CriFsBinder binder, string path, int readUnitSize)
	{
		CriFsLoadAssetBundleRequest criFsLoadAssetBundleRequest = new CriFsLoadAssetBundleRequest(binder, path, readUnitSize);
		AddRequest(criFsLoadAssetBundleRequest);
		return criFsLoadAssetBundleRequest;
	}

	public CriFsInstallRequest Install(CriFsBinder srcBinder, string srcPath, string dstPath, CriFsRequest.DoneDelegate doneDelegate)
	{
		CriFsInstallRequestLegacy criFsInstallRequestLegacy = new CriFsInstallRequestLegacy(srcBinder, srcPath, dstPath, doneDelegate, installBufferSize);
		requestList.Add(criFsInstallRequestLegacy);
		return criFsInstallRequestLegacy;
	}

	public CriFsInstallRequest WebInstall(string srcPath, string dstPath, CriFsRequest.DoneDelegate doneDelegate)
	{
		CriFsWebInstallRequest criFsWebInstallRequest = new CriFsWebInstallRequest(srcPath, dstPath, doneDelegate);
		requestList.Add(criFsWebInstallRequest);
		return criFsWebInstallRequest;
	}

	public CriFsBindRequest BindCpk(CriFsBinder targetBinder, CriFsBinder srcBinder, string path)
	{
		CriFsBindRequest criFsBindRequest = new CriFsBindRequest(CriFsBindRequest.BindType.Cpk, targetBinder, srcBinder, path);
		AddRequest(criFsBindRequest);
		return criFsBindRequest;
	}

	public CriFsBindRequest BindDirectory(CriFsBinder targetBinder, CriFsBinder srcBinder, string path)
	{
		CriFsBindRequest criFsBindRequest = new CriFsBindRequest(CriFsBindRequest.BindType.Directory, targetBinder, srcBinder, path);
		AddRequest(criFsBindRequest);
		return criFsBindRequest;
	}

	public CriFsBindRequest BindFile(CriFsBinder targetBinder, CriFsBinder srcBinder, string path)
	{
		CriFsBindRequest criFsBindRequest = new CriFsBindRequest(CriFsBindRequest.BindType.File, targetBinder, srcBinder, path);
		AddRequest(criFsBindRequest);
		return criFsBindRequest;
	}
}
