using System.IO;
using System.Net.Mime;
using System.Text;

namespace System.Net.Mail;

public class Attachment : AttachmentBase
{
	private ContentDisposition contentDisposition = new ContentDisposition();

	private Encoding nameEncoding;

	public ContentDisposition ContentDisposition => contentDisposition;

	public string Name
	{
		get
		{
			return base.ContentType.Name;
		}
		set
		{
			base.ContentType.Name = value;
		}
	}

	public Encoding NameEncoding => nameEncoding;

	public Attachment(Stream contentStream, string name, string mediaType)
		: base(contentStream, mediaType)
	{
		Name = name;
	}

	public static Attachment CreateAttachmentFromString(string content, string name, Encoding contentEncoding, string mediaType)
	{
		if (content == null)
		{
			throw new ArgumentNullException("content");
		}
		MemoryStream memoryStream = new MemoryStream();
		StreamWriter streamWriter = new StreamWriter(memoryStream, contentEncoding);
		streamWriter.Write(content);
		streamWriter.Flush();
		memoryStream.Position = 0L;
		Attachment attachment = new Attachment(memoryStream, name, mediaType);
		attachment.TransferEncoding = MailMessage.GuessTransferEncoding(contentEncoding);
		attachment.ContentType.CharSet = streamWriter.Encoding.BodyName;
		return attachment;
	}
}
