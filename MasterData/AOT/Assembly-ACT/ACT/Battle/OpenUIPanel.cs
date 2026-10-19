using System.Collections.Generic;
using ACT.UI;
using BehaviorDesigner.Runtime.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

[TaskCategory("ACT/待修改")]
public class OpenUIPanel : Action
{
	[Header("UI预制体addressable路径")]
	public string uiPath;

	public override void OnStart()
	{
		foreach (KeyValuePair<UI_TYPE, UIData> dICT_UI_DATum in CommonUIData.DICT_UI_DATA)
		{
			if (dICT_UI_DATum.Value.mobilePath.Equals(uiPath))
			{
				Singleton<NewUIManager>.instance.OpenUI(dICT_UI_DATum.Key);
				break;
			}
		}
	}
}
