namespace GameFramework.Network;

public class MessageAttribute : BaseAttribute
{
	public ushort Opcode { get; }

	public MessageAttribute(ushort opcode)
	{
		Opcode = opcode;
	}
}
