namespace Dorm;

public class TileEntity
{
	public short coordinateX;

	public short coordinateY;

	public short coordinateZ;

	protected bool isOccupy_;

	public virtual bool isOccupy
	{
		get
		{
			return isOccupy_;
		}
		set
		{
			isOccupy_ = value;
		}
	}
}
