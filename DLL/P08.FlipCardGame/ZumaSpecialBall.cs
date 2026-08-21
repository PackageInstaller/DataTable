using UnityEngine;
using ZumaGame;

public class ZumaSpecialBall : ZumaBaseBall
{
	private ZumaAnimator zumaAnimator;

	private SpriteRenderer bgSpRder;

	private void InitZumaAnimator()
	{
		if (zumaAnimator == null)
		{
			zumaAnimator = base.transform.Find("bg").GetComponent<ZumaAnimator>();
		}
		if (bgSpRder == null)
		{
			bgSpRder = base.transform.Find("bg").GetComponent<SpriteRenderer>();
		}
	}

	public override void InitShow()
	{
		InitZumaAnimator();
		zumaAnimator.IsShowAnimator(isShow: true);
		FrameSprite frameByEffectType = ZumaGameManager.GetInstance().trackBallSpriteMgr.GetFrameByEffectType(effectType);
		zumaAnimator.ChangeFrameList(frameByEffectType);
	}

	public override void DisposeBeginFunc()
	{
		zumaAnimator.IsShowAnimator(isShow: false);
	}

	public override void Recovery(bool isClear = false)
	{
		if (!isClear)
		{
			ZumaGameManager.GetInstance().StrikeBallEffect(effectType, track.trackID);
		}
		track.gamePlay.ballSpecialPool.AddObject(this);
		base.gameObject.SetActive(value: false);
		isUnUse = true;
		ZumaGameManager.IsShowObj(base.transform, isShow: false);
	}

	public override void ChangeColorType(BallColorType colorType)
	{
		base.colorType = colorType;
		Sprite spirteRender = ZumaGameManager.GetInstance().trackBallSpriteMgr.GetFrameBg(effectType, colorType).spriteList[0];
		SetSpirteRender(spirteRender);
	}

	public override void UpdateHideShow()
	{
		if ((bool)track && track.CheckIsInHideRange(progress))
		{
			spriteRendener.sortingOrder = 3;
			bgSpRder.sortingOrder = 4;
		}
		else
		{
			spriteRendener.sortingOrder = 10;
			bgSpRder.sortingOrder = 11;
		}
	}
}
