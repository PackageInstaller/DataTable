using GameFramework.Network;

namespace Ase;

public interface IActorRequest : IRequest, IMessage
{
	long ActorId { get; set; }
}
