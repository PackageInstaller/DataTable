using UnityEngine;
using ZumaGame;

public class ZumaNormalBall : ZumaBaseBall
{
	public override void InitShow()
	{
	}

	public override void Recovery(bool isClear = false)
	{
		track.gamePlay.ballNormalPool.AddObject(this);
		base.gameObject.SetActive(value: false);
		ZumaGameManager.IsShowObj(base.transform, isShow: false);
		isUnUse = true;
		isDirectDestory = false;
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
		}
		else
		{
			spriteRendener.sortingOrder = 10;
		}
	}
}
