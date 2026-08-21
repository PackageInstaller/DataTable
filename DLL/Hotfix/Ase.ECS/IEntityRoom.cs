namespace Ase.ECS;

public interface IEntityRoom
{
	int ID { get; }

	int RoomId { get; set; }

	bool InLocalActorRoom();
}
