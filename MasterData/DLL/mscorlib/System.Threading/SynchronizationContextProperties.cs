namespace System.Threading;

[Flags]
internal enum SynchronizationContextProperties
{
	None = 0,
	RequireWaitNotification = 1
}
