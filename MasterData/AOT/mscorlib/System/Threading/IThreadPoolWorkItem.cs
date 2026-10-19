namespace System.Threading;

internal interface IThreadPoolWorkItem
{
	void ExecuteWorkItem();

	void MarkAborted(ThreadAbortException tae);
}
