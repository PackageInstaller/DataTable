using UnityEngine;

public class CriFsLoadAssetBundleRequest : CriFsRequest
{
	private CriFsLoadFileRequest loadFileReq;

	private AssetBundleCreateRequest assetBundleReq;

	public string path { get; private set; }

	public AssetBundle assetBundle { get; private set; }

	public CriFsLoadAssetBundleRequest(CriFsBinder binder, string path, int readUnitSize)
	{
		this.path = path;
		loadFileReq = CriFsUtility.LoadFile(binder, path, readUnitSize);
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Fs);
	}

	public override void Update()
	{
		if (loadFileReq != null)
		{
			if (loadFileReq.isDone)
			{
				if (loadFileReq.error != null)
				{
					base.error = "Error occurred.";
					Done();
				}
				else
				{
					assetBundleReq = AssetBundle.LoadFromMemoryAsync(loadFileReq.bytes);
				}
				loadFileReq.Dispose();
				loadFileReq = null;
			}
		}
		else if (assetBundleReq != null)
		{
			if (assetBundleReq.isDone)
			{
				assetBundle = assetBundleReq.assetBundle;
				Done();
			}
		}
		else
		{
			Done();
		}
	}

	protected override void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (loadFileReq != null)
		{
			loadFileReq.Dispose();
			loadFileReq = null;
		}
	}
}
