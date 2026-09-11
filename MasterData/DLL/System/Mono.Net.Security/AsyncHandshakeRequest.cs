namespace Mono.Net.Security;

internal class AsyncHandshakeRequest : AsyncProtocolRequest
{
	public AsyncHandshakeRequest(MobileAuthenticatedStream parent, bool sync)
		: base(parent, sync)
	{
	}

	protected override AsyncOperationStatus Run(AsyncOperationStatus status)
	{
		return base.Parent.ProcessHandshake(status, renegotiate: false);
	}
}
