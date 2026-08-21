using System.Threading;

namespace GameFramework.Network;

public class RequestTaskTimeoutOrCompletionSource : TaskTimeoutOrCompletionSource<IResponse>
{
	private IRequest request;

	public IRequest Request => request;

	public int RpcId => request.RpcId;

	public RequestTaskTimeoutOrCompletionSource(IRequest request, int timeoutMilliseconds, CancellationToken cancellationToken)
		: base(timeoutMilliseconds, cancellationToken)
	{
		this.request = request;
	}
}
