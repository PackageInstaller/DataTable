using System.Collections.Generic;
using ACT.Model;
using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public class StartList : MonoBehaviour
{
	public List<GameObject> startList;

	private int starCount => startList.Count;

	public void BreakInit(int curStage)
	{
		for (int i = 0; i < starCount; i++)
		{
			IStar component = startList[i].GetComponent<IStar>();
			if (i < curStage)
			{
				component.CommonShow();
			}
			else if (i == curStage)
			{
				component.BreakToShow();
			}
			else
			{
				component.CommonHide();
			}
		}
	}

	public void QualityInit(int curQuality)
	{
		for (int i = 0; i < starCount; i++)
		{
			IStar component = startList[i].GetComponent<IStar>();
			if (i < curQuality)
			{
				component.CommonShow();
			}
			else
			{
				component.CommonHide();
			}
		}
	}

	public void QualityInit(int curQuality, bool flag)
	{
		for (int i = 0; i < starCount; i++)
		{
			IStar component = startList[i].GetComponent<IStar>();
			if (i == 0)
			{
				if (flag)
				{
					component.CommonShow();
				}
				else
				{
					component.CommonHide();
				}
				continue;
			}
			int num = (flag ? (curQuality - 1) : curQuality);
			if (i <= num)
			{
				component.CommonShow();
			}
			else
			{
				component.CommonHide();
			}
		}
	}

	public void SetElementActive(List<int> ids)
	{
		for (int i = 0; i < starCount; i++)
		{
			ElementStar component = startList[i].GetComponent<ElementStar>();
			if (ids.Contains(component.elementID))
			{
				component.CommonShow();
			}
			else
			{
				component.CommonHide();
			}
		}
		gameObject.SetActive(ids.Count > 0);
	}

	public void SoltInit(BloodBottleData bottle, ImageAssetStation station)
	{
		startList.ForEach((GameObject x) =>
		{
			if (!x.activeInHierarchy)
			{
				x.SetActive(value: true);
			}
		});
		int maxSoltCount = bottle.maxSoltCount;
		if (maxSoltCount == 0)
		{
			gameObject.SetActive(value: false);
			return;
		}
		for (int num = starCount; num > 0; num--)
		{
			if (num > maxSoltCount)
			{
				startList[num - 1].gameObject.SetActive(value: false);
			}
		}
		for (int num2 = 0; num2 < bottle.wineMaterialSlots.Count; num2++)
		{
			BottleMaterialSlot bottleMaterialSlot = bottle.wineMaterialSlots[num2];
			BloodBottleSlot component = startList[num2].GetComponent<BloodBottleSlot>();
			int id = GetSlotStateImageIdByType(bottleMaterialSlot.curState, bottleMaterialSlot.types[0]);
			station.LoadImage(component.ConfigId, id, component.icon);
		}
		static int GetIconIdByMatType(BottleMatType _type)
		{
			return _type switch
			{
				BottleMatType.Yellow => 10, 
				BottleMatType.Blue => 20, 
				BottleMatType.Green => 30, 
				BottleMatType.Purple => 40, 
				_ => 0, 
			};
		}
		static int GetSlotStateImageIdByType(SlotState slotState, BottleMatType _type)
		{
			return slotState switch
			{
				SlotState.IsLock => GetIconIdByMatType(_type) + 2, 
				SlotState.Empty => GetIconIdByMatType(_type), 
				SlotState.Filled => GetIconIdByMatType(_type) + 1, 
				_ => 0, 
			};
		}
	}
}
