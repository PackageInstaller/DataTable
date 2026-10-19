using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class AbyssRewardTabItem : LoopScrollBaseItem
{
	public TextMeshProUGUI Name;

	public TextMeshProUGUI StageCount;

	public RedDotItem RedDotItem;

	public ActButton ItemButton;

	public GameObject Select;

	public AbyssData abyssConfig;

	private MonoAbyssRewardView monoAbyssRewardView;

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		abyssConfig = GetAbyssConfigByIndex(idx);
		if (abyssConfig == null)
		{
			return;
		}
		monoAbyssRewardView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_ABYSSREWARD) as MonoAbyssRewardView;
		if (monoAbyssRewardView == null)
		{
			return;
		}
		ItemButton.OnClick.RemoveAllListeners();
		ItemButton.OnClick.AddListener(() =>
		{
			OnItemToggleValueChanged(idx);
		});
		SetSelect(idx == monoAbyssRewardView.SelectTabIndex);
		Name.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, abyssConfig.abyssNameLocal);
		int num = 0;
		int num2 = abyssConfig.abyssGoal.Length + 1;
		for (int num3 = 0; num3 < num2; num3++)
		{
			if (Model<AbyssModel>.Interface.GetAbyssStage(idx).EvaluationClaimState.TryGetValue(num3 + 1, out var value) & value)
			{
				num++;
			}
		}
		StageCount.SetText("({0:0}/{1:0})", num, num2);
		RedDotItem.gameObject.SetActive(value: true);
		RedDotItem.redDotType = RedDotType.Dot;
		RedDotItem.fullPath = string.Format(RedDotPathDefine.HasAbyssRewardTab, Model<AbyssModel>.Interface.GroupId, idx).Split('|').ToList();
		RedDotItem.BindTrieNode();
		RedDotItem.UpdateDisplay();
	}

	private void OnItemToggleValueChanged(int idx)
	{
		SetSelect(value: true);
		monoAbyssRewardView.OnClickAbyssTabHandle(abyssConfig, idx);
	}

	public void SetSelect(bool value)
	{
		Select.SetActive(value);
	}

	private AbyssData GetAbyssConfigByIndex(int index)
	{
		int num = 0;
		foreach (KeyValuePair<int, AbyssData> abyssData in RuntimeConfigs.data.abyssDatas)
		{
			if (num == index)
			{
				return abyssData.Value;
			}
			num++;
		}
		return null;
	}
}
