using GameFramework.Network;

namespace Ase;

public interface IFrameMessage : IMessage
{
	long Id { get; set; }
}
