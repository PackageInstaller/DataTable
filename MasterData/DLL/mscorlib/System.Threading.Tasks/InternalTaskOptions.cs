namespace System.Threading.Tasks;

[Flags]
internal enum InternalTaskOptions
{
	None = 0,
	InternalOptionsMask = 0xFF00,
	ContinuationTask = 0x200,
	PromiseTask = 0x400,
	LazyCancellation = 0x1000,
	QueuedByRuntime = 0x2000,
	DoNotDispose = 0x4000
}
