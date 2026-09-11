namespace Mono.Net.Security;

internal class AsyncWriteRequest : AsyncReadOrWriteRequest
{
	public AsyncWriteRequest(MobileAuthenticatedStream parent, bool sync, byte[] buffer, int offset, int size)
		: base(parent, sync, buffer, offset, size)
	{
	}

	protected override AsyncOperationStatus Run(AsyncOperationStatus status)
	{
		if (base.UserBuffer.Size == 0)
		{
			base.UserResult = base.CurrentSize;
			return AsyncOperationStatus.Complete;
		}
		var (num, flag) = base.Parent.ProcessWrite(base.UserBuffer);
		if (num < 0)
		{
			base.UserResult = -1;
			return AsyncOperationStatus.Complete;
		}
		base.CurrentSize += num;
		base.UserBuffer.Offset += num;
		base.UserBuffer.Size -= num;
		if (flag)
		{
			return AsyncOperationStatus.Continue;
		}
		base.UserResult = base.CurrentSize;
		return AsyncOperationStatus.Complete;
	}
}
