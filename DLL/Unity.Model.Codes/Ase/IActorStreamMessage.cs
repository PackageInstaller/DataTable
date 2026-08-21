using GameFramework.Network;

namespace Ase;

public interface IActorStreamMessage : IMessage
{
	long ActorId { get; set; }

	ushort Opcode { get; set; }

	byte[] data { get; set; }

	int dataSize { get; set; }
}
