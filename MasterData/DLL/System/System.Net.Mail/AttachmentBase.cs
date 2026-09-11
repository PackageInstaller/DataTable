using System.IO;
using System.Net.Mime;

namespace System.Net.Mail;

public abstract class AttachmentBase : IDisposable
{
	private string id;

	private ContentType contentType = new ContentType();

	private Stream contentStream;

	private TransferEncoding transferEncoding = TransferEncoding.Base64;

	public string ContentId => id;

	public Stream ContentStream => contentStream;

	public ContentType ContentType => contentType;

	public TransferEncoding TransferEncoding
	{
		get
		{
			return transferEncoding;
		}
		set
		{
			transferEncoding = value;
		}
	}

	protected AttachmentBase(Stream contentStream, ContentType contentType)
	{
		if (contentStream == null || contentType == null)
		{
			throw new ArgumentNullException();
		}
		this.contentStream = contentStream;
		this.contentType = contentType;
	}

	protected AttachmentBase(Stream contentStream, string mediaType)
	{
		if (contentStream == null)
		{
			throw new ArgumentNullException();
		}
		this.contentStream = contentStream;
		contentType.MediaType = mediaType;
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}

	protected virtual void Dispose(bool disposing)
	{
		if (disposing)
		{
			contentStream.Close();
		}
	}
}
