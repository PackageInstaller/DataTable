using System.Threading.Tasks;
using UnityEngine;

namespace Ase;

public class UIStarGroup2 : MonoBehaviour
{
	[SerializeField]
	private Transform maxStarRect;

	[SerializeField]
	private Transform starBgLight;

	[SerializeField]
	private Transform fillStarRect;

	[SerializeField]
	private Transform loseStarRect;

	public int MaxCount;

	public int FillCount;

	public int LoseCount;

	public void SetStarCount(int maxCount, int fillCont, int loseCount)
	{
		SetMaxCount(maxCount);
		SetFillCount(fillCont);
		SetLostCount(loseCount);
	}

	private void SetMaxCount(int maxcount)
	{
		MaxCount = maxcount;
		int num;
		int num2;
		if (MaxCount == 1)
		{
			num = 3;
			num2 = 3;
		}
		else if (MaxCount == 3)
		{
			num = 1;
			num2 = 4;
		}
		else
		{
			if (MaxCount != 5)
			{
				Toast.ShowError("最大星星数不匹配！");
				return;
			}
			num = 0;
			num2 = 5;
		}
		for (int i = num; i < num2; i++)
		{
			maxStarRect.GetChild(i).gameObject.SetActive(value: true);
			starBgLight.GetChild(i).gameObject.SetActive(value: true);
		}
	}

	private void SetFillCount(int fillCount)
	{
		FillCount = fillCount;
		if (FillCount > MaxCount)
		{
			Toast.ShowError("当前星星数超过最大星星数！");
		}
		else if (MaxCount == 1)
		{
			fillStarRect.GetChild(2).gameObject.SetActive(value: true);
		}
		else if (MaxCount == 3)
		{
			for (int i = 1; i < FillCount + 1; i++)
			{
				fillStarRect.GetChild(i).gameObject.SetActive(value: true);
			}
		}
		else if (MaxCount == 5)
		{
			for (int j = 0; j < FillCount; j++)
			{
				fillStarRect.GetChild(j).gameObject.SetActive(value: true);
			}
		}
		else
		{
			Toast.ShowError("当前星星数不匹配！");
		}
	}

	private async void SetLostCount(int loseCount)
	{
		await Task.Delay(2500);
		LoseCount = ((loseCount > FillCount) ? FillCount : loseCount);
		if (loseCount <= 0)
		{
			return;
		}
		int num;
		if (MaxCount == 3)
		{
			num = 1;
		}
		else
		{
			if (MaxCount != 5)
			{
				Toast.ShowError("最大星星数不匹配！");
				return;
			}
			num = 0;
		}
		for (int num2 = FillCount - 1 + num; num2 >= FillCount - LoseCount + num; num2--)
		{
			loseStarRect.GetChild(num2).gameObject.SetActive(value: true);
			maxStarRect.GetChild(num2).gameObject.SetActive(value: false);
			starBgLight.GetChild(num2).gameObject.SetActive(value: false);
			fillStarRect.GetChild(num2).gameObject.SetActive(value: false);
		}
	}
}
