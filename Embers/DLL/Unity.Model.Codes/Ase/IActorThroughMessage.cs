using GameFramework.Network;

namespace Ase;

public interface IActorThroughMessage : IMessage
{
	long ActorId { get; set; }

	long UserId { get; set; }

	int ServerType { get; set; }
}
