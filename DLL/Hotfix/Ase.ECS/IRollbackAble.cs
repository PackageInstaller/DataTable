using Ase.Serializing;

namespace Ase.ECS;

public interface IRollbackAble
{
	void TakeSnapShot(PooledWriter writer);

	void RollBackTo(ref RollBackData rollBackData, PooledReader localReader, PooledReader reader);
}
