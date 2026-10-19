using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Runtime.Model;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class RogueCollectInfo : MonoBehaviour
{
	public TextMeshProUGUI TextTitle;

	public GameObject Condition;

	public TextMeshProUGUI Target1Desc;

	public CommonNumberComponent CommonNumberComponent;

	public void Refresh(int dieMonsterCount)
	{
		Refresh(dieMonsterCount, (int)CommonNumberComponent.RightCount);
	}

	public void Refresh(int dieMonsterCount, int totalMonsterCount)
	{
		if (dieMonsterCount > totalMonsterCount)
		{
			dieMonsterCount = totalMonsterCount;
		}
		CommonNumberComponent.UpdateNumber(dieMonsterCount, totalMonsterCount);
	}

	public void UpdateTitle()
	{
		RogueMode data = CoreUtils.GetData(Model<RogueNewModel>.Interface.Info.GameInfo.ModeId, RuntimeConfigs.data.rogueModes);
		if (data != null)
		{
			string localizeString = LocalizationUtility.GetLocalizeString("shortcommon", data.name);
			TextTitle.text = localizeString + (Model<RogueNewModel>.Interface.Info.GameInfo.Index + 1) + "-" + data.mapNodeList.Length;
		}
	}
}
