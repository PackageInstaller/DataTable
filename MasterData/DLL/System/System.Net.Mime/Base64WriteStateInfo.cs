namespace System.Net.Mime;

internal class Base64WriteStateInfo : WriteStateInfoBase
{
	internal int Padding { get; set; }

	internal byte LastBits { get; set; }

	internal Base64WriteStateInfo(int bufferSize, byte[] header, byte[] footer, int maxLineLength, int mimeHeaderLength)
		: base(bufferSize, header, footer, maxLineLength, mimeHeaderLength)
	{
	}
}
