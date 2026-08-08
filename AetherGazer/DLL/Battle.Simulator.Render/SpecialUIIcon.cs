using System.Collections.Generic;
using UnityEngine;

public class SpecialUIIcon : MonoBehaviour
{
	public List<GameObject> gameObjects = new List<GameObject>();

	public void ChangeAIcon(bool isEnable)
	{
		if (isEnable)
		{
			for (int i = 0; i < gameObjects.Count; i++)
			{
				if (gameObjects[i].activeSelf != isEnable)
				{
					gameObjects[i].SetActive(isEnable);
					break;
				}
			}
			return;
		}
		for (int num = gameObjects.Count - 1; num >= 0; num--)
		{
			if (gameObjects[num].activeSelf != isEnable)
			{
				gameObjects[num].SetActive(isEnable);
				break;
			}
		}
	}

	public void Clear(bool isEnable)
	{
		for (int i = 0; i < gameObjects.Count; i++)
		{
			if (gameObjects[i].activeSelf != isEnable)
			{
				gameObjects[i].SetActive(isEnable);
			}
		}
	}

	public bool SetTargetIcon(int index, bool isEnable)
	{
		if (index >= gameObjects.Count)
		{
			return false;
		}
		if (gameObjects[index].activeSelf != isEnable)
		{
			gameObjects[index].SetActive(isEnable);
		}
		return true;
	}

	public void SetIconEnableOfRange(int startIndex, int range, int enableCount)
	{
		if (startIndex >= gameObjects.Count)
		{
			return;
		}
		for (int i = 0; i < range; i++)
		{
			int num = startIndex + i;
			if (num >= gameObjects.Count)
			{
				break;
			}
			bool flag = i < enableCount;
			if (gameObjects[num].activeSelf != flag)
			{
				gameObjects[num].SetActive(flag);
			}
		}
	}

	public void SetTargetIconInRange(int startIndex, int range, int index)
	{
		if (startIndex >= gameObjects.Count)
		{
			return;
		}
		for (int i = 0; i < range; i++)
		{
			int num = startIndex + i;
			if (num >= gameObjects.Count)
			{
				break;
			}
			gameObjects[num].SetActive(i == index);
		}
	}
}
