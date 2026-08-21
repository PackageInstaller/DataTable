using GameFramework.Network;

namespace Ase;

public interface IActorNotification : INotification, IMessage
{
	long LoginSecretKey { get; set; }

	int LoginServerId { get; set; }
}
