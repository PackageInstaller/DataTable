using System;
using System.Linq;
using ACT;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.UI;
using Bamboo.Collections;
using Bamboo.ECS;
using Fundamental;
using Google.Protobuf.Collections;
using Sirenix.Utilities;
using UnityEngine;

namespace Battle.LittleItemsModel;

public class LittleItemModel : Model<LittleItemModel>
{
	private enum LittleItemType
	{
		BloodBottle = 1
	}

	private ItemSmallData m_SmallData;

	private BloodBottleItem m_CurrentBloodBottleItem;

	private RepeatedField<int> m_CurrentShortCuts = new RepeatedField<int> { 0 };

	private BArray<int> m_AbName;

	private bool m_InitSuccess;

	public int LeftCount => SmallData.customizeParameter2 - CurrentBloodBottleItem.UsedCount;

	public ItemSmallData SmallData
	{
		get
		{
			return m_SmallData;
		}
		private set
		{
			_ = LuminApplication.LogEnabled;
			m_SmallData = value;
		}
	}

	public float NextTime { get; private set; }

	public int ShortCutIndex
	{
		get
		{
			try
			{
				return G.localPlayer.littleItems.ShortcutInfo.CurShortcutIdx;
			}
			catch (Exception ex)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning("小道具有问题：" + ex);
				}
				return 0;
			}
		}
		set
		{
			G.localPlayer.littleItems.ShortcutInfo.CurShortcutIdx = value;
		}
	}

	public BloodBottleItem CurrentBloodBottleItem => m_CurrentBloodBottleItem;

	public int CurrentShortCutId => m_CurrentShortCuts[ShortCutIndex];

	private RepeatedField<BloodBottleItem> m_CurrentBloodItems => G.localPlayer.littleItems.BloodBottleItems;

	public void OnBloodBottleChanged()
	{
		foreach (BloodBottleItem currentBloodItem in m_CurrentBloodItems)
		{
			if (currentBloodItem.Id == m_CurrentShortCuts[ShortCutIndex])
			{
				m_CurrentBloodBottleItem = currentBloodItem;
			}
		}
		if (m_CurrentBloodBottleItem == null)
		{
			return;
		}
		SmallData = CoreUtils.GetData(CurrentShortCutId, RuntimeConfigs.data.itemSmallDatas);
		try
		{
			SkillGroupData data = CoreUtils.GetData(SmallData.customizeParameter1, RuntimeConfigs.data.skillGroupDatas);
			if (m_AbName != null)
			{
				m_AbName.Clear();
			}
			else
			{
				m_AbName = BArrayPool<int>.Default.Get(data.skillTotalIds.Length);
			}
			for (int i = 0; i < data.skillTotalIds.Length; i++)
			{
				m_AbName[i] = data.skillTotalIds[i];
			}
		}
		catch (Exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"没有找到{SmallData.customizeParameter1}技能组！");
			}
			m_AbName = null;
		}
	}

	public void UseLittleItem(int itemId)
	{
		ItemSmallData data = CoreUtils.GetData(itemId, RuntimeConfigs.data.itemSmallDatas);
		if (data.type == 1)
		{
			UseBloodItemEvt evt = EventTrackSolver.Instance.GetEvt<UseBloodItemEvt>();
			evt.itemSmallData = m_SmallData;
			evt.target = MonoECS.instance.mainEntity;
			EventTrackSolver.Instance.Dispatch(evt);
			if (AddBuffToEntity())
			{
				CurrentBloodBottleItem.UsedCount++;
				G.service.SendUseLittleItem(SmallData.id, null);
				NextTime = GameManager.timeSystem.timeScaled + (float)SmallData.customizeParameter3;
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"{data.type}不支持的小道具类型！");
		}
	}

	private bool AddBuffToEntity()
	{
		Entity battleEntity = MPPlayer.local.battleEntity;
		if (battleEntity.IsCharacter() && battleEntity.IsAlive())
		{
			CompAbility compAbility = battleEntity.GetCompAbility();
			for (int i = 0; i < m_AbName.Length; i++)
			{
				SkillDetailData data = CoreUtils.GetData(m_AbName[i], RuntimeConfigs.data.skillDetailDatas);
				compAbility.AddAbility(battleEntity, data.abilityName, AbilitySource.System, new MPSkill
				{
					id = data.id,
					level = 1
				}, 1);
			}
			return true;
		}
		_ = LuminApplication.LogEnabled;
		return false;
	}

	public void RecoverItems(int itemId)
	{
		ItemSmallData data = CoreUtils.GetData(itemId, RuntimeConfigs.data.itemSmallDatas);
		if (data.type == 1)
		{
			if (CurrentBloodBottleItem != null)
			{
				CurrentBloodBottleItem.UsedCount = 0;
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"{data.type}不支持的小道具类型！");
		}
	}

	public void AddNewBloodBottle(BaseEventContent obj)
	{
		if (!(obj is ItemUnifierProxyEvt { data: var data }) || !RuntimeConfigs.data.itemSmallDatas.ContainsKey(data.Id))
		{
			return;
		}
		_ = LuminApplication.LogEnabled;
		if (data.As<Item>().itemType != 15)
		{
			return;
		}
		if (m_CurrentBloodItems.Count == 0)
		{
			m_CurrentBloodItems.Add(new BloodBottleItem
			{
				Id = data.Id,
				UsedCount = 0
			});
			m_CurrentShortCuts[0] = data.Id;
			ShortCutIndex = 0;
			OpenGetBloodBottleUI(isFirst: true);
		}
		else
		{
			ItemSmallData data2 = CoreUtils.GetData(data.Id, RuntimeConfigs.data.itemSmallDatas);
			int subtype = data2.subtype;
			foreach (BloodBottleItem currentBloodItem in m_CurrentBloodItems)
			{
				ItemSmallData data3 = CoreUtils.GetData(currentBloodItem.Id, RuntimeConfigs.data.itemSmallDatas);
				if (data3.subtype != subtype || data2.level <= data3.level)
				{
					continue;
				}
				for (int i = 0; i < m_CurrentShortCuts.Count; i++)
				{
					if (m_CurrentShortCuts[i] == currentBloodItem.Id)
					{
						m_CurrentShortCuts[i] = data2.id;
						break;
					}
				}
				currentBloodItem.Id = data2.id;
				currentBloodItem.UsedCount = 0;
				OpenGetBloodBottleUI();
				break;
			}
		}
		OnBloodBottleChanged();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_UpdateBloodBottle, null);
		G.service.SyncLittleItems(G.localPlayer.littleItems.ShortcutInfo, null);
	}

	public void OpenGetBloodBottleUI(bool isFirst = false)
	{
		PopupGetNewBloodViewData uiViewData = new PopupGetNewBloodViewData
		{
			localizeId = (isFirst ? 1162 : 1163)
		};
		UiViewDataContent evt = Singleton<EventManager>.instance.GetEvt<UiViewDataContent>();
		evt.uiViewData = uiViewData;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Open_NewBloodBottle, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	protected override void Init()
	{
		BindData();
	}

	public void BindData()
	{
		if (m_InitSuccess)
		{
			return;
		}
		try
		{
			m_CurrentShortCuts = G.localPlayer.littleItems.ShortcutInfo?.ShortcutItems;
			if (G.localPlayer.littleItems.BloodBottleItems.Count > 0)
			{
				G.localPlayer.littleItems.BloodBottleItems.Sort((BloodBottleItem x, BloodBottleItem y) => CoreUtils.GetData(x.Id, RuntimeConfigs.data.itemSmallDatas).level - CoreUtils.GetData(y.Id, RuntimeConfigs.data.itemSmallDatas).level);
				BloodBottleItem bloodBottleItem = G.localPlayer.littleItems.BloodBottleItems.First();
				if (m_CurrentShortCuts != null && m_CurrentShortCuts[ShortCutIndex] != bloodBottleItem.Id)
				{
					m_CurrentShortCuts[ShortCutIndex] = bloodBottleItem.Id;
					G.service.SyncLittleItems(G.localPlayer.littleItems.ShortcutInfo, null);
				}
			}
			m_InitSuccess = true;
			NextTime = 0f;
			OnBloodBottleChanged();
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.ItemAdd, AddNewBloodBottle);
		}
		catch (Exception)
		{
			m_InitSuccess = false;
		}
	}

	protected override void UnInit()
	{
		NextTime = 0f;
		if (m_AbName != null)
		{
			BArrayPool<int>.Default.Recycle(m_AbName);
			m_AbName = null;
		}
		m_InitSuccess = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ItemAdd, AddNewBloodBottle);
	}
}
