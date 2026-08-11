using System.IO;
using System.Runtime.CompilerServices;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal class MonoChunkStream : WebReadStream
{
	[CompilerGenerated]
	private readonly WebHeaderCollection _003CHeaders_003Ek__BackingField;

	protected MonoChunkParser Decoder { get; }

	public MonoChunkStream(WebOperation operation, Stream innerStream, WebHeaderCollection headers)
		: base(operation, innerStream)
	{
		_003CHeaders_003Ek__BackingField = headers;
		Decoder = new MonoChunkParser(headers);
	}

	protected override async Task<int> ProcessReadAsync(byte[] buffer, int offset, int size, CancellationToken cancellationToken)
	{
		cancellationToken.ThrowIfCancellationRequested();
		if (Decoder.DataAvailable)
		{
			return Decoder.Read(buffer, offset, size);
		}
		int num = 0;
		byte[] moreBytes = null;
		while (num == 0 && Decoder.WantMore)
		{
			int num2 = Decoder.ChunkLeft;
			if (num2 <= 0)
			{
				num2 = 1024;
			}
			else if (num2 > 16384)
			{
				num2 = 16384;
			}
			if (moreBytes == null || moreBytes.Length < num2)
			{
				moreBytes = new byte[num2];
			}
			num = await base.InnerStream.ReadAsync(moreBytes, 0, num2, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			if (num <= 0)
			{
				return num;
			}
			Decoder.Write(moreBytes, 0, num);
			num = Decoder.Read(buffer, offset, size);
		}
		return num;
	}

	internal override async Task FinishReading(CancellationToken cancellationToken)
	{
		await base.FinishReading(cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
		cancellationToken.ThrowIfCancellationRequested();
		if (Decoder.DataAvailable)
		{
			ThrowExpectingChunkTrailer();
		}
		while (Decoder.WantMore)
		{
			byte[] buffer = new byte[256];
			int num = await base.InnerStream.ReadAsync(buffer, 0, buffer.Length, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
			if (num <= 0)
			{
				ThrowExpectingChunkTrailer();
			}
			Decoder.Write(buffer, 0, num);
			if (Decoder.Read(buffer, 0, 1) != 0)
			{
				ThrowExpectingChunkTrailer();
			}
		}
	}

	private static void ThrowExpectingChunkTrailer()
	{
		throw new WebException("Expecting chunk trailer.", null, WebExceptionStatus.ServerProtocolViolation, null);
	}
}
