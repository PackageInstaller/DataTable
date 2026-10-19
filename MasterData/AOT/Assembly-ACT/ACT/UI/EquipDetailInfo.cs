using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.Serialization;

namespace ACT.UI;

public class EquipDetailInfo : BaseUIComponent
{
	[Header("装备信息相关")]
	public GameObject[] qualityRoots;

	public CommonNumberComponent equipLevel;

	public LocalizeStringEvent equipName;

	public LocalizeStringEvent equipType;

	public GameObject equipState;

	public BImage equipTypeIcon;

	public PropertyCell[] propertyCells;

	public Transform root;

	public EquipGemIsLockBtn gemLockBtn;

	[Header("详情面板配置")]
	public GameObject equipInfoRoot;

	public GameObject gemSlotsRoot;

	[FormerlySerializedAs("detailViewRoot")]
	[Header("装备Buff面板配置")]
	public GameObject equipDetailViewRoot;

	[FormerlySerializedAs("buffDetail")]
	public EquipBuffDetail equipBuffDetail;

	[Header("所有Buff面板配置")]
	public ActToggle totalBuffToggle;

	[FormerlySerializedAs("buffDetailViewRoot")]
	public GameObject totalBuffDetailViewRoot;

	[FormerlySerializedAs("buffDetailView")]
	public EquipBuffDetail totalBuffDetailView;

	private int m_GemIndex = -1;

	private Equip m_TargetEquip;

	private Gem m_TargetGem;

	private int m_GemSlotIndex = -1;

	private int m_EquipSlotIndex = -1;

	private Character m_Owner;

	private Equip m_OriginEquip => G.localPlayer.Inventory.GetEquip(m_Owner.GetEquipId(m_EquipSlotIndex + 1));

	private void Awake()
	{
		if ((bool)totalBuffToggle)
		{
			totalBuffToggle.onValueChanged.AddListener(OnEquipDetailToggleValueChanged);
		}
	}

	private void OnDestroy()
	{
		if ((bool)totalBuffToggle)
		{
			totalBuffToggle.onValueChanged.RemoveListener(OnEquipDetailToggleValueChanged);
		}
	}

	public void UpdateContrastInfo(Character owner, Equip targetEquip, int targetEquipSlot)
	{
		UpdateContrastInfo(owner, targetEquip, targetEquipSlot, null, -1);
	}

	public void UpdateContrastInfo(Character owner, Equip targetEquip, int targetEquipSlot, Gem targetGem, int targetGemSlot)
	{
		m_Owner = owner;
		m_TargetEquip = targetEquip;
		m_TargetGem = targetGem;
		m_GemSlotIndex = targetGemSlot;
		m_EquipSlotIndex = targetEquipSlot;
		for (int i = 0; i < qualityRoots.Length; i++)
		{
			GameObject obj = qualityRoots[i];
			Equip equip = m_TargetEquip ?? m_OriginEquip;
			obj.SetActive(equip != null && equip.GetQuality() - 1 == i);
		}
		SetEquipFeatures();
		SetAllFeatures();
		if ((bool)equipState)
		{
			equipState.SetActive(m_TargetEquip == m_OriginEquip);
		}
	}

	private void SetEquipFeatures()
	{
		if (m_OriginEquip == null && m_TargetEquip == null)
		{
			equipBuffDetail.emptyText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.NoEquip;
			equipBuffDetail.emptyRoot.SetActive(value: true);
			equipBuffDetail.buffDetailRoot.SetActive(value: false);
			equipInfoRoot.SetActive(value: false);
			return;
		}
		root.gameObject.SetActive(value: true);
		gemSlotsRoot.SetActive(value: true);
		equipInfoRoot.SetActive(value: true);
		equipDetailViewRoot.SetActive(value: true);
		Equip equip = m_TargetEquip ?? m_OriginEquip;
		gemLockBtn.Init(equip.Uid, equip.IsLock);
		CoreUtils.GetData(equip.Id, RuntimeConfigs.data.equipDatas);
		ItemData data = CoreUtils.GetData(equip.Id, RuntimeConfigs.data.itemDatas);
		equipLevel.UpdateNumber(equip.Level, RuntimeConfigs.data.game.equipRareLevel[equip.GetQuality() - 1]);
		equipName.StringReference.TableEntryReference = data.nameLocal;
		GameUtility.SetEquipProperty(propertyCells, equip, Station);
		if (equipType != null)
		{
			LocalizedString stringReference = equipType.StringReference;
			stringReference.TableEntryReference = equip.TypeIndex switch
			{
				1 => LocalizationCommonData.CommonString.Power, 
				2 => LocalizationCommonData.CommonString.Move, 
				3 => LocalizationCommonData.CommonString.Can, 
				4 => LocalizationCommonData.CommonString.Assist, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
		}
		if (equipTypeIcon != null)
		{
			Station.LoadImage(135, equip.TypeIndex, equipTypeIcon);
		}
		equipBuffDetail.emptyText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.NoAttribute;
		equipBuffDetail.Init(m_TargetEquip);
		EquipLockedFeatureHelper.AddLockedEquipFeatures(equip, equipBuffDetail);
	}

	private void SetAllFeatures()
	{
		if (m_OriginEquip == null && m_TargetEquip == null)
		{
			totalBuffDetailView.emptyText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.NoEquip;
			totalBuffDetailView.emptyRoot.SetActive(value: true);
			totalBuffDetailView.buffDetailRoot.SetActive(value: false);
		}
		else
		{
			totalBuffDetailView.emptyText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.NoAttribute;
			SetBuffDetail(totalBuffDetailView, isSelf: false);
		}
	}

	private void SetBuffDetail(EquipBuffDetail targetBuffDetail, bool isSelf)
	{
		List<int> list = ListPool<int>.Get();
		m_Owner.GetAllFeatureIDs(list);
		if (m_OriginEquip == null && m_TargetEquip == null)
		{
			targetBuffDetail.Init(m_Owner);
		}
		else if (m_TargetEquip != null)
		{
			Character character = m_Owner.Clone();
			character.Refresh();
			Equip equip = m_TargetEquip.Clone();
			equip.Refresh();
			TestCharacterFeature(character, m_EquipSlotIndex, equip, m_GemSlotIndex, m_TargetGem);
			targetBuffDetail.Init(m_Owner, character, ShouldShow);
		}
		ListPool<int>.Release(list);
		bool ShouldShow(int featureId)
		{
			List<int> list2 = ListPool<int>.Get();
			m_OriginEquip?.GetAllFeatureIDs(list2);
			m_TargetEquip?.GetAllFeatureIDs(list2);
			bool result = list2.Contains(featureId);
			ListPool<int>.Release(list2);
			if (isSelf)
			{
				return result;
			}
			return true;
		}
	}

	public void PlayAnim()
	{
	}

	public void Open(Character character)
	{
		m_Owner = character;
	}

	public void SetToggle(int index)
	{
	}

	private void TestCharacterFeature(Character testCharacter, int equipIndex, Equip addEquip, int gemSlotIndex, Gem addGem)
	{
		if (addEquip != null)
		{
			if (addGem != null)
			{
				addEquip.GemSlots[gemSlotIndex].GemId = addGem.Uid;
			}
			else if (gemSlotIndex >= 0 && gemSlotIndex < addEquip.GemSlots.Count)
			{
				addEquip.GemSlots[gemSlotIndex].GemId = 0;
			}
			if (!testCharacter.Equips.TryGetValue(equipIndex + 1, out var _))
			{
				testCharacter.Equips.Add(equipIndex + 1, addEquip.Uid);
			}
			else
			{
				testCharacter.Equips[equipIndex + 1] = addEquip.Uid;
			}
			testCharacter.Refresh();
		}
		else
		{
			testCharacter.Equips.Remove(equipIndex + 1);
			testCharacter.Refresh();
		}
	}

	private void OnEquipDetailToggleValueChanged(bool arg0)
	{
		totalBuffDetailViewRoot.SetActive(arg0);
	}
}
