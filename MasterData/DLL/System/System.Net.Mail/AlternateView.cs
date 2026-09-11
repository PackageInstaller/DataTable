using System.IO;
using System.Net.Mime;
using System.Text;

namespace System.Net.Mail;

public class AlternateView(Stream contentStream, ContentType contentType) : AttachmentBase(contentStream, contentType)
{
	private LinkedResourceCollection linkedResources = new LinkedResourceCollection();

	public LinkedResourceCollection LinkedResources => linkedResources;

	public static AlternateView CreateAlternateViewFromString(string content, Encoding contentEncoding, string mediaType)
	{
		if (content == null)
		{
			throw new ArgumentNullException("content");
		}
		if (contentEncoding == null)
		{
			contentEncoding = Encoding.UTF8;
		}
		return new AlternateView(new MemoryStream(contentEncoding.GetBytes(content)), new ContentType
		{
			MediaType = mediaType,
			CharSet = contentEncoding.HeaderName
		})
		{
			TransferEncoding = TransferEncoding.QuotedPrintable
		};
	}

	protected override void Dispose(bool disposing)
	{
		if (disposing)
		{
			foreach (LinkedResource linkedResource in linkedResources)
			{
				linkedResource.Dispose();
			}
		}
		base.Dispose(disposing);
	}
}
