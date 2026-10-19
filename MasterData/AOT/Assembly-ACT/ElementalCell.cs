using System.Collections.Generic;
using ACT.Core;
using UnityEngine;

public class ElementalCell : MonoBehaviour
{
	public List<GameObject> StarList;

	public List<GameObject> LevelList;

	public Element element;

	private void Start()
	{
	}

	public void Init(int count)
	{
		if (count > 0)
		{
			for (int i = 0; i < LevelList.Count; i++)
			{
				LevelList[i].SetActive(count - 1 == i);
			}
			for (int j = 0; j < StarList.Count; j++)
			{
				StarList[j].SetActive(count - 1 >= j);
			}
		}
		else
		{
			for (int k = 0; k < LevelList.Count; k++)
			{
				LevelList[k].SetActive(k == 0);
			}
			for (int l = 0; l < StarList.Count; l++)
			{
				StarList[l].SetActive(value: false);
			}
		}
	}

	private void Update()
	{
	}
}
