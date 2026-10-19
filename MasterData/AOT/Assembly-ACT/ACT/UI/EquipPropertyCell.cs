using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;

namespace ACT.UI;

public class EquipPropertyCell : BaseUIComponent
{
	[Serializable]
	private struct PropertyStyle
	{
		[Header("组件根节点")]
		public GameObject root;

		[Header("数字组件")]
		public TMP_Text number;

		[Header("宝石槽")]
		public GameObject[] gemSlotRoots;

		[Header("装备升级图标")]
		public GameObject equipLevelUpRoot;

		public TMP_Text lvText;

		public TMP_Text equipLevelUpText;

		public void Reset()
		{
			number.gameObject.SetActive(value: false);
			GameObject[] array = gemSlotRoots;
			for (int i = 0; i < array.Length; i++)
			{
				array[i].gameObject.SetActive(value: false);
			}
			equipLevelUpRoot.SetActive(value: false);
		}
	}

	[FormerlySerializedAs("m_MainPropertyNormalRoot")]
	[Header("主属性样式")]
	[SerializeField]
	private GameObject m_MainRoot;

	[SerializeField]
	private BImage m_MainPropertyDynamicIcon;

	[SerializeField]
	private LocalizeStringEvent m_MainPropertyName;

	[SerializeField]
	private PropertyStyle m_MainFrontStyle;

	[SerializeField]
	private GameObject m_MainArrow;

	[SerializeField]
	private PropertyStyle m_MainBehindStyle;

	[SerializeField]
	private GameObject m_MainLevelUpArrow;

	[Header("普通样式")]
	[SerializeField]
	private GameObject m_NormalRoot;

	[SerializeField]
	private GameObject m_GemIcon;

	[FormerlySerializedAs("m_PropertyIcon")]
	[SerializeField]
	private BImage m_DynamicIcon;

	[SerializeField]
	private LocalizeStringEvent m_PropertyName;

	[SerializeField]
	private PropertyStyle m_FrontStyle;

	[SerializeField]
	private GameObject m_Arrow;

	[SerializeField]
	private PropertyStyle m_BehindStyle;

	[SerializeField]
	private GameObject m_LevelUpArrow;

	[SerializeField]
	private GameObject m_NewTip;

	[SerializeField]
	private Color m_NormalColor;

	[SerializeField]
	private Color m_PromoteColor;

	[SerializeField]
	private ActButton m_SkillHelpButton;

	private int m_FeatureId;

	private int m_FeatureLevel;

	private void Awake()
	{
		m_SkillHelpButton.OnClick.AddListener(OpenFeatureBuffView);
	}

	private void OnDestroy()
	{
		m_SkillHelpButton.OnClick.RemoveListener(OpenFeatureBuffView);
	}

	public void SetAttributeStyle(float from, float to, int equipAttributeId, bool isMain)
	{
		m_SkillHelpButton.gameObject.SetActive(value: false);
		if (isMain)
		{
			SetMainAttributeStyle(from, to, equipAttributeId);
		}
		else
		{
			SetNormalAttributeStyle(from, to, equipAttributeId);
		}
	}

	private void SetMainAttributeStyle(float from, float to, int equipAttributeId)
	{
		m_NormalRoot.SetActive(value: false);
		m_MainRoot.SetActive(value: true);
		EquipAttrData data = CoreUtils.GetData(equipAttributeId, RuntimeConfigs.data.equipAttrDatas);
		if (data == null)
		{
			return;
		}
		PropertyData data2 = CoreUtils.GetData(data.attrId, RuntimeConfigs.data.propertyDatas);
		if (data2 == null)
		{
			return;
		}
		m_MainPropertyName.SetTable("shortcommon");
		m_MainPropertyName.StringReference.TableEntryReference = data2.descLocal;
		Station.LoadImageAsync(146, data2.icon, m_MainPropertyDynamicIcon).Forget();
		if (Mathf.Approximately(from, to))
		{
			m_MainFrontStyle.root.SetActive(value: false);
			m_MainArrow.SetActive(value: false);
			m_MainBehindStyle.root.SetActive(value: true);
			m_MainBehindStyle.number.gameObject.SetActive(value: true);
			if (data2.judge)
			{
				m_MainBehindStyle.number.SetText(from.FastToString(1, isPercent: true));
			}
			else
			{
				m_MainBehindStyle.number.SetText(from.FastToString());
			}
			m_MainBehindStyle.number.color = m_NormalColor;
			m_MainLevelUpArrow.SetActive(value: false);
			return;
		}
		m_MainFrontStyle.root.SetActive(value: true);
		m_MainArrow.SetActive(value: true);
		m_MainBehindStyle.root.SetActive(value: true);
		m_MainFrontStyle.number.gameObject.SetActive(value: true);
		m_MainFrontStyle.number.color = m_NormalColor;
		m_MainBehindStyle.number.gameObject.SetActive(value: true);
		m_MainBehindStyle.number.color = m_PromoteColor;
		m_MainLevelUpArrow.SetActive(value: true);
		if (data2.judge)
		{
			m_MainFrontStyle.number.SetText(from.FastToString(1, isPercent: true));
			m_MainBehindStyle.number.SetText(to.FastToString(1, isPercent: true));
		}
		else
		{
			m_MainFrontStyle.number.SetText(from.FastToString());
			m_MainBehindStyle.number.SetText(to.FastToString());
		}
	}

	private void SetNormalAttributeStyle(float from, float to, int equipAttributeId)
	{
		m_NormalRoot.SetActive(value: true);
		m_MainRoot.SetActive(value: false);
		m_NewTip.SetActive(value: false);
		EquipAttrData data = CoreUtils.GetData(equipAttributeId, RuntimeConfigs.data.equipAttrDatas);
		if (data == null)
		{
			return;
		}
		PropertyData data2 = CoreUtils.GetData(data.attrId, RuntimeConfigs.data.propertyDatas);
		if (data2 != null)
		{
			m_PropertyName.SetTable("shortcommon");
			m_PropertyName.StringReference.TableEntryReference = data2.descLocal;
			m_GemIcon.SetActive(value: false);
			m_DynamicIcon.icon.gameObject.SetActive(value: true);
			Station.LoadImageAsync(146, data2.icon, m_DynamicIcon).Forget();
		}
		if (Mathf.Approximately(from, to))
		{
			m_FrontStyle.root.SetActive(value: false);
			m_Arrow.SetActive(value: false);
			m_BehindStyle.root.SetActive(value: true);
			m_BehindStyle.Reset();
			m_BehindStyle.number.gameObject.SetActive(value: true);
			m_BehindStyle.number.SetText((data2 != null && data2.judge) ? from.FastToString(1, isPercent: true) : from.FastToString());
			m_BehindStyle.number.color = m_NormalColor;
			m_LevelUpArrow.SetActive(value: false);
			return;
		}
		m_FrontStyle.root.SetActive(value: true);
		m_FrontStyle.Reset();
		m_Arrow.SetActive(value: true);
		m_BehindStyle.root.SetActive(value: true);
		m_BehindStyle.Reset();
		m_FrontStyle.number.gameObject.SetActive(value: true);
		m_FrontStyle.number.color = m_NormalColor;
		m_BehindStyle.number.gameObject.SetActive(value: true);
		m_BehindStyle.number.color = m_PromoteColor;
		m_LevelUpArrow.SetActive(value: true);
		if (data2 != null && data2.judge)
		{
			m_FrontStyle.number.SetText(from.FastToString(1, isPercent: true));
			m_BehindStyle.number.SetText(to.FastToString(1, isPercent: true));
		}
		else
		{
			m_FrontStyle.number.SetText(from.FastToString());
			m_BehindStyle.number.SetText(to.FastToString());
		}
	}

	public void SetGemSlotStyle(int fromSlotLevel, int toSlotLevel, int slotIndex)
	{
		m_MainRoot.SetActive(value: false);
		m_PropertyName.SetTable("Common");
		LocalizedString stringReference = m_PropertyName.StringReference;
		stringReference.TableEntryReference = slotIndex switch
		{
			0 => LocalizationCommonData.CommonString.GemSlot1, 
			1 => LocalizationCommonData.CommonString.GemSlot2, 
			2 => LocalizationCommonData.CommonString.GemSlot3, 
			_ => throw new ArgumentOutOfRangeException("slotIndex", slotIndex, null), 
		};
		m_GemIcon.SetActive(value: true);
		m_DynamicIcon.icon.gameObject.SetActive(value: false);
		m_SkillHelpButton.gameObject.SetActive(value: false);
		if (fromSlotLevel <= 0)
		{
			m_FrontStyle.root.SetActive(value: false);
			m_Arrow.SetActive(value: false);
			m_BehindStyle.root.SetActive(value: true);
			m_BehindStyle.Reset();
			for (int i = 0; i < m_BehindStyle.gemSlotRoots.Length; i++)
			{
				m_BehindStyle.gemSlotRoots[i].SetActive(i == toSlotLevel - 1);
			}
			m_NewTip.SetActive(value: true);
			m_LevelUpArrow.SetActive(value: false);
			return;
		}
		m_FrontStyle.root.SetActive(value: true);
		m_FrontStyle.Reset();
		m_Arrow.SetActive(value: true);
		m_BehindStyle.root.SetActive(value: true);
		m_BehindStyle.Reset();
		m_NewTip.SetActive(value: false);
		for (int j = 0; j < m_FrontStyle.gemSlotRoots.Length; j++)
		{
			m_FrontStyle.gemSlotRoots[j].SetActive(j == fromSlotLevel - 1);
		}
		for (int k = 0; k < m_BehindStyle.gemSlotRoots.Length; k++)
		{
			m_BehindStyle.gemSlotRoots[k].SetActive(k == toSlotLevel - 1);
		}
		m_LevelUpArrow.SetActive(value: true);
	}

	public void SetEquipFeatureStyle(int fromAttributeLevel, int toAttributeLevel, int featureId)
	{
		m_MainRoot.SetActive(value: false);
		m_NewTip.SetActive(value: false);
		EquipFeatureData data = CoreUtils.GetData(featureId, RuntimeConfigs.data.equipFeatureDatas);
		if (data != null)
		{
			m_FeatureId = featureId;
			m_FeatureLevel = toAttributeLevel;
			m_SkillHelpButton.gameObject.SetActive(value: true);
			m_PropertyName.SetTable("shortcommon");
			m_PropertyName.StringReference.TableEntryReference = CoreUtils.GetEquipFeatureNameLocalId(data);
			m_GemIcon.SetActive(value: false);
			m_DynamicIcon.icon.gameObject.SetActive(value: true);
			Station.LoadImageAsync(153, data.icon, m_DynamicIcon).Forget();
		}
		if (fromAttributeLevel == toAttributeLevel)
		{
			m_FrontStyle.root.SetActive(value: false);
			m_Arrow.SetActive(value: false);
			m_BehindStyle.root.SetActive(value: true);
			m_BehindStyle.Reset();
			m_BehindStyle.equipLevelUpRoot.SetActive(value: true);
			m_BehindStyle.lvText.color = m_NormalColor;
			m_BehindStyle.equipLevelUpText.color = m_NormalColor;
			m_BehindStyle.equipLevelUpText.SetText(toAttributeLevel.FastToString());
			m_LevelUpArrow.SetActive(value: false);
			return;
		}
		m_FrontStyle.root.SetActive(value: true);
		m_FrontStyle.Reset();
		m_Arrow.SetActive(value: true);
		m_BehindStyle.root.SetActive(value: true);
		m_BehindStyle.Reset();
		m_FrontStyle.equipLevelUpRoot.SetActive(value: true);
		m_FrontStyle.equipLevelUpText.SetText(fromAttributeLevel.FastToString());
		m_BehindStyle.equipLevelUpRoot.SetActive(value: true);
		m_BehindStyle.equipLevelUpText.SetText(toAttributeLevel.FastToString());
		if ((bool)m_BehindStyle.lvText)
		{
			m_BehindStyle.lvText.color = m_PromoteColor;
		}
		if ((bool)m_BehindStyle.equipLevelUpText)
		{
			m_BehindStyle.equipLevelUpText.color = m_PromoteColor;
		}
		m_LevelUpArrow.SetActive(value: true);
	}

	public void PlayAnimation(float delayTime, string animationName)
	{
		(m_MainRoot.activeInHierarchy ? m_MainRoot.GetComponent<BetterAnimation>() : m_NormalRoot.GetComponent<BetterAnimation>())?.GetSequence(animationName)?.Goto(0f).SetDelay(delayTime).Play();
	}

	private void OpenFeatureBuffView()
	{
		List<EquipBuffItemData> buffItemDatas = ListPool<EquipBuffItemData>.Get();
		buffItemDatas.Add(new EquipBuffItemData
		{
			id = m_FeatureId,
			baseNum = m_FeatureLevel
		});
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_EQUIPBUFF, new EquipBuffViewData
		{
			buffInfos = buffItemDatas,
			closeAction = () =>
			{
				ListPool<EquipBuffItemData>.Release(buffItemDatas);
			}
		});
	}
}
