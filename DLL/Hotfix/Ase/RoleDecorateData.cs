namespace Ase;

public class RoleDecorateData
{
	public int id;

	public RoleDecorateEnum DecorateType;

	public long expireTime;

	public bool isNew;

	public void SetDefault()
	{
		id = 0;
		expireTime = 0L;
	}

	public void SetIdAndExpire(int id, long expireTime)
	{
		this.id = id;
		this.expireTime = expireTime;
	}
}
