using ZumaGame;

public class ZumaTrackBallSpriteMgr : ZumaSpriteBaseMgr
{
	public override void AwakeInit()
	{
		ZumaGameManager.GetInstance().SetTrackBallSpriteMgr(this);
	}

	public FrameSprite GetFrameBg(BallEffctType effectType, BallColorType colorType)
	{
		if (effectType == BallEffctType.NORMAL)
		{
			return GetFrameSprite(FrameType.NORMAL_BALL_BG, colorType);
		}
		return GetFrameSprite(FrameType.SPECIAL_BALL_BG, colorType);
	}

	public FrameSprite GetFrameByEffectType(BallEffctType effectType, BallColorType colorType = BallColorType.EmptyColor)
	{
		FrameType frameType = FrameType.Default;
		switch (effectType)
		{
		case BallEffctType.BACK:
			frameType = FrameType.BACK_BALL;
			break;
		case BallEffctType.AIM:
			frameType = FrameType.AIM_BALL;
			break;
		case BallEffctType.STOP:
			frameType = FrameType.STOP_BALL;
			break;
		}
		return GetFrameSprite(frameType, colorType);
	}
}
