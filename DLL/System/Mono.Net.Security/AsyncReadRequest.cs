namespace Mono.Net.Security;

internal class AsyncReadRequest : AsyncReadOrWriteRequest
{
	public AsyncReadRequest(MobileAuthenticatedStream parent, bool sync, byte[] buffer, int offset, int size)
		: base(parent, sync, buffer, offset, size)
	{
	}

	protected override AsyncOperationStatus Run(AsyncOperationStatus status)
	{
		var (num, flag) = base.Parent.ProcessRead(base.UserBuffer);
		if (num < 0)
		{
			base.UserResult = -1;
			return AsyncOperationStatus.Complete;
		}
		base.CurrentSize += num;
		base.UserBuffer.Offset += num;
		base.UserBuffer.Size -= num;
		if (flag && base.CurrentSize == 0)
		{
			return AsyncOperationStatus.Continue;
		}
		base.UserResult = base.CurrentSize;
		return AsyncOperationStatus.Complete;
	}
}
