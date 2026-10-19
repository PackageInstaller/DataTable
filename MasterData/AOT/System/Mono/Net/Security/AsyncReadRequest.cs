namespace Mono.Net.Security;

internal class AsyncReadRequest : AsyncReadOrWriteRequest
{
	public AsyncReadRequest(MobileAuthenticatedStream parent, bool sync, byte[] buffer, int offset, int size)
		: base(parent, sync, buffer, offset, size)
	{
	}

	protected override AsyncOperationStatus Run(AsyncOperationStatus status)
	{
		var (num, flag) = Parent.ProcessRead(UserBuffer);
		if (num < 0)
		{
			UserResult = -1;
			return AsyncOperationStatus.Complete;
		}
		CurrentSize += num;
		UserBuffer.Offset += num;
		UserBuffer.Size -= num;
		if (flag && CurrentSize == 0)
		{
			return AsyncOperationStatus.Continue;
		}
		UserResult = CurrentSize;
		return AsyncOperationStatus.Complete;
	}
}
