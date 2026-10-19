using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Utility;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class TreasureDiskItemDetail : BaseUIComponent
{
	[Serializable]
	private struct Style
	{
		public GameObject styleRoot;
	}

	[SerializeField]
	private Style[] m_Styles;

	[SerializeField]
	private LocalizeStringEvent m_MainTitle;

	[SerializeField]
	private LocalizeStringEvent m_AttributeDetail;

	[SerializeField]
	private EquipBuffItem m_EquipBuffItem;

	[SerializeField]
	private ActButton m_DetailButton;

	[SerializeField]
	private OperateBtnPrompt m_DetailPrompt;

	private GameObject _noCount;

	private TMP_Text _mainTitleText;

	private Gem _contextGem;

	private readonly List<EquipBuffItem> _buffItems = new List<EquipBuffItem>();

	private GameObject NoCount
	{
		get
		{
			if (_noCount == null && transform.parent != null)
			{
				_noCount = transform.parent.Find("No_count")?.gameObject;
			}
			return _noCount;
		}
	}

	private void Awake()
	{
		m_DetailButton?.SetBtnClick(OpenFeatureDetail);
		m_DetailPrompt?.SetVisible(vis: false);
	}

	public void Refresh(Gem gem)
	{
		_contextGem = gem;
		bool flag = gem != null;
		gameObject.SetActive(flag);
		NoCount?.SetActive(!flag);
		if (!flag)
		{
			m_DetailButton?.gameObject.SetActive(value: false);
			m_DetailPrompt?.SetVisible(vis: false);
			SetAttributeDetail(0);
			SetUnknownTitle();
			return;
		}
		ItemData data = CoreUtils.GetData(gem.Id, RuntimeConfigs.data.itemDatas);
		EquipGemData data2 = CoreUtils.GetData(gem.Id, RuntimeConfigs.data.equipGemDatas);
		if (data == null || data2 == null)
		{
			_contextGem = null;
			gameObject.SetActive(value: false);
			NoCount?.SetActive(value: true);
			m_DetailButton?.gameObject.SetActive(value: false);
			m_DetailPrompt?.SetVisible(vis: false);
			SetAttributeDetail(0);
			SetUnknownTitle();
		}
		else
		{
			UpdateStyle(gem.GetQuality());
			SetTitle(data.nameLocal);
			SetAttributeDetail(data.descLocal);
			UpdateBuff(gem, data2);
		}
	}

	public void Hide()
	{
		_contextGem = null;
		gameObject.SetActive(value: false);
		NoCount?.SetActive(value: false);
		m_DetailButton?.gameObject.SetActive(value: false);
		m_DetailPrompt?.SetVisible(vis: false);
		SetAttributeDetail(0);
		if (m_MainTitle != null)
		{
			m_MainTitle.gameObject.SetActive(value: false);
		}
	}

	private void SetTitle(int localizationId)
	{
		if (!(m_MainTitle == null))
		{
			m_MainTitle.gameObject.SetActive(value: true);
			m_MainTitle.enabled = true;
			m_MainTitle.StringReference.TableEntryReference = localizationId;
		}
	}

	private void SetUnknownTitle()
	{
		if (!(m_MainTitle == null))
		{
			m_MainTitle.gameObject.SetActive(value: true);
			m_MainTitle.enabled = false;
			if ((object)_mainTitleText == null)
			{
				_mainTitleText = m_MainTitle.GetComponent<TMP_Text>();
			}
			if (_mainTitleText != null)
			{
				_mainTitleText.SetText("???");
			}
		}
	}

	private void UpdateStyle(int quality)
	{
		if (m_Styles == null)
		{
			return;
		}
		int num = quality - 3;
		for (int i = 0; i < m_Styles.Length; i++)
		{
			if (m_Styles[i].styleRoot != null)
			{
				m_Styles[i].styleRoot.SetActive(i == num);
			}
		}
	}

	private void UpdateBuff(Gem gem, EquipGemData gemData)
	{
		List<ItemKv> equipFeature = gemData.equipFeature;
		bool flag = equipFeature != null && equipFeature.Count > 0;
		m_DetailButton?.gameObject.SetActive(flag);
		m_DetailPrompt?.SetVisible(flag);
		if (m_EquipBuffItem == null)
		{
			return;
		}
		HideExtraBuffItems();
		if (!flag)
		{
			m_EquipBuffItem.gameObject.SetActive(value: false);
			return;
		}
		gem.Refresh();
		for (int i = 0; i < gemData.equipFeature.Count; i++)
		{
			EquipBuffItem buffItem = GetBuffItem(i);
			if (!(buffItem == null))
			{
				ItemKv itemKv = gemData.equipFeature[i];
				buffItem.gameObject.SetActive(value: true);
				buffItem.Init(new EquipBuffItemData
				{
					id = itemKv.id,
					baseNum = 0,
					ownGemChange = gem.GetFeatureData(itemKv.id)
				}, EquipBuffItem.LevelSpaceItemShowMode.HaveSelect);
			}
		}
	}

	private EquipBuffItem GetBuffItem(int index)
	{
		if (m_EquipBuffItem == null)
		{
			return null;
		}
		if (index == 0)
		{
			return m_EquipBuffItem;
		}
		while (_buffItems.Count < index)
		{
			EquipBuffItem equipBuffItem = UnityEngine.Object.Instantiate(m_EquipBuffItem, m_EquipBuffItem.transform.parent, worldPositionStays: false);
			HideExtraGemDescription(equipBuffItem);
			equipBuffItem.gameObject.SetActive(value: false);
			_buffItems.Add(equipBuffItem);
		}
		EquipBuffItem equipBuffItem2 = _buffItems[index - 1];
		equipBuffItem2.transform.SetSiblingIndex(m_EquipBuffItem.transform.GetSiblingIndex() + index);
		return equipBuffItem2;
	}

	private void HideExtraGemDescription(EquipBuffItem buffItem)
	{
		LocalizeStringEvent attributeDetail = m_AttributeDetail;
		if (!(attributeDetail == null) && !(buffItem == null) && !(m_EquipBuffItem == null) && !(attributeDetail.transform.parent != m_EquipBuffItem.transform))
		{
			int siblingIndex = attributeDetail.transform.GetSiblingIndex();
			if (siblingIndex < buffItem.transform.childCount)
			{
				buffItem.transform.GetChild(siblingIndex).gameObject.SetActive(value: false);
			}
		}
	}

	private void HideExtraBuffItems()
	{
		for (int i = 0; i < _buffItems.Count; i++)
		{
			_buffItems[i].gameObject.SetActive(value: false);
		}
	}

	private void SetAttributeDetail(int localizationId)
	{
		if (!(m_AttributeDetail == null))
		{
			bool flag = localizationId != 0;
			m_AttributeDetail.gameObject.SetActive(flag);
			if (flag)
			{
				m_AttributeDetail.enabled = true;
				m_AttributeDetail.StringReference.TableEntryReference = localizationId;
			}
		}
	}

	public bool TrySubmitDetailButton()
	{
		if (m_DetailButton == null || !m_DetailButton.gameObject.activeInHierarchy || !m_DetailButton.IsInteractable())
		{
			return false;
		}
		m_DetailButton.OnSubmit(null);
		return true;
	}

	private void OpenFeatureDetail()
	{
		if (_contextGem == null)
		{
			return;
		}
		EquipGemData data = CoreUtils.GetData(_contextGem.Id, RuntimeConfigs.data.equipGemDatas);
		List<ItemKv> list = data?.equipFeature;
		if (list == null || list.Count <= 0)
		{
			return;
		}
		List<EquipBuffItemData> list2 = new List<EquipBuffItemData>(data.equipFeature.Count);
		foreach (ItemKv item in data.equipFeature)
		{
			list2.Add(new EquipBuffItemData
			{
				id = item.id,
				baseNum = 1
			});
		}
		GameUtility.OpenBuffDetail(new EquipBuffViewData
		{
			buffInfos = list2,
			hideCurrentLevel = true
		});
	}
}
