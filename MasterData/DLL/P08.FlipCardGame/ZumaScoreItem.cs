using System.Collections.Generic;
using UnityEngine;
using ZumaGame;

public class ZumaScoreItem : MonoBehaviour
{
	public List<SpriteRenderer> spList;

	public ZumaScoreManager scoreMgr;

	public int spriteCount;

	private float showTime = 0.6f;

	private float existTimes;

	public bool isShow;

	private Vector3 targetMoveToPos = new Vector3(0f, 0f, 0f);

	private Vector3 beginPos;

	private bool isGold;

	public void Awake()
	{
		spriteCount = spList.Count;
	}

	public void Init(ZumaScoreManager zumaScoreManager)
	{
		scoreMgr = zumaScoreManager;
	}

	public void RandomEndPos(bool isEnter)
	{
		beginPos = base.transform.position;
		float num = Random.Range(0.3f, 0.6f);
		float num2 = ((!isEnter) ? Random.Range(-0.3f, 0.3f) : ((!(beginPos.x > 0f)) ? Random.Range(0.3f, 0.5f) : Random.Range(-0.5f, -0.3f)));
		targetMoveToPos.y = base.transform.position.y + num;
		targetMoveToPos.x = base.transform.position.x + num2;
	}

	public void ShowNum(int numValue, bool isGold, bool isEnter)
	{
		this.isGold = isGold;
		existTimes = 0f;
		isShow = true;
		int index = spriteCount;
		RandomEndPos(isEnter);
		while (index-- > 0)
		{
			SpriteRenderer spriteRenderer = spList[index];
			if (numValue > 0)
			{
				spriteRenderer.sprite = scoreMgr.GetNumValueSprite(numValue % 10);
				numValue /= 10;
				spriteRenderer.gameObject.SetActive(value: true);
			}
			else
			{
				spriteRenderer.gameObject.SetActive(value: false);
			}
		}
		if (isGold)
		{
			base.transform.localScale = Vector3.one * 1.25f;
		}
	}

	public void Update()
	{
		if (!isShow)
		{
			return;
		}
		existTimes += Time.deltaTime;
		if (existTimes < showTime)
		{
			base.transform.position = Vector3.Lerp(beginPos, targetMoveToPos, existTimes / showTime);
			return;
		}
		ZumaGameManager.IsShowObj(base.transform, isShow: false);
		scoreMgr.scorePool.AddObject(this);
		isShow = false;
		if (isGold)
		{
			base.transform.localScale = Vector3.one;
		}
	}
}
