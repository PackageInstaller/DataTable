using System;
using TrueSync;

public class GameplayRoom
{
	public virtual bool isComplete { get; protected set; } = true;

	public virtual void InitRoom(GameplayRoomData data, Action<HotfixEnum.levelState, int> levelStateCallback)
	{
	}

	public virtual void EntryRoom()
	{
	}

	public virtual void UpdateLogic(FP logicDeltaTime)
	{
	}

	public virtual void Pause()
	{
	}

	public virtual void Resume()
	{
	}

	public virtual void LeaveRoom()
	{
	}
}
