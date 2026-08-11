namespace Ase;

public class BulletMapExData
{
	public float Damage;

	public BulletMapExData Clone()
	{
		return new BulletMapExData
		{
			Damage = Damage
		};
	}
}
