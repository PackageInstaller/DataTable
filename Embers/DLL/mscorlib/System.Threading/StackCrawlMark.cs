namespace System.Threading;

[Serializable]
internal enum StackCrawlMark
{
	LookForMe,
	LookForMyCaller,
	LookForMyCallersCaller,
	LookForThread
}
