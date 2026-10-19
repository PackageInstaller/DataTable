using System;
using ACT.Config;
using ACT.Core;
using ACT.RichText;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace Runtime.UI.ViewComponent.CharacterViewV3.SkillUI;

public class SkillLevelUpPropertyCell : BaseUIComponent
{
	[SerializeField]
	private SkillLevelUpPropertyInfoTemplate m_InfoTemplate;

	[SerializeField]
	private LocalizeStringEvent m_TitleText;

	[SerializeField]
	private Transform m_SkillsContainer;

	[SerializeField]
	public BetterAnimation animation;

	private static ObjectPoolStack<SkillLevelUpPropertyInfoTemplate> m_SkillPool = new ObjectPoolStack<SkillLevelUpPropertyInfoTemplate>(null);

	public int SkillId { get; private set; }

	public int SkillMessageId { get; private set; }

	public void Init(int level)
	{
		Init(SkillMessageId, level, -1);
	}

	public void Init(int skillMessageId, int from, int to)
	{
		SkillMessageId = skillMessageId;
		for (int num = m_SkillsContainer.childCount - 1; num >= 0; num--)
		{
			GameObject gameObject = m_SkillsContainer.GetChild(num).gameObject;
			gameObject.transform.SetParent(m_SkillsContainer.parent);
			gameObject.SetActive(value: false);
			m_SkillPool.Push(gameObject.GetComponent<SkillLevelUpPropertyInfoTemplate>());
		}
		SkillDetailMessageData data = CoreUtils.GetData(skillMessageId, RuntimeConfigs.data.skillDetailMessageDatas);
		if (data == null)
		{
			return;
		}
		if (data.detailDescLocal == 0)
		{
			base.gameObject.SetActive(value: false);
			return;
		}
		base.gameObject.SetActive(value: true);
		SkillId = data.skillid;
		m_TitleText.StringReference.TableEntryReference = data.nameLocal;
		string[] array = LocalizationUtility.GetLocalizeString("longcommon", data.detailDescLocal, isSmart: false).Split("<br>", StringSplitOptions.RemoveEmptyEntries);
		int num2 = 0;
		for (int i = 0; i < array.Length; i++)
		{
			string[] array2 = array[i].TrimStart('\n').Split("<name>", StringSplitOptions.RemoveEmptyEntries);
			if (array2.Length != 2)
			{
				Debug.Log($"单一技能详细描述必须有且只有一个<name>标签！skillDetailMessageID {skillMessageId} 对应的第{i + 1}个详细技能描述有问题!");
				continue;
			}
			string text = array2[0];
			string text2 = array2[1];
			if (!IsPreviewBlank(text) || !IsPreviewBlank(text2))
			{
				string title = (IsPreviewBlank(text) ? string.Empty : CustomTagParser.ReplaceText(SkillId, text, from));
				text2 = (IsPreviewBlank(text2) ? string.Empty : text2);
				SkillLevelUpPropertyInfoTemplate skillLevelUpPropertyInfoTemplate = null;
				if (m_SkillPool.Count > 0)
				{
					skillLevelUpPropertyInfoTemplate = m_SkillPool.Pop();
					skillLevelUpPropertyInfoTemplate.transform.SetParent(m_SkillsContainer, worldPositionStays: false);
				}
				else
				{
					skillLevelUpPropertyInfoTemplate = UnityEngine.Object.Instantiate(m_InfoTemplate, m_SkillsContainer);
				}
				skillLevelUpPropertyInfoTemplate.gameObject.SetActive(value: true);
				skillLevelUpPropertyInfoTemplate.Init(SkillId, title, text2, from, to);
				num2++;
			}
		}
		base.gameObject.SetActive(num2 > 0);
	}

	private static bool IsPreviewBlank(string value)
	{
		if (!string.IsNullOrWhiteSpace(value))
		{
			return value.Equals("<nbsp>", StringComparison.Ordinal);
		}
		return true;
	}
}
