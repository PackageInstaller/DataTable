public class ShootGameBullet : ShootGameTarget
{
	private new int direction = 8;

	public void Awake()
	{
		base.Speed = 5f;
	}

	private void Update()
	{
		if (ShootGameControl.Instance.state != ShootGameControl.GameStatus.Start && ShootGameControl.Instance.state != ShootGameControl.GameStatus.Paused && ShootGameControl.Instance.state != ShootGameControl.GameStatus.GameOver)
		{
			Move(base.Direction);
			CheckOutbound();
		}
	}

	public override bool OnCollision(ShootGameTarget otherObj)
	{
		int num;
		if (IsCollision(otherObj))
		{
			num = ((otherObj.Direction != 8) ? 1 : 0);
			if (num != 0)
			{
				base.Direction = 8;
				ShootGameControl.Instance.RemoveShootGameTarget("bullet", this);
				otherObj.OnCollision(this);
			}
		}
		else
		{
			num = 0;
		}
		return (byte)num != 0;
	}

	private void CheckOutbound()
	{
		if (base.transform.position.z < -25f)
		{
			base.Direction = 8;
			ShootGameControl.Instance.RemoveShootGameTarget("bullet", this);
		}
	}
}
