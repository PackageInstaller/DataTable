using UnityEngine;
using ZumaGame;

public class ZumaAnimator : MonoBehaviour
{
	private FrameSprite frameSprite;

	public int spriteIndex;

	public float changeTime = 0.1f;

	private float playTimes;

	private bool isFinish;

	private SpriteRenderer sp;

	private SpriteRenderer GetSpriteRenderer()
	{
		if (sp == null)
		{
			sp = GetComponent<SpriteRenderer>();
		}
		return sp;
	}

	private void Update()
	{
		if (frameSprite == null || frameSprite.spriteNums <= 1)
		{
			return;
		}
		playTimes += Time.deltaTime;
		if (playTimes > changeTime)
		{
			if (SetFinishState())
			{
				isFinish = true;
				return;
			}
			spriteIndex = (spriteIndex + 1) % frameSprite.spriteNums;
			GetSpriteRenderer().sprite = frameSprite.spriteList[spriteIndex];
			playTimes = 0f;
		}
	}

	private bool SetFinishState()
	{
		if (frameSprite == null)
		{
			return true;
		}
		if (!frameSprite.isLoop && spriteIndex == frameSprite.spriteNums - 1)
		{
			return true;
		}
		return false;
	}

	public bool CheckIsFinish()
	{
		return isFinish;
	}

	private void InitState()
	{
		playTimes = 0f;
		spriteIndex = 0;
		isFinish = false;
	}

	public void ClearState()
	{
		InitState();
		frameSprite = null;
	}

	public void ChangeFrameList(FrameSprite fs)
	{
		frameSprite = fs;
		changeTime = fs.changeTime;
		InitState();
		GetSpriteRenderer().sprite = frameSprite.spriteList[spriteIndex];
	}

	public int GetFrameProgress()
	{
		return spriteIndex;
	}

	public void SetSpriteXFlip(bool isReverse)
	{
		GetSpriteRenderer().flipX = isReverse;
	}

	public void IsShowAnimator(bool isShow)
	{
		ZumaGameManager.IsShowObj(base.transform, isShow);
	}
}
