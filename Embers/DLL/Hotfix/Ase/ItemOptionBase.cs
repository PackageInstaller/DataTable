namespace Ase;

public class ItemOptionBase : ViewOptionBase
{
	protected ViewOptionBase parent;

	public ViewOptionBase Parent => parent;

	public virtual void SetParent(ViewOptionBase parent)
	{
		if (parent != this)
		{
			this.parent = parent;
		}
	}
}
