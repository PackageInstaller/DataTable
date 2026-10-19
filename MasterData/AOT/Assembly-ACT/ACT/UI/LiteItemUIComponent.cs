using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.Utility;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Serialization;

namespace ACT.UI;

public class LiteItemUIComponent : ItemUIComponentBase
{
	[FormerlySerializedAs("complatedAnim")]
	public BetterAnimation completedAnim;

	[SerializeField]
	private GameObject m_CharacterIconRoot;

	[SerializeField]
	private BImage m_CharacterIcon;

	[SerializeField]
	private GameObject m_LockRoot;

	[SerializeField]
	private GameObject m_DoubleRewardTag;

	[SerializeField]
	private GameObject m_TargetTag;

	[SerializeField]
	private List<GameObject> m_TargetTagIcon;

	[SerializeField]
	private GameObject m_Certain;

	[SerializeField]
	private GameObject m_EquipTypeRoot;

	[SerializeField]
	private BImage m_EquipTypeIcon;

	[SerializeField]
	protected ActButton m_ReduceButton;

	protected override void OnGameObjectAwake()
	{
		base.OnGameObjectAwake();
		if ((bool)m_ReduceButton)
		{
			m_ReduceButton.OnClick.AddListener(OnInvertClick);
		}
	}

	protected override void OnGameObjectDestroy()
	{
		base.OnGameObjectDestroy();
		if ((bool)m_ReduceButton)
		{
			m_ReduceButton.OnClick.RemoveListener(OnInvertClick);
		}
	}

	protected override void UpdateUniversalItemTag()
	{
		int targetRewardIndex = GetTargetRewardIndex();
		bool flag = targetRewardIndex >= 0;
		if ((bool)m_TargetTag)
		{
			m_TargetTag.SetActive(flag);
		}
		if (flag && targetRewardIndex < m_TargetTagIcon.Count)
		{
			for (int i = 0; i < m_TargetTagIcon.Count; i++)
			{
				if ((bool)m_TargetTagIcon[i])
				{
					m_TargetTagIcon[i].SetActive(targetRewardIndex == i);
				}
			}
		}
		if (!m_DoubleRewardTag)
		{
			return;
		}
		GameObject doubleRewardTag = m_DoubleRewardTag;
		if ((object)doubleRewardTag != null)
		{
			int active;
			if (!flag)
			{
				ItemUnifierProxy itemUnifier = m_ItemUnifier;
				active = ((itemUnifier != null && itemUnifier.RewardTag == UniversalItemTag.Extra) ? 1 : 0);
			}
			else
			{
				active = 0;
			}
			doubleRewardTag.SetActive((byte)active != 0);
		}
	}

	private int GetTargetRewardIndex()
	{
		InitType initType = m_InitType;
		if ((initType != InitType.WorldSettlementRewardItem && initType != InitType.RewardItemReceived) || m_ItemUnifier == null)
		{
			return -1;
		}
		return m_ItemUnifier.RewardTag switch
		{
			UniversalItemTag.TargetOne => 0, 
			UniversalItemTag.TargetTwo => 1, 
			UniversalItemTag.TargetThree => 2, 
			_ => -1, 
		};
	}

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
		IBagItem bagItem = m_ItemUnifier?.Source;
		if (!(bagItem is Item))
		{
			if (!(bagItem is Character))
			{
				if (!(bagItem is Weapon))
				{
					if (!(bagItem is Gem))
					{
						if (!(bagItem is Equip))
						{
							if (bagItem == null)
							{
								UpdateEmptyPerformance();
							}
						}
						else
						{
							UpdateEquipTypePerformance();
						}
					}
					else
					{
						UpdateGemTypePerformance();
					}
				}
				else
				{
					UpdateWeaponTypePerformance();
				}
			}
			else
			{
				UpdateCharacterTypePerformance();
			}
		}
		else
		{
			UpdateItemTypePerformance();
		}
	}

	protected override void LoadMainIconImage(ItemUnifierProxy itemUnifier, InitType itemType, BImage bImage)
	{
		switch (itemType)
		{
		case InitType.TeamViewBagCharacter:
			Station.LoadImageAsync(103, itemUnifier.Id, bImage).Forget();
			break;
		case InitType.BagItem:
		case InitType.RewardItem:
		case InitType.WorldSettlementRewardItem:
		{
			ItemData itemData = itemUnifier.ItemData;
			if ((itemData?.type ?? 0) == 12)
			{
				Station.LoadImageAsync(241, itemData.iconAddress, bImage).Forget();
			}
			else if (itemData != null)
			{
				Station.LoadItemIconAsync(itemData.iconAddress, bImage).Forget();
			}
			break;
		}
		default:
			base.LoadMainIconImage(itemUnifier, itemType, bImage);
			break;
		}
	}

	protected override void ShowDetailPanel()
	{
		if (!showDetailPanel || m_ItemUnifier?.Source == null || m_ItemUnifier.Equals(ItemUnifierProxy.Empty))
		{
			return;
		}
		IBagItem source = m_ItemUnifier.Source;
		if (source is Equip || source is Gem || source is BloodBottleData || source is BloodBottleMaterial)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, m_ItemUnifier.Source);
			if (group != null)
			{
				group.SetSelected(this);
			}
		}
		else
		{
			base.ShowDetailPanel();
		}
	}

	private void UpdateItemTypePerformance()
	{
		if ((bool)m_CharacterIconRoot)
		{
			m_CharacterIconRoot.SetActive(value: false);
		}
		m_ItemNameRoot.SetActive(value: false);
	}

	private void UpdateChipTypePerformance()
	{
		m_ItemNameRoot.SetActive(value: false);
	}

	private void UpdateCharacterTypePerformance()
	{
		m_ItemNameRoot.SetActive(value: false);
	}

	private void UpdateWeaponTypePerformance()
	{
		m_ItemNameRoot.SetActive(value: false);
	}

	private void UpdateGemTypePerformance()
	{
		m_CompleteObject?.SetActive(value: false);
		m_ItemCountRoot?.SetActive(value: false);
		Gem gem = m_ItemUnifier.As<Gem>();
		EquipGemData data = CoreUtils.GetData(gem.Id, RuntimeConfigs.data.equipGemDatas);
		m_LockRoot?.SetActive(gem.IsLock);
		int num = G.localPlayer.Inventory.GetEquip(gem.InlayEquip)?.WearCharacter ?? 0;
		if (num != 0)
		{
			m_CharacterIconRoot?.SetActive(value: true);
			Station.LoadImageAsync(126, num, m_CharacterIcon).Forget();
		}
		else
		{
			m_CharacterIconRoot?.SetActive(value: false);
		}
		m_ItemNameRoot.SetActive(value: true);
		m_ItemName.StringReference.TableEntryReference = data.nameLocal;
	}

	private void UpdateEquipTypePerformance()
	{
		m_ItemNameRoot.SetActive(value: false);
		m_EquipTypeRoot.SetActive(value: true);
		Equip equip = m_ItemUnifier.As<Equip>();
		Station.LoadImageAsync(135, equip.TypeIndex, m_EquipTypeIcon).Forget();
	}

	private void UpdateEmptyPerformance()
	{
		m_ItemNameRoot.SetActive(value: false);
	}

	protected override void SetComplete()
	{
		if ((bool)m_CompleteObject)
		{
			if (IsFirstComplete)
			{
				m_CompleteObject.SetActive(value: true);
				completedAnim.GetSequence("Reward").Play();
			}
			else
			{
				m_CompleteObject.SetActive(IsComplete || m_InitType == InitType.RewardItemReceived);
			}
		}
	}

	public void SetCertain(bool value)
	{
		if (!(m_Certain == null))
		{
			m_Certain.SetActive(value);
		}
	}
}
