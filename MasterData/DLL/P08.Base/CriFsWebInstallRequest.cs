using System.IO;

public class CriFsWebInstallRequest : CriFsInstallRequest
{
	private CriFsWebInstaller installer;

	private uint crc32;

	private bool crc32_set;

	public override void Stop()
	{
		if (installer != null)
		{
			installer.Stop();
		}
	}

	public bool GetCRC32(out uint ret_val)
	{
		ret_val = crc32;
		return crc32_set;
	}

	public CriFsWebInstallRequest(string srcPath, string dstPath, DoneDelegate doneDelegate)
	{
		File.Delete(dstPath);
		base.sourcePath = srcPath;
		base.destinationPath = dstPath;
		base.doneDelegate = doneDelegate;
		base.progress = 0f;
		installer = new CriFsWebInstaller();
		installer.Copy(srcPath, dstPath);
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Fs);
	}

	public override void Update()
	{
		if (installer == null)
		{
			return;
		}
		CriFsWebInstaller.StatusInfo statusInfo = installer.GetStatusInfo();
		base.progress = (float)statusInfo.receivedSize / (float)((statusInfo.contentsSize > 0) ? statusInfo.contentsSize : 1);
		if (statusInfo.status != CriFsWebInstaller.Status.Busy)
		{
			if (statusInfo.status == CriFsWebInstaller.Status.Error)
			{
				base.progress = -1f;
				base.error = "[CriFsWebInstallerError]" + statusInfo.error;
			}
			if (CriFsWebInstaller.isCrcEnabled && statusInfo.status == CriFsWebInstaller.Status.Complete)
			{
				crc32_set = installer.GetCRC32(out crc32);
			}
			installer.Dispose();
			installer = null;
			Done();
		}
	}

	protected override void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (installer != null)
		{
			installer.Dispose();
			installer = null;
		}
	}
}
