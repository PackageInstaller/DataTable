using System;

namespace Sirenix.Serialization;

public sealed class VersionFormatter : MinimalBaseFormatter<Version>
{
	protected override Version GetUninitializedObject()
	{
		return null;
	}

	protected override void Read(ref Version value, IDataReader reader)
	{
		int value2 = 0;
		int value3 = 0;
		int value4 = 0;
		int value5 = 0;
		reader.ReadInt32(out value2);
		reader.ReadInt32(out value3);
		reader.ReadInt32(out value4);
		reader.ReadInt32(out value5);
		if (value2 < 0 || value3 < 0)
		{
			value = new Version();
		}
		else if (value4 < 0)
		{
			value = new Version(value2, value3);
		}
		else if (value5 < 0)
		{
			value = new Version(value2, value3, value4);
		}
		else
		{
			value = new Version(value2, value3, value4, value5);
		}
	}

	protected override void Write(ref Version value, IDataWriter writer)
	{
		writer.WriteInt32(null, value.Major);
		writer.WriteInt32(null, value.Minor);
		writer.WriteInt32(null, value.Build);
		writer.WriteInt32(null, value.Revision);
	}
}
