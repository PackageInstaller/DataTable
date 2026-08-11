using GameFramework.Runtime;

namespace Ase;

public class DownloadModelChooseViewModel : ViewModelBase
{
	private AsyncResult<int> onComfirm;

	public int Result { get; set; }

	public long DownloadSize { get; set; }

	public IAsyncResult<int> OnComfirm => onComfirm;

	public DownloadModelChooseViewModel()
	{
		onComfirm = new AsyncResult<int>();
	}

	public void Comfirm()
	{
		onComfirm.SetResult(Result);
	}
}
