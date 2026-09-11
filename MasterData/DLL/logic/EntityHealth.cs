using Entitas;

[Sim]
public class EntityHealth : IComponent
{
	public const int kMinMaxHealth = 1;

	public int MaxHealth;

	public int mCurrentHealth;

	public uint mLastDamagedAtFrame;

	internal VFactor CurrentHealthPercentage => VFactor.one;
}
