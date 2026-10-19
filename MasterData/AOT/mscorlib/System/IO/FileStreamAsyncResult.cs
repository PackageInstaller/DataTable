using System.Threading;

namespace System.IO;

internal class FileStreamAsyncResult : IAsyncResult
{
	private object state;

	private bool completed;

	private ManualResetEvent wh;

	private AsyncCallback cb;

	private bool completedSynch;

	public int Count;

	public int OriginalCount;

	public int BytesRead;

	private AsyncCallback realcb;

	public object AsyncState => state;

	public bool CompletedSynchronously => completedSynch;

	public WaitHandle AsyncWaitHandle => wh;

	public bool IsCompleted => completed;

	public FileStreamAsyncResult(AsyncCallback cb, object state)
	{
		this.state = state;
		realcb = cb;
		if (realcb != null)
		{
			this.cb = CBWrapper;
		}
		wh = new ManualResetEvent(initialState: false);
	}

	private static void CBWrapper(IAsyncResult ares)
	{
		((FileStreamAsyncResult)ares).realcb.BeginInvoke(ares, null, null);
	}
}
