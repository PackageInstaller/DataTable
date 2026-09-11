public class CriFsInstallRequestLegacy : CriFsInstallRequest
{
	private CriFsInstaller installer;

	public override void Stop()
	{
		if (installer != null)
		{
			installer.Stop();
		}
	}

	public CriFsInstallRequestLegacy(CriFsBinder srcBinder, string srcPath, string dstPath, DoneDelegate doneDelegate, int installBufferSize)
	{
		base.sourcePath = srcPath;
		base.destinationPath = dstPath;
		base.doneDelegate = doneDelegate;
		base.progress = 0f;
		installer = new CriFsInstaller();
		installer.Copy(srcBinder, srcPath, dstPath, installBufferSize);
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Fs);
	}

	public override void Update()
	{
		if (installer != null)
		{
			base.progress = installer.GetProgress();
			switch (installer.GetStatus())
			{
			case CriFsInstaller.Status.Busy:
				return;
			case CriFsInstaller.Status.Error:
				base.progress = -1f;
				base.error = "Error occurred.";
				break;
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
