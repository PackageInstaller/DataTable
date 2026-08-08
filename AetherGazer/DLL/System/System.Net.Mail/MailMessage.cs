using System.Collections.Specialized;
using System.Net.Mime;
using System.Runtime.CompilerServices;
using System.Text;

namespace System.Net.Mail;

public class MailMessage : IDisposable
{
	private AlternateViewCollection alternateViews;

	private AttachmentCollection attachments;

	private MailAddressCollection bcc;

	private MailAddressCollection replyTo;

	private string body;

	private MailPriority priority;

	private MailAddress sender;

	private MailAddressCollection cc;

	private MailAddress from;

	private NameValueCollection headers;

	private MailAddressCollection to;

	private string subject;

	private Encoding subjectEncoding;

	private Encoding bodyEncoding;

	private Encoding headersEncoding = Encoding.UTF8;

	private bool isHtml;

	private static char[] hex;

	private static Encoding utf8unmarked;

	public AlternateViewCollection AlternateViews => alternateViews;

	public AttachmentCollection Attachments => attachments;

	public MailAddressCollection Bcc => bcc;

	public string Body
	{
		get
		{
			return body;
		}
		set
		{
			if (value != null && bodyEncoding == null)
			{
				bodyEncoding = GuessEncoding(value) ?? Encoding.ASCII;
			}
			body = value;
		}
	}

	internal ContentType BodyContentType => new ContentType(isHtml ? "text/html" : "text/plain")
	{
		CharSet = (BodyEncoding ?? Encoding.ASCII).HeaderName
	};

	internal TransferEncoding ContentTransferEncoding => GuessTransferEncoding(BodyEncoding);

	public Encoding BodyEncoding
	{
		get
		{
			return bodyEncoding;
		}
		set
		{
			bodyEncoding = value;
		}
	}

	public MailAddressCollection CC => cc;

	public MailAddress From
	{
		get
		{
			return from;
		}
		set
		{
			from = value;
		}
	}

	public NameValueCollection Headers => headers;

	public bool IsBodyHtml
	{
		get
		{
			return isHtml;
		}
		set
		{
			isHtml = value;
		}
	}

	public MailPriority Priority
	{
		get
		{
			return priority;
		}
		set
		{
			priority = value;
		}
	}

	public Encoding HeadersEncoding => headersEncoding;

	public MailAddressCollection ReplyToList => replyTo;

	public MailAddress Sender => sender;

	public string Subject
	{
		get
		{
			return subject;
		}
		set
		{
			if (value != null && subjectEncoding == null)
			{
				subjectEncoding = GuessEncoding(value);
			}
			subject = value;
		}
	}

	public Encoding SubjectEncoding => subjectEncoding;

	public MailAddressCollection To => to;

	private static Encoding UTF8Unmarked
	{
		get
		{
			if (utf8unmarked == null)
			{
				utf8unmarked = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false);
			}
			return utf8unmarked;
		}
	}

	public MailMessage()
	{
		to = new MailAddressCollection();
		alternateViews = new AlternateViewCollection();
		attachments = new AttachmentCollection();
		bcc = new MailAddressCollection();
		cc = new MailAddressCollection();
		replyTo = new MailAddressCollection();
		headers = new NameValueCollection();
		headers.Add("MIME-Version", "1.0");
	}

	public void Dispose()
	{
		Dispose(disposing: true);
		GC.SuppressFinalize(this);
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	private Encoding GuessEncoding(string s)
	{
		for (int i = 0; i < s.Length; i++)
		{
			if (s[i] >= '\u0080')
			{
				return UTF8Unmarked;
			}
		}
		return null;
	}

	internal static TransferEncoding GuessTransferEncoding(Encoding enc)
	{
		if (Encoding.ASCII.Equals(enc))
		{
			return TransferEncoding.SevenBit;
		}
		if (Encoding.UTF8.CodePage == enc.CodePage || Encoding.Unicode.CodePage == enc.CodePage)
		{
			return TransferEncoding.Base64;
		}
		return TransferEncoding.QuotedPrintable;
	}

	internal static string To2047(byte[] bytes)
	{
		StringBuilder stringBuilder = new StringBuilder();
		foreach (byte b in bytes)
		{
			if (b < 33 || b > 126 || b == 63 || b == 61 || b == 95)
			{
				stringBuilder.Append('=');
				stringBuilder.Append(hex[(b >> 4) & 0xF]);
				stringBuilder.Append(hex[b & 0xF]);
			}
			else
			{
				stringBuilder.Append((char)b);
			}
		}
		return stringBuilder.ToString();
	}

	internal static string EncodeSubjectRFC2047(string s, Encoding enc)
	{
		if (s == null || Encoding.ASCII.Equals(enc))
		{
			return s;
		}
		for (int i = 0; i < s.Length; i++)
		{
			if (s[i] >= '\u0080')
			{
				string text = To2047(enc.GetBytes(s));
				return "=?" + enc.HeaderName + "?Q?" + text + "?=";
			}
		}
		return s;
	}

	static MailMessage()
	{
		//IL_000d: Field data (rva=0x708) could not be found in any section!
		//IL_000d: Field data (rva=0x708) could not be found in any section!
		char[] array = new char[16];
		RuntimeHelpers.InitializeArray(array, (RuntimeFieldHandle)/*OpCode not supported: LdMemberToken*/);
		hex = array;
	}
}
