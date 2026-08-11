using GameFramework.Runtime;

namespace Ase;

public class ProgressBar : ViewModelBase
{
	private float progress;

	private string tip;

	private bool enable;

	private bool enableDownload;

	private int currentDownloadCount;

	private int totalDownloadCount;

	private long currentDownloadBytes;

	private long totalDownloadBytes;

	public bool Enable
	{
		get
		{
			return enable;
		}
		set
		{
			Set(ref enable, value, "Enable");
		}
	}

	public bool EnableDownload
	{
		get
		{
			return enableDownload;
		}
		set
		{
			Set(ref enableDownload, value, "EnableDownload");
		}
	}

	public float Progress
	{
		get
		{
			return progress;
		}
		set
		{
			Set(ref progress, value, "Progress");
		}
	}

	public string Tip
	{
		get
		{
			return tip;
		}
		set
		{
			Set(ref tip, value, "Tip");
		}
	}

	public int CurrentDownloadCount
	{
		get
		{
			return currentDownloadCount;
		}
		set
		{
			Set(ref currentDownloadCount, value, "CurrentDownloadCount");
		}
	}

	public int TotalDownloadCount
	{
		get
		{
			return totalDownloadCount;
		}
		set
		{
			Set(ref totalDownloadCount, value, "TotalDownloadCount");
		}
	}

	public long CurrentDownloadBytes
	{
		get
		{
			return currentDownloadBytes;
		}
		set
		{
			Set(ref currentDownloadBytes, value, "CurrentDownloadBytes");
		}
	}

	public long TotalDownloadBytes
	{
		get
		{
			return totalDownloadBytes;
		}
		set
		{
			Set(ref totalDownloadBytes, value, "TotalDownloadBytes");
		}
	}
}
