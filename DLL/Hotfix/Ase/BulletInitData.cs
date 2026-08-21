namespace Ase;

public class BulletInitData
{
	public BulletModifySiteLevelEnum modifySiteLevelEnum;

	public BulletInitData Clone()
	{
		return new BulletInitData
		{
			modifySiteLevelEnum = modifySiteLevelEnum
		};
	}
}
