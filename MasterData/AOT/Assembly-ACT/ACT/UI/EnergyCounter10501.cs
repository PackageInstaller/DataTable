using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class EnergyCounter10501 : MonoBehaviour
{
	[SerializeReference]
	private List<GameObject> lights;

	[SerializeReference]
	private GameObject dissolveRoot;

	[SerializeReference]
	private Image dissolveImage;

	public void Init(float curVal, float min, float max)
	{
		Reset();
		UpdateCount(curVal, min, max);
	}

	public void Reset()
	{
		ClearCount();
		dissolveRoot.SetActive(value: false);
	}

	public void UpdateCount(float curVal, float min, float max)
	{
		float num = (max - min) / (float)lights.Count;
		int num2 = Mathf.FloorToInt((curVal - min) / num);
		for (int i = 0; i < lights.Count; i++)
		{
			lights[i].SetActive(i < num2);
		}
	}

	public void ClearCount()
	{
		foreach (GameObject light in lights)
		{
			light.SetActive(value: false);
		}
	}

	public void Full()
	{
		dissolveRoot.SetActive(value: true);
	}

	public void UpdateDissolve(float percent)
	{
		dissolveImage.material.SetFloat("_Cut", 1f - percent);
	}
}
