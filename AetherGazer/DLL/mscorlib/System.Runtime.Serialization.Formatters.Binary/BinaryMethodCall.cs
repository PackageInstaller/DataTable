namespace System.Runtime.Serialization.Formatters.Binary;

internal sealed class BinaryMethodCall
{
	private string methodName;

	private string typeName;

	private object[] args;

	private object callContext;

	private Type[] argTypes;

	private bool bArgsPrimitive = true;

	private MessageEnum messageEnum;

	internal void Write(__BinaryWriter sout)
	{
		sout.WriteByte(21);
		sout.WriteInt32((int)messageEnum);
		IOUtil.WriteStringWithCode(methodName, sout);
		IOUtil.WriteStringWithCode(typeName, sout);
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

	internal void Dump()
	{
	}
}
