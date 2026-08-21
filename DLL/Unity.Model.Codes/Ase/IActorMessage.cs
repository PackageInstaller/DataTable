using GameFramework.Network;

namespace Ase;

public interface IActorMessage : INotification, IMessage
{
	long ActorId { get; set; }
}
