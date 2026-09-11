using UnityEngine;
using UnityEngine.UI;

public class ZumaAnimatorInUi : MonoBehaviour
{
	public FrameSprite frameSprite;

	private Image img;

	private int spriteIndex;

	private float changeTime = 0.1f;

	private float playTimes;

	private Image GetSpriteRenderer()
	{
		if (img == null)
		{
			img = GetComponent<Image>();
			changeTime = frameSprite.changeTime;
		}
		return img;
	}

	private void Update()
	{
		if (frameSprite != null && frameSprite.spriteNums > 1)
		{
			playTimes += Time.deltaTime;
			if (playTimes > changeTime)
			{
				spriteIndex = (spriteIndex + 1) % frameSprite.spriteNums;
				GetSpriteRenderer().sprite = frameSprite.spriteList[spriteIndex];
				playTimes = 0f;
			}
		}
	}
}
