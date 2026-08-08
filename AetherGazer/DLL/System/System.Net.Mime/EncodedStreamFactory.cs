using System.Text;

namespace System.Net.Mime;

internal class EncodedStreamFactory
{
	internal IEncodableStream GetEncoderForHeader(Encoding encoding, bool useBase64Encoding, int headerTextLength)
	{
		byte[] header = CreateHeader(encoding, useBase64Encoding);
		byte[] footer = CreateFooter();
		if (useBase64Encoding)
		{
			return new Base64Stream(new Base64WriteStateInfo(1024, header, footer, 70, headerTextLength));
		}
		return new QEncodedStream(new WriteStateInfoBase(1024, header, footer, 70, headerTextLength));
	}

	protected byte[] CreateHeader(Encoding encoding, bool useBase64Encoding)
	{
		return Encoding.ASCII.GetBytes("=?" + encoding.HeaderName + "?" + (useBase64Encoding ? "B?" : "Q?"));
	}

	protected byte[] CreateFooter()
	{
		return new byte[2] { 63, 61 };
	}
}
