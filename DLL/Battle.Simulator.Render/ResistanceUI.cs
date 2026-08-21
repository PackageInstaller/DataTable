using System.Collections.Generic;
using UnityEngine;

public class ResistanceUI : MonoBehaviour
{
	public List<ResistanceUIItem> resistanceUIItems = new List<ResistanceUIItem>();

	public ResistanceUIProg resistanceUIProg;

	public List<ResistanceUIElementData> resistanceUIElementDatas = new List<ResistanceUIElementData>();

	public Sprite defaultSprite;

	public Sprite defaultSpriteProg;

	private Dictionary<int, ResistanceUIElementData> resistanceUIElementDict;

	private void Awake()
	{
		resistanceUIElementDict = new Dictionary<int, ResistanceUIElementData>();
		for (int i = 0; i < resistanceUIElementDatas.Count; i++)
		{
			ResistanceUIElementData value = resistanceUIElementDatas[i];
			resistanceUIElementDict[value.elementID] = value;
		}
	}

	private void SetActive(ResistanceUIItem item, bool flag)
	{
		if (item.bg != null && item.bg.enabled != flag)
		{
			item.bg.enabled = flag;
		}
		if (item.light != null && item.light.enabled != flag)
		{
			item.light.enabled = flag;
		}
	}

	private void SetActive(ResistanceUIProg prog, bool flag)
	{
		if (prog.bg != null && prog.bg.enabled != flag)
		{
			prog.bg.enabled = flag;
		}
		if (prog.progress != null && prog.progress.enabled != flag)
		{
			prog.progress.enabled = flag;
		}
		if (prog.elementImage != null && prog.elementImage.enabled != flag)
		{
			prog.elementImage.enabled = flag;
		}
	}

	private void SetResistanceUIProg(int curTime, int maxTime, int stateElement)
	{
		if (resistanceUIProg.slider != null && maxTime != 0)
		{
			resistanceUIProg.slider.SetDuration(0f, (float)curTime / (float)maxTime);
		}
		if (resistanceUIElementDict != null)
		{
			bool flag = resistanceUIElementDict.TryGetValue(stateElement, out var value);
			Sprite sprite = defaultSprite;
			Sprite spriteProg = defaultSpriteProg;
			Color color = Color.white;
			if (flag)
			{
				sprite = value.sprite;
				spriteProg = value.spriteProg;
				color = value.color;
			}
			if (sprite != null && resistanceUIProg.elementImage != null && resistanceUIProg.elementImage.sprite != sprite)
			{
				resistanceUIProg.elementImage.sprite = sprite;
				resistanceUIProg.elementImage.enabled = true;
			}
			else if ((sprite == null || !flag) && resistanceUIProg.elementImage != null)
			{
				resistanceUIProg.elementImage.enabled = false;
			}
			if (spriteProg != null && resistanceUIProg.progress.sprite != spriteProg)
			{
				resistanceUIProg.progress.sprite = spriteProg;
			}
			if (resistanceUIProg.progress.color != color)
			{
				resistanceUIProg.progress.color = color;
			}
		}
	}

	private void SetResistanceUIItems(int curValue, int maxValue, List<int> pointElements)
	{
		for (int i = 0; i < resistanceUIItems.Count; i++)
		{
			if (i >= maxValue)
			{
				SetActive(resistanceUIItems[i], flag: false);
				continue;
			}
			SetActive(resistanceUIItems[i], flag: true);
			if (i >= curValue)
			{
				if (resistanceUIItems[i].light != null && resistanceUIItems[i].light.enabled)
				{
					resistanceUIItems[i].light.enabled = false;
				}
			}
			else if (pointElements != null && pointElements.Count > i && resistanceUIElementDict != null)
			{
				int key = pointElements[i];
				bool num = resistanceUIElementDict.TryGetValue(key, out var value);
				Sprite sprite = defaultSprite;
				if (num)
				{
					sprite = value.sprite;
				}
				if (sprite != null && resistanceUIItems[i].light.sprite != sprite)
				{
					resistanceUIItems[i].light.sprite = sprite;
				}
			}
		}
	}

	public void SetResistanceUI(bool reState, int curTime, int maxTime, int curValue, int maxValue, int stateElement, List<int> pointElements)
	{
		if (reState)
		{
			for (int i = 0; i < resistanceUIItems.Count; i++)
			{
				SetActive(resistanceUIItems[i], flag: false);
			}
			SetActive(resistanceUIProg, flag: true);
			SetResistanceUIProg(curTime, maxTime, stateElement);
		}
		else
		{
			SetActive(resistanceUIProg, flag: false);
			SetResistanceUIItems(curValue, maxValue, pointElements);
		}
	}

	public void Hide()
	{
		for (int i = 0; i < resistanceUIItems.Count; i++)
		{
			SetActive(resistanceUIItems[i], flag: false);
		}
		SetActive(resistanceUIProg, flag: false);
	}
}
