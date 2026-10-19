namespace Mono.Net.Security;

internal class AsyncWriteRequest : AsyncReadOrWriteRequest
{
	public AsyncWriteRequest(MobileAuthenticatedStream parent, bool sync, byte[] buffer, int offset, int size)
		: base(parent, sync, buffer, offset, size)
	{
	}

	protected override AsyncOperationStatus Run(AsyncOperationStatus status)
	{
		if (UserBuffer.Size == 0)
		{
			UserResult = CurrentSize;
			return AsyncOperationStatus.Complete;
		}
		var (num, flag) = Parent.ProcessWrite(UserBuffer);
		if (num < 0)
		{
			UserResult = -1;
			return AsyncOperationStatus.Complete;
		}
		CurrentSize += num;
		UserBuffer.Offset += num;
		UserBuffer.Size -= num;
		if (flag)
		{
			return AsyncOperationStatus.Continue;
		}
		UserResult = CurrentSize;
		return AsyncOperationStatus.Complete;
	}
}
