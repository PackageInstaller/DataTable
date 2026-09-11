using System.IO;
using System.IO.Compression;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal class ContentDecodeStream : WebReadStream
{
	internal enum Mode
	{
		GZip,
		Deflate
	}

	private Stream OriginalInnerStream { get; }

	public static ContentDecodeStream Create(WebOperation operation, Stream innerStream, Mode mode)
	{
		Stream decodeStream = ((mode != Mode.GZip) ? ((Stream)new DeflateStream(innerStream, CompressionMode.Decompress)) : ((Stream)new GZipStream(innerStream, CompressionMode.Decompress)));
		return new ContentDecodeStream(operation, decodeStream, innerStream);
	}

	private ContentDecodeStream(WebOperation operation, Stream decodeStream, Stream originalInnerStream)
		: base(operation, decodeStream)
	{
		OriginalInnerStream = originalInnerStream;
	}

	protected override Task<int> ProcessReadAsync(byte[] buffer, int offset, int size, CancellationToken cancellationToken)
	{
		return base.InnerStream.ReadAsync(buffer, offset, size, cancellationToken);
	}

	internal override Task FinishReading(CancellationToken cancellationToken)
	{
		if (OriginalInnerStream is WebReadStream webReadStream)
		{
			return webReadStream.FinishReading(cancellationToken);
		}
		return Task.CompletedTask;
	}
}
