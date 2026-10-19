using System;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using Cysharp.Threading.Tasks;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class EquipItemDetail : BaseUIComponent
{
	[Serializable]
	private struct Style
	{
		public GameObject styleRoot;
	}

	[Serializable]
	private struct PropertyStyle
	{
		public BImage icon;

		public LocalizeStringEvent propertyName;

		public TMP_Text number;
	}

	[Header("样式")]
	[SerializeField]
	private Style[] m_Styles;

	[Header("装备图标")]
	[SerializeField]
	private BImage m_Icon;

	[Header("锁组件")]
	[SerializeField]
	private EquipGemIsLockBtn m_LockComp;

	[Header("文本")]
	[SerializeField]
	private LocalizeStringEvent m_MainTitle;

	[Header("装备类型")]
	[SerializeField]
	private CommonEquipTypeComponent m_EquipType;

	[Header("主属性")]
	[SerializeField]
	private PropertyStyle m_MainPropertyStyle;

	[Header("随机属性1")]
	[SerializeField]
	private PropertyStyle m_RandomPropertyStyle1;

	[Header("随机属性2")]
	[SerializeField]
	private PropertyStyle m_RandomPropertyStyle2;

	[Header("BuffItem")]
	[SerializeField]
	private EquipBuffDetail m_EquipBuffDetail;

	private EquipData m_EquipData;

	private ItemData m_ItemData;

	private Equip m_Context;

	private ImageAssetStation m_Station;

	public EquipGemIsLockBtn LockComp => m_LockComp;

	public new Equip Context
	{
		get
		{
			return m_Context;
		}
		set
		{
			m_Context = value;
			UpdateData();
			UpdateStyle();
			UpdateText();
			UpdateBuffItem();
			UpdateProperties();
			UpdateEquipType();
		}
	}

	public override ImageAssetStation Station
	{
		get
		{
			return m_Station;
		}
		set
		{
			m_Station = value;
		}
	}

	private void UpdateData()
	{
		if (Context == null)
		{
			m_EquipData = null;
			m_ItemData = null;
		}
		else
		{
			m_ItemData = CoreUtils.GetData(Context.Id, RuntimeConfigs.data.itemDatas);
			m_EquipData = CoreUtils.GetData(Context.Id, RuntimeConfigs.data.equipDatas);
		}
	}

	private void UpdateStyle()
	{
		if (Context != null)
		{
			for (int i = 0; i < m_Styles.Length; i++)
			{
				m_Styles[i].styleRoot.SetActive(i == Context.GetQuality() - 1);
			}
			m_LockComp.Init(Context);
			Station.LoadItemIconAsync(m_ItemData.iconAddress, m_Icon).Forget();
		}
	}

	private void UpdateText()
	{
		m_MainTitle.StringReference.TableEntryReference = m_ItemData.nameLocal;
	}

	private void UpdateBuffItem()
	{
		m_EquipBuffDetail.gameObject.SetActive(value: true);
		Context.CalculateFeatureData();
		m_EquipBuffDetail.Init(Context);
	}

	private void UpdateProperties()
	{
		SetProperty(m_MainPropertyStyle, 0);
		SetProperty(m_RandomPropertyStyle1, 1);
		SetProperty(m_RandomPropertyStyle2, 2);
	}

	private void UpdateEquipType()
	{
		m_EquipType.Station = Station;
		m_EquipType.Init(Context.TypeIndex);
	}

	private void SetProperty(PropertyStyle style, int propertyIndex)
	{
		EquipAttr equipAttr = Context.Attributes[propertyIndex];
		EquipAttrData data = CoreUtils.GetData(equipAttr.Id, RuntimeConfigs.data.equipAttrDatas);
		if (data != null)
		{
			PropertyData data2 = CoreUtils.GetData(data.attrId, RuntimeConfigs.data.propertyDatas);
			if (data2 != null)
			{
				Station.LoadImageAsync(146, data.attrId, style.icon).Forget();
				style.propertyName.StringReference.TableEntryReference = data2.descLocal;
				style.number.SetText(equipAttr.Value.FastToString(data2.judge ? 1 : (-1), data2.judge));
			}
		}
	}
}
