using GameFramework.Network;

namespace Ase;

public interface IActorThroughRequest : IActorRequest, IRequest, IMessage
{
	long UserId { get; set; }

	int ClientFlag { get; set; }
}
