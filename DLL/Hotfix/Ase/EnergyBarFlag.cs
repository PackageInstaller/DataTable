#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class EnergyBarFlag : MonoBehaviour
{
	[SerializeField]
	private HorizontalLayoutGroup hlg;

	private int maxVal;

	[SerializeField]
	private int interVal;

	[SerializeField]
	private int maxLength;

	private List<GameObject> flags;

	public int MaxVal
	{
		get
		{
			return maxVal;
		}
		set
		{
			maxVal = value;
		}
	}

	private void Start()
	{
		int childCount = hlg.transform.childCount;
		if (childCount < 2)
		{
			Log.Error("EnergyBarFlag组件配置异常");
		}
		flags = new List<GameObject>();
		for (int i = 1; i < childCount; i++)
		{
			flags.Add(hlg.transform.GetChild(i).gameObject);
		}
		SetHLGSpacing();
	}

	public void SetHLGSpacing()
	{
		int num = maxVal / interVal;
		if (interVal * num == maxVal)
		{
			num--;
		}
		float spacing = (float)interVal * 1f / (float)maxVal * (float)maxLength;
		hlg.spacing = spacing;
		if (num >= flags.Count)
		{
			Log.Error("EnergyBarFlag组件配置异常，flag数量不够");
		}
		for (int i = 0; i < flags.Count; i++)
		{
			if (i < num && !flags[i].activeSelf)
			{
				flags[i].SetActive(value: true);
			}
			if (i >= num && flags[i].activeSelf)
			{
				flags[i].SetActive(value: false);
			}
		}
	}
}
