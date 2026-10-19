using System.IO;
using System.Threading;
using System.Threading.Tasks;

namespace Google.Protobuf;

internal static class ByteStringAsync
{
	internal static async Task<ByteString> FromStreamAsyncCore(Stream stream, CancellationToken cancellationToken)
	{
		int capacity = (stream.CanSeek ? checked((int)(stream.Length - stream.Position)) : 0);
		MemoryStream memoryStream = new MemoryStream(capacity);
		await stream.CopyToAsync(memoryStream, 81920, cancellationToken);
		return ByteString.AttachBytes((memoryStream.Length == memoryStream.Capacity) ? memoryStream.GetBuffer() : memoryStream.ToArray());
	}
}
