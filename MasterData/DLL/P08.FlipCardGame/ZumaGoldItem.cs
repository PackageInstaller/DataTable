using System;
using System.Collections.Generic;
using UnityEngine;
using ZumaGame;

public class ZumaGoldItem : MonoBehaviour
{
	public float existTimes;

	public float fadeTimes;

	public float nextShowTime = 1f;

	public bool isShow;

	private Vector3 hidePos = new Vector3(999f, 999f, 0f);

	private float xRadiusLeft = -2.2f;

	private float xRadiusRight = 2.2f;

	private float yRadiusTop = 0.8f;

	private float yRadiusBottom = -1.1f;

	[NonSerialized]
	public float width = 0.1f;

	[NonSerialized]
	public float height = 0.15f;

	public ZumaAnimator zumaAnimator;

	private Dictionary<int, bool> posIsCanNotUseDict = new Dictionary<int, bool>();

	private List<int> canUseListX = new List<int>();

	private List<int> canUseListY = new List<int>();

	public FrameSprite fs1;

	public FrameSprite fs2;

	private Vector3 usePos = new Vector3(0f, 0f, 0f);

	public void Init()
	{
		Hide();
		InitRandomPos();
		SetFrameSprite();
	}

	private void SetFrameSprite()
	{
		FrameSprite fs = ((ZumaGameManager.difficult != 1) ? fs2 : fs1);
		zumaAnimator.ChangeFrameList(fs);
	}

	public void Process()
	{
		if (!isShow)
		{
			fadeTimes += Time.deltaTime;
			if (fadeTimes >= nextShowTime)
			{
				Show();
			}
		}
		else
		{
			existTimes += Time.deltaTime;
			if (existTimes >= 10f)
			{
				Hide();
			}
		}
	}

	public void TriggerCollision()
	{
		ZumaAudioManager.Instance.PlayZumaAudio(ZumaAudioEnum.GoldHit);
		ZumaGameManager.GetInstance().SetZumaGameScore(base.transform.position, ZumaGameConst.goldScore, isGold: true);
		Hide();
	}

	private void Show()
	{
		isShow = true;
		existTimes = 0f;
		fadeTimes = 0f;
		base.transform.position = RandomCountGoldPos();
	}

	private void Hide()
	{
		isShow = false;
		existTimes = 0f;
		fadeTimes = 0f;
		nextShowTime = UnityEngine.Random.Range(20, 31);
		base.transform.position = hidePos;
	}

	public void SetPosDict(int x, int y)
	{
		int key = x * 100 + y;
		if (!posIsCanNotUseDict.ContainsKey(key))
		{
			posIsCanNotUseDict[key] = true;
		}
	}

	public bool GetPosDict(int x, int y)
	{
		int key = x * 100 + y;
		if (posIsCanNotUseDict.ContainsKey(key))
		{
			return true;
		}
		return false;
	}

	public void SetPosList(int x, int y)
	{
		canUseListX.Add(x);
		canUseListY.Add(y);
	}

	public void InitRandomPos()
	{
		int trackCount = ZumaGameManager.GetInstance().GetTrackCount();
		for (int i = 0; i < trackCount; i++)
		{
			ZumaTrackData trackData = ZumaGameManager.GetInstance().GetTrackData(i);
			int count = trackData.ballPosList.Count;
			for (int j = 0; j < count; j++)
			{
				Vector3 vector = trackData.ballPosList[j];
				int num = (int)Mathf.Round(vector.x / width);
				int num2 = (int)Mathf.Round(vector.y / height);
				SetPosDict(num, num2);
				SetPosDict(num, num2 + 1);
				SetPosDict(num, num2 - 1);
				SetPosDict(num - 1, num2);
				SetPosDict(num - 1, num2 + 1);
				SetPosDict(num - 1, num2 - 1);
				SetPosDict(num + 1, num2);
				SetPosDict(num + 1, num2 + 1);
				SetPosDict(num + 1, num2 - 1);
			}
		}
		Vector3 shootPos = ZumaGameManager.GetInstance().shootPos;
		int num3 = (int)Mathf.Round(shootPos.x / width);
		int num4 = (int)Mathf.Round(shootPos.y / height);
		for (int k = num3 - 3; k <= num3 + 3; k++)
		{
			for (int l = num4 - 3; l <= num4 + 3; l++)
			{
				SetPosDict(k, l);
			}
		}
		int num5 = (int)Mathf.Round(xRadiusLeft / width);
		int num6 = (int)Mathf.Round(xRadiusRight / width);
		int num7 = (int)Mathf.Round(yRadiusBottom / height);
		int num8 = (int)Mathf.Round(yRadiusTop / height);
		for (int m = num5; m <= num6; m++)
		{
			for (int n = num7; n <= num8; n++)
			{
				if (!GetPosDict(m, n))
				{
					SetPosList(m, n);
				}
			}
		}
	}

	public Vector3 RandomCountGoldPos()
	{
		int count = canUseListX.Count;
		int index = UnityEngine.Random.Range(0, count - 1);
		int num = canUseListX[index];
		int num2 = canUseListY[index];
		usePos.x = (float)num * width;
		usePos.y = (float)num2 * height;
		return usePos;
	}
}
