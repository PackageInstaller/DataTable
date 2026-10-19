using System.Text.RegularExpressions;
using ACT.Core;
using ACT.RichText;
using ACT.UI;
using TMPro;
using UnityEngine;

namespace Runtime.UI.ViewComponent.CharacterViewV3.SkillUI;

public class SkillLevelUpPropertyInfoTemplate : BaseUIComponent
{
	[SerializeField]
	private TMP_Text m_Title;

	[Header("对比样式")]
	[SerializeField]
	private GameObject m_MulRoot;

	[SerializeField]
	private TMP_Text m_MulFromText;

	[SerializeField]
	private TMP_Text m_MulToText;

	[Header("单个样式")]
	[SerializeField]
	private GameObject m_SingleRoot;

	[SerializeField]
	private TMP_Text m_SingleText;

	[Header("提升相关")]
	[SerializeField]
	private Color promoteColor;

	[SerializeField]
	private GameObject effectRoot;

	private Color m_OriginalColor;

	private void Awake()
	{
		m_OriginalColor = m_MulToText.color;
	}

	public void Init(int skillId, string title, string inputRichText, int fromLv, int toLv)
	{
		if (CoreUtils.GetData(skillId, RuntimeConfigs.data.skillDetailDatas) == null)
		{
			return;
		}
		m_Title.SetText(title);
		if (toLv != -1)
		{
			m_MulRoot.SetActive(value: true);
			m_SingleRoot.SetActive(value: false);
			string text = CustomTagParser.ReplaceText(skillId, inputRichText, fromLv);
			string text2 = CustomTagParser.ReplaceText(skillId, inputRichText, toLv);
			m_MulFromText.SetText(text);
			m_MulToText.SetText(text2);
			float firstNumberInString = GetFirstNumberInString(text);
			if (GetFirstNumberInString(text2) > firstNumberInString)
			{
				m_MulToText.color = promoteColor;
				effectRoot.SetActive(value: true);
			}
			else
			{
				m_MulToText.color = m_OriginalColor;
				effectRoot.SetActive(value: true);
			}
		}
		else
		{
			m_MulRoot.SetActive(value: false);
			m_SingleRoot.SetActive(value: true);
			m_SingleText.SetText(CustomTagParser.ReplaceText(skillId, inputRichText, fromLv));
		}
	}

	private float GetFirstNumberInString(string input)
	{
		Match match = Regex.Match(input, "[-+]?\\d+\\.?\\d*|\\.\\d+");
		if (match.Success)
		{
			return float.Parse(match.Value);
		}
		return -1f;
	}
}
