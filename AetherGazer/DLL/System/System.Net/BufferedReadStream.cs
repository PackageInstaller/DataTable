using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal class BufferedReadStream : WebReadStream
{
	private readonly BufferOffsetSize readBuffer;

	public BufferedReadStream(WebOperation operation, Stream innerStream, BufferOffsetSize readBuffer)
		: base(operation, innerStream)
	{
		this.readBuffer = readBuffer;
	}

	protected override async Task<int> ProcessReadAsync(byte[] buffer, int offset, int size, CancellationToken cancellationToken)
	{
		cancellationToken.ThrowIfCancellationRequested();
		int num = readBuffer?.Size ?? 0;
		if (num > 0)
		{
			int num2 = ((num > size) ? size : num);
			Buffer.BlockCopy(readBuffer.Buffer, readBuffer.Offset, buffer, offset, num2);
			readBuffer.Offset += num2;
			readBuffer.Size -= num2;
			offset += num2;
			size -= num2;
			return num2;
		}
		if (base.InnerStream == null)
		{
			return 0;
		}
		return await base.InnerStream.ReadAsync(buffer, offset, size, cancellationToken).ConfigureAwait(continueOnCapturedContext: false);
	}

	internal bool TryReadFromBuffer(byte[] buffer, int offset, int size, out int result)
	{
		int num = readBuffer?.Size ?? 0;
		if (num <= 0)
		{
			result = 0;
			return base.InnerStream == null;
		}
		int num2 = ((num > size) ? size : num);
		Buffer.BlockCopy(readBuffer.Buffer, readBuffer.Offset, buffer, offset, num2);
		readBuffer.Offset += num2;
		readBuffer.Size -= num2;
		offset += num2;
		size -= num2;
		result = num2;
		return true;
	}
}
