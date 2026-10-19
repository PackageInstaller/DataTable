namespace Unity.VisualScripting.Community.Libraries.Humility;

public struct ContactConnection<TItem>
{
	public TItem item;

	public float contactDistance;

	public bool contacted => item != null;

	public ContactConnection(TItem item, float contactDistance = 0f)
	{
		this.item = item;
		this.contactDistance = contactDistance;
	}
}
