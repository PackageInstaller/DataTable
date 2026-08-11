using System.IO;

namespace ES3Internal;

public class UnbufferedCryptoStream : MemoryStream
{
	private readonly Stream stream;

	private readonly bool isReadStream;

	private string password;

	private int bufferSize;

	private EncryptionAlgorithm alg;

	private bool disposed;

	public UnbufferedCryptoStream(Stream stream, bool isReadStream, string password, int bufferSize, EncryptionAlgorithm alg)
	{
		this.stream = stream;
		this.isReadStream = isReadStream;
		this.password = password;
		this.bufferSize = bufferSize;
		this.alg = alg;
		if (isReadStream)
		{
			alg.Decrypt(stream, this, password, bufferSize);
		}
	}

	protected override void Dispose(bool disposing)
	{
		if (!disposed)
		{
			disposed = true;
			if (!isReadStream)
			{
				alg.Encrypt(this, stream, password, bufferSize);
			}
			stream.Dispose();
			base.Dispose(disposing);
		}
	}
}
