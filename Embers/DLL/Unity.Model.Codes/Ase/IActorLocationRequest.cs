using GameFramework.Network;

namespace Ase;

public interface IActorLocationRequest : IActorRequest, IRequest, IMessage
{
	long LoginSecretKey { get; set; }

	int LoginServerId { get; set; }
}
