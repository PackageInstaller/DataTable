using Entitas;

public struct SyncInt(Entity owner, ESimStateKey key, int value)
{
	public int ownerID = owner.creationIndex;

	public ESimStateKey key = key;

	public int value = value;

	public void SetValue(int value)
	{
		this.value = value;
	}
}
