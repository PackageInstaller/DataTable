using System.Collections.Generic;
using System.ComponentModel;
using System.Globalization;
using System.IO;
using System.Net.Mime;
using System.Net.Security;
using System.Net.Sockets;
using System.Security.Authentication;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading;
using Mono.Net.Security;
using Mono.Security.Interface;

namespace System.Net.Mail;

[Obsolete("SmtpClient and its network of types are poorly designed, we strongly recommend you use https://github.com/jstedfast/MailKit and https://github.com/jstedfast/MimeKit instead")]
public class SmtpClient : IDisposable
{
	[Flags]
	private enum AuthMechs
	{
		None = 0,
		Login = 1,
		Plain = 2
	}

	private class CancellationException : Exception
	{
	}

	private struct SmtpResponse
	{
		public SmtpStatusCode StatusCode;

		public string Description;

		public static SmtpResponse Parse(string line)
		{
			SmtpResponse result = default(SmtpResponse);
			if (line.Length < 4)
			{
				throw new SmtpException("Response is to short " + line.Length + ".");
			}
			if (line[3] != ' ' && line[3] != '-')
			{
				throw new SmtpException("Response format is wrong.(" + line + ")");
			}
			result.StatusCode = (SmtpStatusCode)int.Parse(line.Substring(0, 3));
			result.Description = line;
			return result;
		}
	}

	private string host;

	private int port;

	private int timeout = 100000;

	private ICredentialsByHost credentials;

	private string pickupDirectoryLocation;

	private SmtpDeliveryMethod deliveryMethod;

	private bool enableSsl;

	private X509CertificateCollection clientCertificates;

	private TcpClient client;

	private Stream stream;

	private StreamWriter writer;

	private StreamReader reader;

	private int boundaryIndex;

	private MailAddress defaultFrom;

	private MailMessage messageInProcess;

	private BackgroundWorker worker;

	private AuthMechs authMechs;

	private Mutex mutex = new Mutex();

	[System.MonoTODO("Client certificates not used")]
	public X509CertificateCollection ClientCertificates
	{
		get
		{
			if (clientCertificates == null)
			{
				clientCertificates = new X509CertificateCollection();
			}
			return clientCertificates;
		}
	}

	public ICredentialsByHost Credentials
	{
		get
		{
			return credentials;
		}
		set
		{
			CheckState();
			credentials = value;
		}
	}

	public SmtpDeliveryMethod DeliveryMethod
	{
		get
		{
			return deliveryMethod;
		}
		set
		{
			CheckState();
			deliveryMethod = value;
		}
	}

	public bool EnableSsl
	{
		get
		{
			return enableSsl;
		}
		set
		{
			CheckState();
			enableSsl = value;
		}
	}

	public string Host
	{
		get
		{
			return host;
		}
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			if (value.Length == 0)
			{
				throw new ArgumentException("An empty string is not allowed.", "value");
			}
			CheckState();
			host = value;
		}
	}

	public string PickupDirectoryLocation
	{
		get
		{
			return pickupDirectoryLocation;
		}
		set
		{
			pickupDirectoryLocation = value;
		}
	}

	public int Port
	{
		get
		{
			return port;
		}
		set
		{
			if (value <= 0)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			CheckState();
			port = value;
		}
	}

	public int Timeout
	{
		get
		{
			return timeout;
		}
		set
		{
			if (value < 0)
			{
				throw new ArgumentOutOfRangeException("value");
			}
			CheckState();
			timeout = value;
		}
	}

	public bool UseDefaultCredentials => false;

	public SmtpClient()
		: this(null, 0)
	{
	}

	public SmtpClient(string host, int port)
	{
		defaultFrom = null;
		if (!string.IsNullOrEmpty(host))
		{
			this.host = host;
		}
		if (port != 0)
		{
			this.port = port;
		}
		else if (this.port == 0)
		{
			this.port = 25;
		}
	}

	public void Dispose()
	{
		Dispose(disposing: true);
	}

	[System.MonoTODO("Does nothing at the moment.")]
	protected virtual void Dispose(bool disposing)
	{
	}

	private void CheckState()
	{
		if (messageInProcess != null)
		{
			throw new InvalidOperationException("Cannot set Timeout while Sending a message");
		}
	}

	private static string EncodeAddress(MailAddress address)
	{
		if (!string.IsNullOrEmpty(address.DisplayName))
		{
			string text = MailMessage.EncodeSubjectRFC2047(address.DisplayName, Encoding.UTF8);
			return "\"" + text + "\" <" + address.Address + ">";
		}
		return address.ToString();
	}

	private static string EncodeAddresses(MailAddressCollection addresses)
	{
		StringBuilder stringBuilder = new StringBuilder();
		bool flag = true;
		foreach (MailAddress address in addresses)
		{
			if (!flag)
			{
				stringBuilder.Append(", ");
			}
			stringBuilder.Append(EncodeAddress(address));
			flag = false;
		}
		return stringBuilder.ToString();
	}

	private string EncodeSubjectRFC2047(MailMessage message)
	{
		return MailMessage.EncodeSubjectRFC2047(message.Subject, message.SubjectEncoding);
	}

	private string EncodeBody(MailMessage message)
	{
		string body = message.Body;
		Encoding bodyEncoding = message.BodyEncoding;
		return message.ContentTransferEncoding switch
		{
			TransferEncoding.SevenBit => body, 
			TransferEncoding.Base64 => Convert.ToBase64String(bodyEncoding.GetBytes(body), Base64FormattingOptions.InsertLineBreaks), 
			_ => ToQuotedPrintable(body, bodyEncoding), 
		};
	}

	private string EncodeBody(AlternateView av)
	{
		byte[] array = new byte[av.ContentStream.Length];
		av.ContentStream.Read(array, 0, array.Length);
		return av.TransferEncoding switch
		{
			TransferEncoding.SevenBit => Encoding.ASCII.GetString(array), 
			TransferEncoding.Base64 => Convert.ToBase64String(array, Base64FormattingOptions.InsertLineBreaks), 
			_ => ToQuotedPrintable(array), 
		};
	}

	private void EndSection(string section)
	{
		SendData($"--{section}--");
		SendData(string.Empty);
	}

	private string GenerateBoundary()
	{
		string result = GenerateBoundary(boundaryIndex);
		boundaryIndex++;
		return result;
	}

	private static string GenerateBoundary(int index)
	{
		return string.Format("--boundary_{0}_{1}", index, Guid.NewGuid().ToString("D"));
	}

	private bool IsError(SmtpResponse status)
	{
		return status.StatusCode >= (SmtpStatusCode)400;
	}

	private void CheckCancellation()
	{
		if (worker != null && worker.CancellationPending)
		{
			throw new CancellationException();
		}
	}

	private SmtpResponse Read()
	{
		byte[] array = new byte[512];
		int num = 0;
		bool flag = false;
		do
		{
			CheckCancellation();
			int num2 = stream.Read(array, num, array.Length - num);
			if (num2 <= 0)
			{
				break;
			}
			int num3 = num + num2 - 1;
			if (num3 > 4 && (array[num3] == 10 || array[num3] == 13))
			{
				int num4 = num3 - 3;
				while (num4 >= 0 && array[num4] != 10 && array[num4] != 13)
				{
					num4--;
				}
				flag = array[num4 + 4] == 32;
			}
			num += num2;
			if (num == array.Length)
			{
				byte[] array2 = new byte[array.Length * 2];
				Array.Copy(array, 0, array2, 0, array.Length);
				array = array2;
			}
		}
		while (!flag);
		if (num > 0)
		{
			return SmtpResponse.Parse(new ASCIIEncoding().GetString(array, 0, num - 1));
		}
		throw new IOException("Connection closed");
	}

	private void ResetExtensions()
	{
		authMechs = AuthMechs.None;
	}

	private void ParseExtensions(string extens)
	{
		string[] array = extens.Split('\n');
		foreach (string text in array)
		{
			if (text.Length < 4)
			{
				continue;
			}
			string text2 = text.Substring(4);
			if (!text2.StartsWith("AUTH ", StringComparison.Ordinal))
			{
				continue;
			}
			string[] array2 = text2.Split(' ');
			for (int j = 1; j < array2.Length; j++)
			{
				string text3 = array2[j].Trim();
				if (!(text3 == "LOGIN"))
				{
					if (text3 == "PLAIN")
					{
						authMechs |= AuthMechs.Plain;
					}
				}
				else
				{
					authMechs |= AuthMechs.Login;
				}
			}
		}
	}

	public void Send(MailMessage message)
	{
		if (message == null)
		{
			throw new ArgumentNullException("message");
		}
		if (deliveryMethod == SmtpDeliveryMethod.Network && (Host == null || Host.Trim().Length == 0))
		{
			throw new InvalidOperationException("The SMTP host was not specified");
		}
		if (deliveryMethod == SmtpDeliveryMethod.PickupDirectoryFromIis)
		{
			throw new NotSupportedException("IIS delivery is not supported");
		}
		if (port == 0)
		{
			port = 25;
		}
		mutex.WaitOne();
		try
		{
			messageInProcess = message;
			if (deliveryMethod == SmtpDeliveryMethod.SpecifiedPickupDirectory)
			{
				SendToFile(message);
			}
			else
			{
				SendInternal(message);
			}
		}
		catch (CancellationException)
		{
		}
		catch (SmtpException)
		{
			throw;
		}
		catch (Exception innerException)
		{
			throw new SmtpException("Message could not be sent.", innerException);
		}
		finally
		{
			mutex.ReleaseMutex();
			messageInProcess = null;
		}
	}

	private void SendInternal(MailMessage message)
	{
		CheckCancellation();
		try
		{
			client = new TcpClient(host, port);
			stream = client.GetStream();
			writer = new StreamWriter(stream);
			reader = new StreamReader(stream);
			SendCore(message);
		}
		finally
		{
			if (writer != null)
			{
				writer.Close();
			}
			if (reader != null)
			{
				reader.Close();
			}
			if (stream != null)
			{
				stream.Close();
			}
			if (client != null)
			{
				client.Close();
			}
		}
	}

	private void SendToFile(MailMessage message)
	{
		if (!Path.IsPathRooted(pickupDirectoryLocation))
		{
			throw new SmtpException("Only absolute directories are allowed for pickup directory.");
		}
		string path = Path.Combine(pickupDirectoryLocation, Guid.NewGuid().ToString() + ".eml");
		try
		{
			writer = new StreamWriter(path);
			MailAddress mailAddress = message.From;
			if (mailAddress == null)
			{
				mailAddress = defaultFrom;
			}
			string text = DateTime.Now.ToString("ddd, dd MMM yyyy HH':'mm':'ss zzz", DateTimeFormatInfo.InvariantInfo);
			text = text.Remove(text.Length - 3, 1);
			SendHeader("Date", text);
			SendHeader("From", EncodeAddress(mailAddress));
			SendHeader("To", EncodeAddresses(message.To));
			if (message.CC.Count > 0)
			{
				SendHeader("Cc", EncodeAddresses(message.CC));
			}
			SendHeader("Subject", EncodeSubjectRFC2047(message));
			string[] allKeys = message.Headers.AllKeys;
			foreach (string name in allKeys)
			{
				SendHeader(name, message.Headers[name]);
			}
			AddPriorityHeader(message);
			boundaryIndex = 0;
			if (message.Attachments.Count > 0)
			{
				SendWithAttachments(message);
			}
			else
			{
				SendWithoutAttachments(message, null, attachmentExists: false);
			}
		}
		finally
		{
			if (writer != null)
			{
				writer.Close();
			}
			writer = null;
		}
	}

	private void SendCore(MailMessage message)
	{
		SmtpResponse status = Read();
		if (IsError(status))
		{
			throw new SmtpException(status.StatusCode, status.Description);
		}
		string hostName = Dns.GetHostName();
		try
		{
			hostName = Dns.GetHostEntry(hostName).HostName;
		}
		catch (SocketException)
		{
		}
		status = SendCommand("EHLO " + hostName);
		if (IsError(status))
		{
			status = SendCommand("HELO " + hostName);
			if (IsError(status))
			{
				throw new SmtpException(status.StatusCode, status.Description);
			}
		}
		else
		{
			string description = status.Description;
			if (description != null)
			{
				ParseExtensions(description);
			}
		}
		if (enableSsl)
		{
			InitiateSecureConnection();
			ResetExtensions();
			writer = new StreamWriter(stream);
			reader = new StreamReader(stream);
			status = SendCommand("EHLO " + hostName);
			if (IsError(status))
			{
				status = SendCommand("HELO " + hostName);
				if (IsError(status))
				{
					throw new SmtpException(status.StatusCode, status.Description);
				}
			}
			else
			{
				string description2 = status.Description;
				if (description2 != null)
				{
					ParseExtensions(description2);
				}
			}
		}
		if (authMechs != AuthMechs.None)
		{
			Authenticate();
		}
		MailAddress mailAddress = message.Sender;
		if (mailAddress == null)
		{
			mailAddress = message.From;
		}
		if (mailAddress == null)
		{
			mailAddress = defaultFrom;
		}
		status = SendCommand("MAIL FROM:<" + mailAddress.Address + ">");
		if (IsError(status))
		{
			throw new SmtpException(status.StatusCode, status.Description);
		}
		List<SmtpFailedRecipientException> list = new List<SmtpFailedRecipientException>();
		for (int i = 0; i < message.To.Count; i++)
		{
			status = SendCommand("RCPT TO:<" + message.To[i].Address + ">");
			if (IsError(status))
			{
				list.Add(new SmtpFailedRecipientException(status.StatusCode, message.To[i].Address));
			}
		}
		for (int j = 0; j < message.CC.Count; j++)
		{
			status = SendCommand("RCPT TO:<" + message.CC[j].Address + ">");
			if (IsError(status))
			{
				list.Add(new SmtpFailedRecipientException(status.StatusCode, message.CC[j].Address));
			}
		}
		for (int k = 0; k < message.Bcc.Count; k++)
		{
			status = SendCommand("RCPT TO:<" + message.Bcc[k].Address + ">");
			if (IsError(status))
			{
				list.Add(new SmtpFailedRecipientException(status.StatusCode, message.Bcc[k].Address));
			}
		}
		if (list.Count > 0)
		{
			throw new SmtpFailedRecipientsException("failed recipients", list.ToArray());
		}
		status = SendCommand("DATA");
		if (IsError(status))
		{
			throw new SmtpException(status.StatusCode, status.Description);
		}
		string text = DateTime.Now.ToString("ddd, dd MMM yyyy HH':'mm':'ss zzz", DateTimeFormatInfo.InvariantInfo);
		text = text.Remove(text.Length - 3, 1);
		SendHeader("Date", text);
		MailAddress mailAddress2 = message.From;
		if (mailAddress2 == null)
		{
			mailAddress2 = defaultFrom;
		}
		SendHeader("From", EncodeAddress(mailAddress2));
		SendHeader("To", EncodeAddresses(message.To));
		if (message.CC.Count > 0)
		{
			SendHeader("Cc", EncodeAddresses(message.CC));
		}
		SendHeader("Subject", EncodeSubjectRFC2047(message));
		string value = "normal";
		switch (message.Priority)
		{
		case MailPriority.Normal:
			value = "normal";
			break;
		case MailPriority.Low:
			value = "non-urgent";
			break;
		case MailPriority.High:
			value = "urgent";
			break;
		}
		SendHeader("Priority", value);
		if (message.Sender != null)
		{
			SendHeader("Sender", EncodeAddress(message.Sender));
		}
		if (message.ReplyToList.Count > 0)
		{
			SendHeader("Reply-To", EncodeAddresses(message.ReplyToList));
		}
		string[] allKeys = message.Headers.AllKeys;
		foreach (string name in allKeys)
		{
			SendHeader(name, MailMessage.EncodeSubjectRFC2047(message.Headers[name], message.HeadersEncoding));
		}
		AddPriorityHeader(message);
		boundaryIndex = 0;
		if (message.Attachments.Count > 0)
		{
			SendWithAttachments(message);
		}
		else
		{
			SendWithoutAttachments(message, null, attachmentExists: false);
		}
		SendDot();
		status = Read();
		if (IsError(status))
		{
			throw new SmtpException(status.StatusCode, status.Description);
		}
		try
		{
			status = SendCommand("QUIT");
		}
		catch (IOException)
		{
		}
	}

	private void SendDot()
	{
		writer.Write(".\r\n");
		writer.Flush();
	}

	private void SendData(string data)
	{
		if (string.IsNullOrEmpty(data))
		{
			writer.Write("\r\n");
			writer.Flush();
			return;
		}
		StringReader stringReader = new StringReader(data);
		bool flag = deliveryMethod == SmtpDeliveryMethod.Network;
		string text;
		while ((text = stringReader.ReadLine()) != null)
		{
			CheckCancellation();
			if (flag && text.Length > 0 && text[0] == '.')
			{
				text = "." + text;
			}
			writer.Write(text);
			writer.Write("\r\n");
		}
		writer.Flush();
	}

	private void AddPriorityHeader(MailMessage message)
	{
		switch (message.Priority)
		{
		case MailPriority.High:
			SendHeader("Priority", "Urgent");
			SendHeader("Importance", "high");
			SendHeader("X-Priority", "1");
			break;
		case MailPriority.Low:
			SendHeader("Priority", "Non-Urgent");
			SendHeader("Importance", "low");
			SendHeader("X-Priority", "5");
			break;
		}
	}

	private void SendSimpleBody(MailMessage message)
	{
		SendHeader("Content-Type", message.BodyContentType.ToString());
		if (message.ContentTransferEncoding != TransferEncoding.SevenBit)
		{
			SendHeader("Content-Transfer-Encoding", GetTransferEncodingName(message.ContentTransferEncoding));
		}
		SendData(string.Empty);
		SendData(EncodeBody(message));
	}

	private void SendBodylessSingleAlternate(AlternateView av)
	{
		SendHeader("Content-Type", av.ContentType.ToString());
		if (av.TransferEncoding != TransferEncoding.SevenBit)
		{
			SendHeader("Content-Transfer-Encoding", GetTransferEncodingName(av.TransferEncoding));
		}
		SendData(string.Empty);
		SendData(EncodeBody(av));
	}

	private void SendWithoutAttachments(MailMessage message, string boundary, bool attachmentExists)
	{
		if (message.Body == null && message.AlternateViews.Count == 1)
		{
			SendBodylessSingleAlternate(message.AlternateViews[0]);
		}
		else if (message.AlternateViews.Count > 0)
		{
			SendBodyWithAlternateViews(message, boundary, attachmentExists);
		}
		else
		{
			SendSimpleBody(message);
		}
	}

	private void SendWithAttachments(MailMessage message)
	{
		string text = GenerateBoundary();
		ContentType contentType = new ContentType();
		contentType.Boundary = text;
		contentType.MediaType = "multipart/mixed";
		contentType.CharSet = null;
		SendHeader("Content-Type", contentType.ToString());
		SendData(string.Empty);
		Attachment attachment = null;
		if (message.AlternateViews.Count > 0)
		{
			SendWithoutAttachments(message, text, attachmentExists: true);
		}
		else
		{
			attachment = Attachment.CreateAttachmentFromString(message.Body, null, message.BodyEncoding, message.IsBodyHtml ? "text/html" : "text/plain");
			message.Attachments.Insert(0, attachment);
		}
		try
		{
			SendAttachments(message, attachment, text);
		}
		finally
		{
			if (attachment != null)
			{
				message.Attachments.Remove(attachment);
			}
		}
		EndSection(text);
	}

	private void SendBodyWithAlternateViews(MailMessage message, string boundary, bool attachmentExists)
	{
		AlternateViewCollection alternateViews = message.AlternateViews;
		string text = GenerateBoundary();
		ContentType contentType = new ContentType();
		contentType.Boundary = text;
		contentType.MediaType = "multipart/alternative";
		if (!attachmentExists)
		{
			SendHeader("Content-Type", contentType.ToString());
			SendData(string.Empty);
		}
		AlternateView alternateView = null;
		if (message.Body != null)
		{
			alternateView = AlternateView.CreateAlternateViewFromString(message.Body, message.BodyEncoding, message.IsBodyHtml ? "text/html" : "text/plain");
			alternateViews.Insert(0, alternateView);
			StartSection(boundary, contentType);
		}
		try
		{
			foreach (AlternateView item in alternateViews)
			{
				string text2 = null;
				if (item.LinkedResources.Count > 0)
				{
					text2 = GenerateBoundary();
					ContentType contentType2 = new ContentType("multipart/related");
					contentType2.Boundary = text2;
					contentType2.Parameters["type"] = item.ContentType.ToString();
					StartSection(text, contentType2);
					StartSection(text2, item.ContentType, item);
				}
				else
				{
					ContentType contentType2 = new ContentType(item.ContentType.ToString());
					StartSection(text, contentType2, item);
				}
				switch (item.TransferEncoding)
				{
				case TransferEncoding.Base64:
				{
					byte[] array = new byte[item.ContentStream.Length];
					item.ContentStream.Read(array, 0, array.Length);
					SendData(Convert.ToBase64String(array, Base64FormattingOptions.InsertLineBreaks));
					break;
				}
				case TransferEncoding.QuotedPrintable:
				{
					byte[] array2 = new byte[item.ContentStream.Length];
					item.ContentStream.Read(array2, 0, array2.Length);
					SendData(ToQuotedPrintable(array2));
					break;
				}
				case TransferEncoding.Unknown:
				case TransferEncoding.SevenBit:
				{
					byte[] array = new byte[item.ContentStream.Length];
					item.ContentStream.Read(array, 0, array.Length);
					SendData(Encoding.ASCII.GetString(array));
					break;
				}
				}
				if (item.LinkedResources.Count > 0)
				{
					SendLinkedResources(message, item.LinkedResources, text2);
					EndSection(text2);
				}
				if (!attachmentExists)
				{
					SendData(string.Empty);
				}
			}
		}
		finally
		{
			if (alternateView != null)
			{
				alternateViews.Remove(alternateView);
			}
		}
		EndSection(text);
	}

	private void SendLinkedResources(MailMessage message, LinkedResourceCollection resources, string boundary)
	{
		foreach (LinkedResource resource in resources)
		{
			StartSection(boundary, resource.ContentType, resource);
			switch (resource.TransferEncoding)
			{
			case TransferEncoding.Base64:
			{
				byte[] array = new byte[resource.ContentStream.Length];
				resource.ContentStream.Read(array, 0, array.Length);
				SendData(Convert.ToBase64String(array, Base64FormattingOptions.InsertLineBreaks));
				break;
			}
			case TransferEncoding.QuotedPrintable:
			{
				byte[] array2 = new byte[resource.ContentStream.Length];
				resource.ContentStream.Read(array2, 0, array2.Length);
				SendData(ToQuotedPrintable(array2));
				break;
			}
			case TransferEncoding.Unknown:
			case TransferEncoding.SevenBit:
			{
				byte[] array = new byte[resource.ContentStream.Length];
				resource.ContentStream.Read(array, 0, array.Length);
				SendData(Encoding.ASCII.GetString(array));
				break;
			}
			}
		}
	}

	private void SendAttachments(MailMessage message, Attachment body, string boundary)
	{
		foreach (Attachment attachment in message.Attachments)
		{
			ContentType contentType = new ContentType(attachment.ContentType.ToString());
			if (attachment.Name != null)
			{
				contentType.Name = attachment.Name;
				if (attachment.NameEncoding != null)
				{
					contentType.CharSet = attachment.NameEncoding.HeaderName;
				}
				attachment.ContentDisposition.FileName = attachment.Name;
			}
			StartSection(boundary, contentType, attachment, attachment != body);
			byte[] array = new byte[attachment.ContentStream.Length];
			attachment.ContentStream.Read(array, 0, array.Length);
			switch (attachment.TransferEncoding)
			{
			case TransferEncoding.Base64:
				SendData(Convert.ToBase64String(array, Base64FormattingOptions.InsertLineBreaks));
				break;
			case TransferEncoding.QuotedPrintable:
				SendData(ToQuotedPrintable(array));
				break;
			case TransferEncoding.Unknown:
			case TransferEncoding.SevenBit:
				SendData(Encoding.ASCII.GetString(array));
				break;
			}
			SendData(string.Empty);
		}
	}

	private SmtpResponse SendCommand(string command)
	{
		writer.Write(command);
		writer.Write("\r\n");
		writer.Flush();
		return Read();
	}

	private void SendHeader(string name, string value)
	{
		SendData($"{name}: {value}");
	}

	private void StartSection(string section, ContentType sectionContentType)
	{
		SendData($"--{section}");
		SendHeader("content-type", sectionContentType.ToString());
		SendData(string.Empty);
	}

	private void StartSection(string section, ContentType sectionContentType, AttachmentBase att)
	{
		SendData($"--{section}");
		SendHeader("content-type", sectionContentType.ToString());
		SendHeader("content-transfer-encoding", GetTransferEncodingName(att.TransferEncoding));
		if (!string.IsNullOrEmpty(att.ContentId))
		{
			SendHeader("content-ID", "<" + att.ContentId + ">");
		}
		SendData(string.Empty);
	}

	private void StartSection(string section, ContentType sectionContentType, Attachment att, bool sendDisposition)
	{
		SendData($"--{section}");
		if (!string.IsNullOrEmpty(att.ContentId))
		{
			SendHeader("content-ID", "<" + att.ContentId + ">");
		}
		SendHeader("content-type", sectionContentType.ToString());
		SendHeader("content-transfer-encoding", GetTransferEncodingName(att.TransferEncoding));
		if (sendDisposition)
		{
			SendHeader("content-disposition", att.ContentDisposition.ToString());
		}
		SendData(string.Empty);
	}

	private string ToQuotedPrintable(string input, Encoding enc)
	{
		byte[] bytes = enc.GetBytes(input);
		return ToQuotedPrintable(bytes);
	}

	private string ToQuotedPrintable(byte[] bytes)
	{
		StringWriter stringWriter = new StringWriter();
		int num = 0;
		StringBuilder stringBuilder = new StringBuilder("=", 3);
		byte b = 61;
		char c = '\0';
		foreach (byte b2 in bytes)
		{
			int num2;
			if (b2 > 127 || b2 == b)
			{
				stringBuilder.Length = 1;
				stringBuilder.Append(Convert.ToString(b2, 16).ToUpperInvariant());
				num2 = 3;
			}
			else
			{
				c = Convert.ToChar(b2);
				if (c == '\r' || c == '\n')
				{
					stringWriter.Write(c);
					num = 0;
					continue;
				}
				num2 = 1;
			}
			num += num2;
			if (num > 75)
			{
				stringWriter.Write("=\r\n");
				num = num2;
			}
			if (num2 == 1)
			{
				stringWriter.Write(c);
			}
			else
			{
				stringWriter.Write(stringBuilder.ToString());
			}
		}
		return stringWriter.ToString();
	}

	private static string GetTransferEncodingName(TransferEncoding encoding)
	{
		return encoding switch
		{
			TransferEncoding.QuotedPrintable => "quoted-printable", 
			TransferEncoding.SevenBit => "7bit", 
			TransferEncoding.Base64 => "base64", 
			_ => "unknown", 
		};
	}

	private void InitiateSecureConnection()
	{
		SmtpResponse status = SendCommand("STARTTLS");
		if (IsError(status))
		{
			throw new SmtpException(SmtpStatusCode.GeneralFailure, "Server does not support secure connections.");
		}
		MobileTlsProvider providerInternal = Mono.Net.Security.MonoTlsProviderFactory.GetProviderInternal();
		MonoTlsSettings monoTlsSettings = MonoTlsSettings.CopyDefaultSettings();
		monoTlsSettings.UseServicePointManagerCallback = true;
		SslStream sslStream = new SslStream(stream, leaveInnerStreamOpen: false, providerInternal, monoTlsSettings);
		CheckCancellation();
		sslStream.AuthenticateAsClient(Host, ClientCertificates, (SslProtocols)ServicePointManager.SecurityProtocol, checkCertificateRevocation: false);
		stream = sslStream;
	}

	private void Authenticate()
	{
		string text = null;
		string text2 = null;
		if (UseDefaultCredentials)
		{
			text = CredentialCache.DefaultCredentials.GetCredential(new Uri("smtp://" + host), "basic").UserName;
			text2 = CredentialCache.DefaultCredentials.GetCredential(new Uri("smtp://" + host), "basic").Password;
		}
		else
		{
			if (Credentials == null)
			{
				return;
			}
			text = Credentials.GetCredential(host, port, "smtp").UserName;
			text2 = Credentials.GetCredential(host, port, "smtp").Password;
		}
		Authenticate(text, text2);
	}

	private void CheckStatus(SmtpResponse status, int i)
	{
		if (status.StatusCode != (SmtpStatusCode)i)
		{
			throw new SmtpException(status.StatusCode, status.Description);
		}
	}

	private void Authenticate(string user, string password)
	{
		if (authMechs == AuthMechs.None)
		{
			return;
		}
		if ((authMechs & AuthMechs.Login) != AuthMechs.None)
		{
			SmtpResponse status = SendCommand("AUTH LOGIN");
			CheckStatus(status, 334);
			status = SendCommand(Convert.ToBase64String(Encoding.UTF8.GetBytes(user)));
			CheckStatus(status, 334);
			status = SendCommand(Convert.ToBase64String(Encoding.UTF8.GetBytes(password)));
			CheckStatus(status, 235);
			return;
		}
		if ((authMechs & AuthMechs.Plain) != AuthMechs.None)
		{
			string s = $"\0{user}\0{password}";
			s = Convert.ToBase64String(Encoding.UTF8.GetBytes(s));
			SmtpResponse status = SendCommand("AUTH PLAIN " + s);
			CheckStatus(status, 235);
			return;
		}
		throw new SmtpException("AUTH types PLAIN, LOGIN not supported by the server");
	}
}
