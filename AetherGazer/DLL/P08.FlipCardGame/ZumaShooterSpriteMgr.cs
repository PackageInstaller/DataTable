using ZumaGame;

public class ZumaShooterSpriteMgr : ZumaSpriteBaseMgr
{
	public override void AwakeInit()
	{
		ZumaGameManager.GetInstance().SetZumaShooterSpriteMgr(this);
	}

	public FrameSprite GetShooterFrame(ShooterDir dir, ShooterState state, BallColorType colorType = BallColorType.EmptyColor)
	{
		return GetFrameSprite(GetShooterFrameType(dir, state), colorType);
	}

	public FrameType GetShooterFrameType(ShooterDir dir, ShooterState state)
	{
		FrameType result = FrameType.IDLE_FRONT;
		switch (state)
		{
		case ShooterState.IDLE:
			result = dir switch
			{
				ShooterDir.FRONT => FrameType.IDLE_FRONT, 
				ShooterDir.BACK => FrameType.IDLE_BACK, 
				_ => FrameType.IDLE_SIDE, 
			};
			break;
		case ShooterState.ATTACK:
			result = dir switch
			{
				ShooterDir.FRONT => FrameType.ATTACK_FRONT, 
				ShooterDir.BACK => FrameType.ATTACK_BACK, 
				_ => FrameType.ATTACK_SIDE, 
			};
			break;
		}
		return result;
	}
}
