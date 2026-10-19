using System;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class TreasureUIComponent : ItemUIComponentBase
{
	[SerializeField]
	private Image m_SpecialTreasureIcon;

	[SerializeField]
	private GameObject m_characterIconRoot;

	[SerializeField]
	private CommonCharacterHead m_commonCharacterHead;

	public override void UpdatePerformance()
	{
		try
		{
			SetQualityBg();
			LoadMainIcon();
			SetSelect();
			UpdateName();
			UpdateRedPoint();
			IsShowSpecialIcon();
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
	}

	protected override void UpdateName()
	{
		base.UpdateName();
		m_ItemNameRoot.SetActive(value: true);
		if (ItemUnifier == ItemUnifierProxy.Empty)
		{
			m_ItemName.OnUpdateString.Invoke("???");
		}
		else if (IsCollected())
		{
			ItemTreasureData data = CoreUtils.GetData(ItemUnifier.Id, RuntimeConfigs.data.itemTreasureDatas);
			ItemData obj = ((data == null) ? null : CoreUtils.GetData(data.itemId, RuntimeConfigs.data.itemDatas));
			m_ItemName.StringReference.TableEntryReference = obj?.nameLocal ?? 0;
		}
		else
		{
			m_ItemName.OnUpdateString.Invoke("???");
		}
	}

	protected override void LoadMainIcon()
	{
		m_characterIconRoot?.SetActive(value: false);
		if (!HasValidItemUnifier())
		{
			m_EmptyObject?.SetActive(value: true);
			m_MainIcon?.icon?.gameObject.SetActive(value: false);
		}
		else if (IsCollected())
		{
			m_EmptyObject?.SetActive(value: false);
			m_MainIcon?.icon?.gameObject.SetActive(value: true);
			ItemTreasureData data = CoreUtils.GetData(ItemUnifier.Id, RuntimeConfigs.data.itemTreasureDatas);
			if (data != null && Station != null && m_MainIcon != null)
			{
				ItemData data2 = CoreUtils.GetData(data.itemId, RuntimeConfigs.data.itemDatas);
				Station.LoadItemIconAsync(data2.iconAddress, m_MainIcon).Forget();
			}
			int num = (Model<TreasureModel>.HasInstance() ? Model<TreasureModel>.Interface.GetCharacterIdByTreasureId(ItemUnifier.Id) : 0);
			if (num > 0)
			{
				m_characterIconRoot?.SetActive(value: true);
				m_commonCharacterHead?.Init(num, Station);
				m_commonCharacterHead?.gameObject.SetActive(value: true);
			}
		}
		else
		{
			m_EmptyObject?.SetActive(value: true);
			m_MainIcon?.icon?.gameObject.SetActive(value: false);
		}
	}

	private void IsShowSpecialIcon()
	{
		bool active = HasValidItemUnifier() && !(ItemUnifier.Source is TreasureDisk) && Model<TreasureModel>.HasInstance() && Model<TreasureModel>.Interface.IsSpecialTreasure(ItemUnifier.Id);
		m_SpecialTreasureIcon?.gameObject.SetActive(active);
	}

	private bool IsCollected()
	{
		if (!HasValidItemUnifier())
		{
			return false;
		}
		if (!(ItemUnifier.Source is TreasureDisk treasureDisk))
		{
			if (Model<TreasureModel>.HasInstance())
			{
				return Model<TreasureModel>.Interface.HasGain(ItemUnifier.Id);
			}
			return false;
		}
		return treasureDisk.IsCollected;
	}

	private bool HasValidItemUnifier()
	{
		if (ItemUnifier != null && ItemUnifier != ItemUnifierProxy.Empty)
		{
			return ItemUnifier.Source != null;
		}
		return false;
	}

	protected override void OnNormal()
	{
		if (IsOn)
		{
			SetHighLightVisualOnly(value: true);
		}
		else
		{
			base.OnNormal();
		}
	}

	protected override void UpdateRedPoint()
	{
		if (!m_redPointObject)
		{
			return;
		}
		if (!HasValidItemUnifier())
		{
			m_redPointObject.gameObject.SetActive(value: false);
			return;
		}
		if (ItemUnifier.Source is TreasureDisk treasureDisk)
		{
			string text = RedDotPathDefine.Treasure_Fragmented + $"|{treasureDisk.TreasureId}";
			m_redPointObject.ForbidDotShow = false;
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(text))
			{
				RedDotType = RedDotType.New;
				m_redPointObject.InitRedDot(text, m_RedDotType);
			}
			Singleton<RedDotManager>.instance.SetLeafNodeActive(text, Singleton<RedDotManager>.instance.IsNodeActive(text));
			m_redPointObject.fullPath = text.Split("|").ToList();
			m_redPointObject.BindTrieNode();
			m_redPointObject.UpdateDisplay();
			return;
		}
		m_redPointObject.ForbidDotShow = false;
		if (ItemUnifier.Source is Treasure treasure)
		{
			string text2 = string.Empty;
			switch (treasure.Type)
			{
			case TreasureType.Precious:
				text2 = RedDotPathDefine.Treasure_Precious + $"|{treasure.TreasureId}";
				break;
			case TreasureType.Fragmented:
				text2 = RedDotPathDefine.Treasure_Fragmented + $"|{treasure.TreasureId}";
				break;
			case TreasureType.WaterfallSeal:
				text2 = RedDotPathDefine.Treasure_WaterfallSeal + $"|{treasure.TreasureId}";
				break;
			case TreasureType.Relic:
				text2 = RedDotPathDefine.Treasure_Relic + $"|{treasure.TreasureId}";
				break;
			case TreasureType.BygoneOldObject:
				text2 = RedDotPathDefine.Treasure_BygoneOldObject + $"|{treasure.TreasureId}";
				break;
			case TreasureType.LeftOver:
				text2 = RedDotPathDefine.Treasure_LeftOver + $"|{treasure.TreasureId}";
				break;
			case TreasureType.EnergyControl:
				text2 = RedDotPathDefine.Treasure_EnergyControl + $"|{treasure.TreasureId}";
				break;
			}
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(text2))
			{
				RedDotType = RedDotType.New;
				m_redPointObject.InitRedDot(text2, m_RedDotType);
			}
			Singleton<RedDotManager>.instance.SetLeafNodeActive(text2, Singleton<RedDotManager>.instance.IsNodeActive(text2));
			if (!string.IsNullOrEmpty(text2))
			{
				m_redPointObject.fullPath = text2.Split("|").ToList();
				m_redPointObject.BindTrieNode();
				m_redPointObject.UpdateDisplay();
			}
		}
	}

	public override void PlayCustomAnimation(float delaySecond)
	{
		gameObject.SetActive(value: true);
		base.PlayCustomAnimation(delaySecond);
	}
}
