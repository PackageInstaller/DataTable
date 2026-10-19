using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class SystemUnlockItem : LoopScrollBaseItem
{
	[SerializeField]
	private Image _diban1;

	[SerializeField]
	private Image _diban2;

	[SerializeField]
	private Image _weiwanchengIcon;

	[SerializeField]
	private Image _completeIcon;

	[SerializeField]
	private TextMeshProUGUI _systemOpenText;

	[SerializeField]
	private LocalizeStringEvent _systemName;

	[SerializeField]
	private TextMeshProUGUI _systemNameText;

	public override void ScrollCellIndex(int idx)
	{
		gameObject.SetActive(value: true);
		index = idx;
		int currentSelectWorldLevel = Model<WorldLevelModel>.Interface.CurrentSelectWorldLevel;
		List<int> worldLevelOpenSystemIdList = Model<WorldLevelModel>.Interface.GetWorldLevelOpenSystemIdList(currentSelectWorldLevel);
		if (index >= 0 && index < worldLevelOpenSystemIdList.Count)
		{
			SystemOpen data = CoreUtils.GetData(worldLevelOpenSystemIdList[index], RuntimeConfigs.data.systemOpens);
			_systemOpenText.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2187);
			_systemName.StringReference.TableEntryReference = data.localNameId;
			bool flag = Model<WorldLevelModel>.Interface.GetCurWorldLevel() >= currentSelectWorldLevel;
			_diban1.gameObject.SetActive(!flag);
			_weiwanchengIcon.gameObject.SetActive(!flag);
			_diban2.gameObject.SetActive(flag);
			_completeIcon.gameObject.SetActive(flag);
			ColorUtility.TryParseHtmlString(flag ? Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.BrightChartreuse) : Model<WorldLevelModel>.Interface.GetTextColorString(WorldLevelColorEnum.Dark), out var color);
			_systemOpenText.color = color;
			_systemNameText.color = color;
		}
	}
}
