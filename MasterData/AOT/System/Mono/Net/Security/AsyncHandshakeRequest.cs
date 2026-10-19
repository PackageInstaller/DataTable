namespace Mono.Net.Security;

internal class AsyncHandshakeRequest : AsyncProtocolRequest
{
	public AsyncHandshakeRequest(MobileAuthenticatedStream parent, bool sync)
		: base(parent, sync)
	{
	}

	protected override AsyncOperationStatus Run(AsyncOperationStatus status)
	{
		return Parent.ProcessHandshake(status, renegotiate: false);
	}
}
