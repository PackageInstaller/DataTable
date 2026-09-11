namespace System.Runtime.Serialization.Formatters.Binary;

internal static class IOUtil
{
	internal static bool FlagTest(MessageEnum flag, MessageEnum target)
	{
		if ((flag & target) == target)
		{
			return true;
		}
		return false;
	}

	internal static void WriteStringWithCode(string value, __BinaryWriter sout)
	{
		if (value == null)
		{
			sout.WriteByte(17);
			return;
		}
		sout.WriteByte(18);
		sout.WriteString(value);
	}

	internal static void WriteWithCode(Type type, object value, __BinaryWriter sout)
	{
		if ((object)type == null)
		{
			sout.WriteByte(17);
			return;
		}
		if ((object)type == Converter.typeofString)
		{
			WriteStringWithCode((string)value, sout);
			return;
		}
		InternalPrimitiveTypeE internalPrimitiveTypeE = Converter.ToCode(type);
		sout.WriteByte((byte)internalPrimitiveTypeE);
		sout.WriteValue(internalPrimitiveTypeE, value);
	}
}
