using System;

public class CriFsBindRequest : CriFsRequest
{
	public enum BindType
	{
		Cpk,
		Directory,
		File
	}

	public string path { get; private set; }

	public uint bindId { get; private set; }

	public CriFsBindRequest(BindType type, CriFsBinder targetBinder, CriFsBinder srcBinder, string path)
	{
		this.path = path;
		switch (type)
		{
		case BindType.Cpk:
			bindId = targetBinder.BindCpk(srcBinder, path);
			break;
		case BindType.Directory:
			bindId = targetBinder.BindDirectory(srcBinder, path);
			break;
		case BindType.File:
			bindId = targetBinder.BindFile(srcBinder, path);
			break;
		default:
			throw new Exception("Invalid bind type.");
		}
		CriDisposableObjectManager.Register(this, CriDisposableObjectManager.ModuleType.Fs);
	}

	public override void Stop()
	{
	}

	public override void Update()
	{
		if (!base.isDone)
		{
			switch (CriFsBinder.GetStatus(bindId))
			{
			case CriFsBinder.Status.Analyze:
				return;
			case CriFsBinder.Status.Error:
				base.error = "Error occurred.";
				break;
			}
			Done();
		}
	}

	protected override void Dispose(bool disposing)
	{
		CriDisposableObjectManager.Unregister(this);
	}
}
