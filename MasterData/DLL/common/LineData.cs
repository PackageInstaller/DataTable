using System;
using Google.Protobuf;

public class LineData
{
	public IMessage message;

	private byte[] bytes;

	public LineData(byte[] bytes)
	{
		this.bytes = bytes;
	}

	public IMessage GetMessage(MessageParser parser, bool gc = false)
	{
		if (message == null)
		{
			if (gc)
			{
				GC.Collect();
			}
			message = parser.ParseFrom(bytes);
		}
		return message;
	}
}
