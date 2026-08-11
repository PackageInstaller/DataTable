using GameFramework;

namespace Ase;

public class RollBackData : IReference
{
	private RollBackType rollBackType;

	public RollBackType RollBackType => rollBackType;

	public static RollBackData Acquire()
	{
		return ReferencePool.Acquire<RollBackData>();
	}

	public RollBackData()
	{
		rollBackType = RollBackType.Ignore;
	}

	public void AttachRollBackType(RollBackType type)
	{
		rollBackType |= type;
	}

	public void RemoveRollBackType(RollBackType type)
	{
		rollBackType ^= type;
	}

	public bool CheckType(RollBackType type)
	{
		return (rollBackType & type) == type;
	}

	public void AddRollBackInfo(string info)
	{
	}

	public void Debug()
	{
	}

	public void Dispose()
	{
		ReferencePool.Release(this);
	}

	public void Clear()
	{
		rollBackType = RollBackType.Ignore;
	}
}
