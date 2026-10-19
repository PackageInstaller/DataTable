using ACT.Config;
using ACT.Core;
using ACT.UI.CommonComponent;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;

namespace ACT.UI;

public class CharacterAttributePropertyCell : BaseUIComponent
{
	[SerializeField]
	private BImage m_Icon;

	[SerializeField]
	private LocalizeStringEvent m_PropertyName;

	[SerializeField]
	private Color m_NormalColor;

	[SerializeField]
	private Color m_PromoteColor;

	[FormerlySerializedAs("mCommonHelpButton")]
	[SerializeField]
	private CommonHelpButton m_CommonHelpButton;

	[Header("有 基础数值 样式")]
	[SerializeField]
	private GameObject m_BaseValueRoot;

	[SerializeField]
	private TMP_Text m_BaseValueText;

	[SerializeField]
	private GameObject m_AddValueRoot;

	[SerializeField]
	private TMP_Text m_AddValueText;

	[Header("无 基础数值 样式")]
	[SerializeField]
	private GameObject m_Add2ValueRoot;

	[SerializeField]
	private TMP_Text m_Add2ValueText;

	public void Init(int propertyID, float baseValue, float addValue)
	{
		Station.LoadImageAsync(146, propertyID, m_Icon).Forget();
		m_Add2ValueRoot.SetActive(value: false);
		m_BaseValueRoot.SetActive(value: true);
		m_AddValueRoot.SetActive(value: true);
		PropertyData data = CoreUtils.GetData(propertyID, RuntimeConfigs.data.propertyDatas);
		if (data != null)
		{
			m_PropertyName.StringReference.TableEntryReference = data.descLocal;
			string text = FormatPropertyValue(baseValue, data.judge);
			m_BaseValueText.text = text;
			string text2 = FormatPropertyValue(addValue, data.judge);
			m_AddValueText.text = "+" + text2;
			m_AddValueText.color = m_PromoteColor;
			m_AddValueRoot.SetActive(!IsZero(text2));
			SetHelpButton(propertyID);
		}
	}

	public void Init(int propertyID, float addValue)
	{
		Station.LoadImageAsync(146, propertyID, m_Icon).Forget();
		m_Add2ValueRoot.SetActive(value: true);
		m_BaseValueRoot.SetActive(value: false);
		m_AddValueRoot.SetActive(value: false);
		PropertyData data = CoreUtils.GetData(propertyID, RuntimeConfigs.data.propertyDatas);
		if (data != null)
		{
			m_PropertyName.StringReference.TableEntryReference = data.descLocal;
			string text = FormatPropertyValue(addValue, data.judge);
			m_Add2ValueText.SetText("+" + text);
			m_Add2ValueText.color = (IsZero(text) ? m_NormalColor : m_PromoteColor);
			SetHelpButton(propertyID);
		}
	}

	public void SetHelpButtonGroup(ActToggleGroup group)
	{
		if ((bool)m_CommonHelpButton)
		{
			m_CommonHelpButton.Group = group;
		}
	}

	private bool IsZero(string input)
	{
		if (!input.Equals("0.0") && !input.Equals("0%") && !input.Equals("0"))
		{
			return input.Equals("0.0%");
		}
		return true;
	}

	private string FormatPropertyValue(float value, bool isPercent)
	{
		if (!isPercent)
		{
			return Mathf.FloorToInt(value).FastToString();
		}
		int num = Mathf.FloorToInt(value * 1000f);
		bool flag = num < 0;
		int num2 = Mathf.Abs(num);
		int value2 = num2 / 10;
		int value3 = num2 % 10;
		string text = (flag ? "-" : string.Empty);
		return text + value2.FastToString() + "." + value3.FastToString() + "%";
	}

	private void SetHelpButton(int propertyID)
	{
		m_CommonHelpButton.gameObject.SetActive(value: false);
		PropertyData data = CoreUtils.GetData(propertyID, RuntimeConfigs.data.propertyDatas);
		if (data != null)
		{
			PropertyTypeData data2 = CoreUtils.GetData(data.propertyId, RuntimeConfigs.data.propertyTypeDatas);
			if (data2 != null && data2.propertyDescId != 0)
			{
				m_CommonHelpButton.gameObject.SetActive(value: false);
				m_CommonHelpButton.SetContent(data2.propertyDescId);
			}
		}
	}
}
