using System.Collections.Generic;
using UnityEngine;

public class SkinQualityComponent : MonoBehaviour
{
	public List<GameObject> SkinForeQualityList = new List<GameObject>();

	public List<GameObject> SkinBlackoreQualityList = new List<GameObject>();

	private void Start()
	{
	}

	public void SetSkinQuality(int quality)
	{
		for (int i = 0; i < SkinForeQualityList.Count; i++)
		{
			SkinForeQualityList[i].SetActive(quality - 1 == i);
		}
		for (int j = 0; j < SkinBlackoreQualityList.Count; j++)
		{
			SkinBlackoreQualityList[j].SetActive(quality - 1 == j);
		}
	}

	private void Update()
	{
	}
}
