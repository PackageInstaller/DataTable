#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public class UICooling : ViewModelBase
{
	private List<PropertyCooling> propertyCoolings;

	private PropertyCooling propertyCooling;

	private bool hasCooling;

	private string outlinePropertyName;

	private float outlineCur;

	private float outlineMax;

	private Color outlineShowVal1;

	private Color outlineShowVal2;

	private Color outlineCurColor;

	private bool isShowOutline;

	private int checkMode;

	public string OutlinePropertyName
	{
		get
		{
			return outlinePropertyName;
		}
		private set
		{
			Set(ref outlinePropertyName, value, "OutlinePropertyName");
		}
	}

	public Color OutlineCurColor
	{
		get
		{
			return outlineCurColor;
		}
		private set
		{
			Set(ref outlineCurColor, value, "OutlineCurColor");
		}
	}

	public bool IsShowOutline
	{
		get
		{
			return isShowOutline;
		}
		private set
		{
			Set(ref isShowOutline, value, "IsShowOutline");
		}
	}

	public PropertyCooling PropertyCooling
	{
		get
		{
			return propertyCooling;
		}
		private set
		{
			Set(ref propertyCooling, value, "PropertyCooling");
		}
	}

	public UICooling()
	{
		propertyCoolings = new List<PropertyCooling>();
	}

	public void AddCondition(List<CoolingBase> coolingBases)
	{
		if (coolingBases == null)
		{
			hasCooling = false;
		}
		for (int i = 0; i < coolingBases.Count; i++)
		{
			propertyCoolings.Add((PropertyCooling)coolingBases[i]);
		}
		if (propertyCoolings.Count > 0)
		{
			PropertyCooling = propertyCoolings[0];
		}
		hasCooling = true;
	}

	public void Update()
	{
		if (propertyCoolings == null || propertyCoolings.Count == 0 || !hasCooling)
		{
			return;
		}
		bool flag = false;
		for (int i = 0; i < propertyCoolings.Count; i++)
		{
			propertyCoolings[i].Update();
			if (checkMode == 0 && !propertyCoolings[i].Check())
			{
				PropertyCooling = propertyCoolings[i];
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			PropertyCooling = propertyCoolings[0];
		}
		if (isShowOutline && outlineMax != 0f)
		{
			outlineCur = (PropertyCooling.Entity?.Property[OutlinePropertyName]?.CurValue).GetValueOrDefault();
			OutlineCurColor = (outlineShowVal2 - outlineShowVal1) * (outlineCur / outlineMax) + outlineShowVal1;
		}
	}

	public void AddCoolingShow(string condition)
	{
		if (string.IsNullOrEmpty(condition) || propertyCoolings == null || propertyCoolings.Count == 0)
		{
			return;
		}
		try
		{
			string[][] array = JsonConvert.DeserializeObject<string[][]>(condition);
			int num = 0;
			if (num < array.Length)
			{
				string[] array2 = array[num];
				OutlinePropertyName = array2[0];
				IsShowOutline = true;
				outlineMax = (propertyCooling.Entity?.Property[OutlinePropertyName]?.MaxValue).GetValueOrDefault();
				ColorUtility.TryParseHtmlString(array2[1], out outlineShowVal1);
				ColorUtility.TryParseHtmlString(array2[2], out outlineShowVal2);
				OutlineCurColor = outlineShowVal1;
			}
		}
		catch (Exception ex)
		{
			Log.Error("HeroSKillInfo - OuterBorder字段配置有误！ " + ex.StackTrace);
		}
	}

	protected override void Dispose(bool disposing)
	{
	}
}
