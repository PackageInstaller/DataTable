namespace System.Net.Mime;

internal interface IEncodableStream
{
	int DecodeBytes(byte[] buffer, int offset, int count);

	int EncodeBytes(byte[] buffer, int offset, int count);

	string GetEncodedString();
}
