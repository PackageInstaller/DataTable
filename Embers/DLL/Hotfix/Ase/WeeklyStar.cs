#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class WeeklyStar : MonoBehaviour
{
	[SerializeField]
	private List<Sprite> fullStarColor;

	[SerializeField]
	private List<Sprite> fullStarBgColor;

	[SerializeField]
	private List<Image> fullStarBgRect;

	[SerializeField]
	private List<Image> fullStarRect;

	private int curCount = -1;

	private int maxCount = -1;

	public int CurCount
	{
		get
		{
			return curCount;
		}
		set
		{
			curCount = value;
			SetCur();
		}
	}

	public int MaxCount
	{
		get
		{
			return maxCount;
		}
		set
		{
			maxCount = value;
			SetMax();
		}
	}

	private void SetCur()
	{
		if (fullStarBgRect == null || fullStarRect == null)
		{
			Log.Error("副本星星组件配置异常。请检查！");
			return;
		}
		for (int i = 0; i < fullStarRect.Count; i++)
		{
			if (i < curCount)
			{
				fullStarRect[i].gameObject.SetActive(value: true);
			}
			else
			{
				fullStarRect[i].gameObject.SetActive(value: false);
			}
		}
	}

	private void SetMax()
	{
		if (fullStarBgRect == null)
		{
			Log.Error("副本星星组件配置异常。请检查！");
			return;
		}
		for (int i = 0; i < fullStarBgRect.Count; i++)
		{
			if (i < maxCount)
			{
				fullStarBgRect[i].gameObject.SetActive(value: true);
			}
			else
			{
				fullStarBgRect[i].gameObject.SetActive(value: false);
			}
		}
	}
}
