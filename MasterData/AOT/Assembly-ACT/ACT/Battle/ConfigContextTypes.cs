using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

public class ConfigContextTypes : ScriptableObject
{
	public string[] contextTypes;

	public string[] viewcontextTypes;

	public void Clac(string res)
	{
		if (string.IsNullOrEmpty(res))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("不要传空参");
			}
			return;
		}
		for (int i = 0; i < contextTypes.Length; i++)
		{
			if (contextTypes[i] == res)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("不能新增名字一样的点,\t" + res + "点已经有了");
				}
				return;
			}
		}
		List<string> list = new List<string>(contextTypes);
		list.Add(res);
		contextTypes = list.ToArray();
		viewcontextTypes = new string[contextTypes.Length];
		Array.Copy(contextTypes, viewcontextTypes, contextTypes.Length);
	}
}
