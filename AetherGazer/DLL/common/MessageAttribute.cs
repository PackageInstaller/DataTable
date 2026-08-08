using System;

public class MessageAttribute : Attribute
{
	public ushort Opcode { get; }

	public MessageAttribute(ushort opcode)
	{
		Opcode = opcode;
	}
}
