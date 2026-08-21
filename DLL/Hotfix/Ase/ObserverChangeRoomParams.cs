using Ase.ECS;
using GameFramework;

namespace Ase;

public class ObserverChangeRoomParams : IObserverParams, IReference
{
	protected BaseEntity entity;

	public int RoomID;

	public BattleObserverEventEnum ObserverEventType => BattleObserverEventEnum.ChangeRoom;

	public BaseEntity Trigger => entity;

	public void Init(int roomID, BaseEntity entity)
	{
		RoomID = roomID;
		this.entity = entity;
	}

	public void Clear()
	{
		entity = null;
	}

	public IObserverParams Copy()
	{
		ObserverChangeRoomParams observerChangeRoomParams = ReferencePool.Acquire<ObserverChangeRoomParams>();
		observerChangeRoomParams.entity = entity;
		observerChangeRoomParams.RoomID = RoomID;
		return observerChangeRoomParams;
	}
}
