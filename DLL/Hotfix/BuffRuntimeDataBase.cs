using Ase.ECS;
using GameFramework;

public class BuffRuntimeDataBase : IReference
{
	public BaseEntity toEntity;

	public virtual BaseEntity ToEntity => toEntity;

	public virtual void Clear()
	{
	}

	public virtual BuffRuntimeDataBase Copy()
	{
		return null;
	}
}
