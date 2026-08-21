using System.Runtime.InteropServices;

namespace Ase;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct Packet
{
	public const int MinPacketSize = 2;

	public const int OpcodeIndex = 8;

	public const int OpcodeLength = 2;

	public const int ActorIdIndex = 0;

	public const int ActorIdLength = 16;

	public const int OuterPacketSizeLength = 2;
}
