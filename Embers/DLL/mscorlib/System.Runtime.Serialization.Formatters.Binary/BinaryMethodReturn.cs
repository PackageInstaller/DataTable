namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class BinaryMethodReturn
{
	private object returnValue;

	private object[] args;

	private object callContext;

	private Type[] argTypes;

	private bool bArgsPrimitive = true;

	private MessageEnum messageEnum;

	private Type returnType;

	private static object instanceOfVoid;

	static BinaryMethodReturn()
	{
		instanceOfVoid = FormatterServices.GetUninitializedObject(Converter.typeofSystemVoid);
	}

	internal BinaryMethodReturn()
	{
	}

	public void Write(__BinaryWriter sout)
	{
		sout.WriteByte(22);
		sout.WriteInt32((int)messageEnum);
		if (IOUtil.FlagTest(messageEnum, MessageEnum.ReturnValueInline))
		{
			IOUtil.WriteWithCode(returnType, returnValue, sout);
		}
		if (IOUtil.FlagTest(messageEnum, MessageEnum.ContextInline))
		{
			IOUtil.WriteStringWithCode((string)callContext, sout);
		}
		if (IOUtil.FlagTest(messageEnum, MessageEnum.ArgsInline))
		{
			sout.WriteInt32(args.Length);
			for (int i = 0; i < args.Length; i++)
			{
				IOUtil.WriteWithCode(argTypes[i], args[i], sout);
			}
		}
	}

	public void Dump()
	{
	}
}
