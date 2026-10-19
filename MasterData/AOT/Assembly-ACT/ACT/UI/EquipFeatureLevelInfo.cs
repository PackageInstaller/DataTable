using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.RichText;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.Localization.Tables;
using UnityEngine.ResourceManagement.AsyncOperations;

namespace ACT.UI;

public class EquipFeatureLevelInfo : BaseUIComponent
{
	[SerializeField]
	private GameObject m_UnSelectedDot;

	[SerializeField]
	private GameObject m_SelectedDot;

	[SerializeField]
	private TMP_Text m_LV;

	[SerializeField]
	private TMP_Text m_LevelNumber;

	[SerializeField]
	private TMP_Text m_LevelNumberTens;

	[SerializeField]
	private TMP_Text m_LevelDescriptionText;

	[SerializeField]
	private LocalizeStringEvent m_LevelDescription;

	public BetterAnimation betterAnimation;

	public void Init(int skillGroupLevelID, int currentLevel, bool isOn)
	{
		SkillGroupLevelData data = CoreUtils.GetData(skillGroupLevelID, RuntimeConfigs.data.skillGroupLevelDatas);
		if (data == null)
		{
			return;
		}
		SkillDetailMessageData messageData = CoreUtils.GetData(data.skillDes.FirstOrDefault(), RuntimeConfigs.data.skillDetailMessageDatas);
		if (messageData == null)
		{
			return;
		}
		gameObject.SetActive(value: true);
		AsyncOperationHandle<StringTable> tableAsync = LocalizationSettings.StringDatabase.GetTableAsync("longcommon");
		tableAsync.Completed += (AsyncOperationHandle<StringTable> l) =>
		{
			StringTableEntry entry = l.Result.GetEntry(messageData.briefDescLocal);
			if (entry != null)
			{
				entry.IsSmart = false;
				string arg = CustomTagParser.ReplaceText(messageData.skillid, entry.GetLocalizedString(), currentLevel);
				m_LevelDescription.OnUpdateString?.Invoke(arg);
			}
			else
			{
				_ = LuminApplication.LogEnabled;
			}
		};
		m_LevelNumber.SetText(currentLevel.FastToString());
		m_SelectedDot.SetActive(isOn);
		m_UnSelectedDot.SetActive(!isOn);
		ColorUtility.TryParseHtmlString(isOn ? "#FFFFFF" : "#A2AAAB", out var color);
		m_LV.color = color;
		m_LevelNumber.color = color;
		if (m_LevelNumberTens != null)
		{
			m_LevelNumberTens.color = color;
		}
		m_LevelDescriptionText.color = color;
		betterAnimation?.GetSequence("Show").Goto(0f).SetDelay((float)(currentLevel - 1) * 0.03f)
			.Play();
	}

	public void UnInit()
	{
		gameObject.SetActive(value: false);
	}
}
