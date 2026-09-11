using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal class FixedSizeReadStream : WebReadStream
{
	private long position;

	public long ContentLength { get; }

	public FixedSizeReadStream(WebOperation operation, Stream innerStream, long contentLength)
		: base(operation, innerStream)
	{
		ContentLength = contentLength;
	}

	protected override async Task<int> ProcessReadAsync(byte[] buffer, int offset, int size, CancellationToken cancellationToken)
	{
		cancellationToken.ThrowIfCancellationRequested();
		long num = ContentLength - position;
		if (num == 0L)
		{
			return 0;
		}
		int count = (int)Math.Min(num, size);
		int num2 = await base.InnerStream.ReadAsync(buffer, offset, count, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		if (num2 <= 0)
		{
			return num2;
		}
		position += num2;
		return num2;
	}
}
