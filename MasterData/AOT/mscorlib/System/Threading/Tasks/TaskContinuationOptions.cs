namespace System.Threading.Tasks;

[Flags]
public enum TaskContinuationOptions
{
	None = 0,
	PreferFairness = 1,
	LongRunning = 2,
	AttachedToParent = 4,
	DenyChildAttach = 8,
	HideScheduler = 0x10,
	LazyCancellation = 0x20,
	RunContinuationsAsynchronously = 0x40,
	NotOnRanToCompletion = 0x10000,
	NotOnFaulted = 0x20000,
	NotOnCanceled = 0x40000,
	OnlyOnRanToCompletion = NotOnFaulted | NotOnCanceled,
	OnlyOnFaulted = NotOnRanToCompletion | NotOnCanceled,
	OnlyOnCanceled = NotOnRanToCompletion | NotOnFaulted,
	ExecuteSynchronously = 0x80000
}
