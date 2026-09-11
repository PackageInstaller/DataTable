public class CriFsLoadFileRequest : CriFsRequest
{
	private enum Phase
	{
		Stop,
		Bind,
		Load,
		Done,
		Error
	}

	private Phase phase;

	private CriFsBinder refBinder;

	private CriFsBinder newBinder;

	private uint bindId;

	private CriFsLoader loader;

	private int readUnitSize;

	private long fileSize;

	public string path { get; private set; }

	public byte[] bytes { get; private set; }

	public CriFsLoadFileRequest(CriFsBinder srcBinder, string path, DoneDelegate doneDelegate, int readUnitSize)
	{
		this.path = path;
		base.doneDelegate = doneDelegate;
		this.readUnitSize = readUnitSize;
		if (srcBinder == null)
		{
			newBinder = new CriFsBinder();
			refBinder = newBinder;
			bindId = newBinder.BindFile(srcBinder, path);
			phase = Phase.Bind;
		}
		else
		{
			newBinder = null;
			refBinder = srcBinder;
			fileSize = srcBinder.GetFileSize(path);
			if (fileSize < 0)
			{
				phase = Phase.Error;
			}
			else
			{
				phase = Phase.Load;
			}
		}
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Fs);
	}

	protected override void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
		if (loader != null)
		{
			loader.Dispose();
			loader = null;
		}
		if (newBinder != null)
		{
			newBinder.Dispose();
			newBinder = null;
		}
		bytes = null;
	}

	public override void Stop()
	{
		if (phase == Phase.Load && loader != null)
		{
			loader.Stop();
		}
	}

	public override void Update()
	{
		if (phase == Phase.Bind)
		{
			UpdateBinder();
		}
		if (phase == Phase.Load)
		{
			UpdateLoader();
		}
		if (phase == Phase.Error)
		{
			OnError();
		}
	}

	private void UpdateBinder()
	{
		switch (CriFsBinder.GetStatus(bindId))
		{
		case CriFsBinder.Status.Analyze:
			return;
		case CriFsBinder.Status.Complete:
			fileSize = refBinder.GetFileSize(path);
			break;
		default:
			fileSize = -1L;
			break;
		}
		if (fileSize < 0)
		{
			phase = Phase.Error;
		}
		else
		{
			phase = Phase.Load;
		}
	}

	private void UpdateLoader()
	{
		if (loader == null)
		{
			loader = new CriFsLoader();
			loader.SetReadUnitSize(readUnitSize);
			bytes = new byte[fileSize];
			loader.Load(refBinder, path, 0L, fileSize, bytes);
		}
		switch (loader.GetStatus())
		{
		case CriFsLoader.Status.Loading:
			return;
		case CriFsLoader.Status.Stop:
			bytes = null;
			break;
		case CriFsLoader.Status.Error:
			phase = Phase.Error;
			return;
		}
		phase = Phase.Done;
		loader.Dispose();
		loader = null;
		if (newBinder != null)
		{
			newBinder.Dispose();
			newBinder = null;
		}
		Done();
	}

	private void OnError()
	{
		bytes = null;
		base.error = "Error occurred.";
		refBinder = null;
		if (newBinder != null)
		{
			newBinder.Dispose();
			newBinder = null;
		}
		if (loader != null)
		{
			loader.Dispose();
			loader = null;
		}
		phase = Phase.Done;
		Done();
	}
}
