namespace Ase;

public class BulletViewData
{
	public bool isActive;

	public BulletViewData Clone()
	{
		return new BulletViewData
		{
			isActive = isActive
		};
	}
}
