namespace System.IO;

internal interface IFileWatcher
{
	void StartDispatching(object fsw);

	void StopDispatching(object fsw);

	void Dispose(object fsw);
}
