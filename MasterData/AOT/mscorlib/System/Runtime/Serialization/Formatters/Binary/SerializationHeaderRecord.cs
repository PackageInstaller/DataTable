using System.IO;

namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class SerializationHeaderRecord
{
	internal int binaryFormatterMajorVersion = 1;

	internal int binaryFormatterMinorVersion;

	internal BinaryHeaderEnum binaryHeaderEnum;

	internal int topId;

	internal int headerId;

	internal int majorVersion;

	internal int minorVersion;

	internal SerializationHeaderRecord()
	{
	}

	internal SerializationHeaderRecord(BinaryHeaderEnum binaryHeaderEnum, int topId, int headerId, int majorVersion, int minorVersion)
	{
		this.binaryHeaderEnum = binaryHeaderEnum;
		this.topId = topId;
		this.headerId = headerId;
		this.majorVersion = majorVersion;
		this.minorVersion = minorVersion;
	}

	public void Write(__BinaryWriter sout)
	{
		majorVersion = binaryFormatterMajorVersion;
		minorVersion = binaryFormatterMinorVersion;
		sout.WriteByte((byte)binaryHeaderEnum);
		sout.WriteInt32(topId);
		sout.WriteInt32(headerId);
		sout.WriteInt32(binaryFormatterMajorVersion);
		sout.WriteInt32(binaryFormatterMinorVersion);
	}

	private static int GetInt32(byte[] buffer, int index)
	{
		return buffer[index] | (buffer[index + 1] << 8) | (buffer[index + 2] << 16) | (buffer[index + 3] << 24);
	}

	public void Read(__BinaryParser input)
	{
		byte[] array = input.ReadBytes(17);
		if (array.Length < 17)
		{
			__Error.EndOfFile();
		}
		majorVersion = GetInt32(array, 9);
		if (majorVersion > binaryFormatterMajorVersion)
		{
			throw new SerializationException(Environment.GetResourceString("The input stream is not a valid binary format. The starting contents (in bytes) are: {0} ...", BitConverter.ToString(array)));
		}
		binaryHeaderEnum = (BinaryHeaderEnum)array[0];
		topId = GetInt32(array, 1);
		headerId = GetInt32(array, 5);
		minorVersion = GetInt32(array, 13);
	}

	public void Dump()
	{
	}
}
