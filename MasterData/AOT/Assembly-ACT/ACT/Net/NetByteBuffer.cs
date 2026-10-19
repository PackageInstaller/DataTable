using System;
using Fundamental;
using Google.Protobuf;

namespace ACT.Net;

public class NetByteBuffer
{
	public const int HEAD_SIZE = 10;

	public const int BUFFER_SIZE = 131072;

	public const int CONTENT_SIZE = 131062;

	public const int RECOMMEND_RESIZE_POS = 40000;

	public byte[] data;

	public int readerIndex;

	public int length;

	public int writeableBytes => 131072 - length;

	public int readableBytes => length - readerIndex;

	public int remainSpace => 131072 - readerIndex;

	public NetByteBuffer()
	{
		data = new byte[131072];
		readerIndex = 0;
		length = 0;
	}

	public Span<byte> GetContent(int start, int length)
	{
		return new Span<byte>(data, start, length);
	}

	public ushort ReadUShort()
	{
		if (readerIndex + 1 < length)
		{
			ushort result = NetUtils.BigEndianToUshort(data, readerIndex);
			readerIndex += 2;
			return result;
		}
		return 0;
	}

	public uint ReadUInt()
	{
		if (readerIndex + 3 < length)
		{
			uint result = NetUtils.BigEndianToUint(data, readerIndex);
			readerIndex += 4;
			return result;
		}
		return 0u;
	}

	public int GetCurrentHeaderLength()
	{
		return (int)NetUtils.BigEndianToUint(data, readerIndex + 6);
	}

	public void WriteByte(byte b)
	{
		data[length++] = b;
	}

	public void WriteShort(ushort value)
	{
		data[length++] = (byte)((value >> 8) & 0xFF);
		data[length++] = (byte)(value & 0xFF);
	}

	public void WriteUInt(uint value)
	{
		data[length++] = (byte)((value >> 24) & 0xFF);
		data[length++] = (byte)((value >> 16) & 0xFF);
		data[length++] = (byte)((value >> 8) & 0xFF);
		data[length++] = (byte)(value & 0xFF);
	}

	public void WriteMessage(IMessage message)
	{
		int num = message.CalculateSize();
		WriteUInt((uint)(num + 10));
		message.WriteTo(GetContent(10, num));
		length += num;
	}

	public void Arrange()
	{
		int num = readableBytes;
		for (int i = 0; i < num; i++)
		{
			data[i] = data[i + readerIndex];
		}
		readerIndex = 0;
		length = num;
	}

	public static byte[] ToByteArray(NetPacket packet)
	{
		int num = packet.content.CalculateSize();
		int num2 = num + 10;
		byte[] array = new byte[num2];
		array[0] = (byte)((packet.cmdId >> 8) & 0xFF);
		array[1] = (byte)(packet.cmdId & 0xFF);
		array[2] = (byte)((packet.sessionId >> 24) & 0xFF);
		array[3] = (byte)((packet.sessionId >> 16) & 0xFF);
		array[4] = (byte)((packet.sessionId >> 8) & 0xFF);
		array[5] = (byte)(packet.sessionId & 0xFF);
		array[6] = (byte)((num2 >> 24) & 0xFF);
		array[7] = (byte)((num2 >> 16) & 0xFF);
		array[8] = (byte)((num2 >> 8) & 0xFF);
		array[9] = (byte)(num2 & 0xFF);
		packet.content.WriteTo(new Span<byte>(array, 10, num));
		return array;
	}

	internal bool TryWrite(NetPacket packet)
	{
		byte[] gcmEncryptedContentBytes = packet.GetGcmEncryptedContentBytes(packet.cmdId);
		int num = gcmEncryptedContentBytes.Length;
		if (num + 10 < writeableBytes)
		{
			WriteShort(packet.cmdId);
			WriteUInt(packet.sessionId);
			WriteUInt((uint)(num + 10));
			gcmEncryptedContentBytes.CopyTo(GetContent(length, num));
			Span<byte> binaryData = new Span<byte>(data, length - 10, num + 10);
			if (LogManager.ProtoRecorderEnabled)
			{
				ProtoRecorder.SaveBinaryDataAsJson((NetCommand)packet.cmdId, binaryData);
			}
			length += num;
			return true;
		}
		return false;
	}

	internal void DebugLog()
	{
	}
}
