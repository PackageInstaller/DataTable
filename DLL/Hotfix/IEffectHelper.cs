using Ase.ECS;

public interface IEffectHelper
{
	bool IsFrozenEffect { get; }

	int ConfigId { get; }

	BaseEntity GetEffectOwner();
}
