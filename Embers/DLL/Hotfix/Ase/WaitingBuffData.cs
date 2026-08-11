using GameFramework;

namespace Ase;

public class WaitingBuffData : IReference
{
	private int fromId;

	private int targetId;

	private int buffId;

	public int FromId => fromId;

	public int TargetId => targetId;

	public int BuffId => buffId;

	public static WaitingBuffData Create(int fromId, int targetId, int buffId)
	{
		WaitingBuffData waitingBuffData = ReferencePool.Acquire<WaitingBuffData>();
		waitingBuffData.fromId = fromId;
		waitingBuffData.targetId = targetId;
		waitingBuffData.buffId = buffId;
		return waitingBuffData;
	}

	public static WaitingBuffData Create(int fromId, int buffId)
	{
		WaitingBuffData waitingBuffData = ReferencePool.Acquire<WaitingBuffData>();
		waitingBuffData.fromId = fromId;
		waitingBuffData.buffId = buffId;
		return waitingBuffData;
	}

	public void Clear()
	{
		fromId = 0;
		targetId = 0;
		buffId = 0;
	}

	public void Dispose()
	{
		ReferencePool.Release(this);
	}

	public override string ToString()
	{
		return $"WaitingBuffData = [{fromId} , {targetId} , {buffId}]";
	}
}
