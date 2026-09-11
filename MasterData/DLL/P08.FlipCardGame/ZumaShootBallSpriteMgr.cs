using ZumaGame;

public class ZumaShootBallSpriteMgr : ZumaSpriteBaseMgr
{
	public override void AwakeInit()
	{
		ZumaGameManager.GetInstance().SetShootBallSpriteMgr(this);
	}

	public FrameSprite GetFrameByEffectType(BallEffctType effectType, BallColorType colorType = BallColorType.EmptyColor)
	{
		FrameType frameType = FrameType.Default;
		switch (effectType)
		{
		case BallEffctType.CHANGECOLOR:
			frameType = FrameType.SHOOT_CHANGECOLOR_BALL;
			break;
		case BallEffctType.BOOM:
			frameType = FrameType.SHOOT_BOOM_BALL;
			break;
		case BallEffctType.ALMIGHTY:
			frameType = FrameType.SHOOT_ALMIGHTY_BALL;
			break;
		case BallEffctType.NORMAL:
			frameType = FrameType.SHOOT_NORMAL_BALL;
			break;
		case BallEffctType.BULLET:
			frameType = FrameType.SHOOT_BULLET_BALL;
			break;
		}
		return GetFrameSprite(frameType, colorType);
	}
}
