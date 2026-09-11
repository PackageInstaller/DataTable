using Entitas;

public struct SyncFactor(Entity owner, ESimStateKey key, VFactor value)
{
	public int ownerID = owner.creationIndex;

	public ESimStateKey key = key;

	public VFactor value = value;

	public void SetValue(VFactor value)
	{
		this.value = value;
	}
}
