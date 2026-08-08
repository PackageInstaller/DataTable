using Entitas;

public struct SyncInt3(Entity owner, ESimStateKey key, Int3 value)
{
	public int ownerID = owner.creationIndex;

	public ESimStateKey key = key;

	public Int3 value = value;

	public void SetValue(Int3 value)
	{
		this.value = value;
	}
}
