using System;
using System.Collections.Generic;
using ACT.CharacterProperty;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Newtonsoft.Json.Linq;
using UnityEngine;

namespace ACT.Model;

public class EquipModel : Model<EquipModel>, IJumpable
{
	public const int EquipSlotCount = 4;

	public Dictionary<int, EquipSlotInfo[]> SlotInfos { get; set; }

	public LuminModelType JumpSourceType => LuminModelType.Equipment;

	protected override void Init()
	{
		SlotInfos = DictionaryPool<int, EquipSlotInfo[]>.Get();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, RefreshCharacterEquipSlots);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Character_ChangeEquip, OnCharacterChangeEquip);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnCharcterNtf, RefreshCharacterEquipSlots);
	}

	private void OnCharacterChangeGem(BaseEventContent obj)
	{
		CharacterChangeGemEvt characterChangeGemEvt = (CharacterChangeGemEvt)obj;
		if (characterChangeGemEvt.Equip != null)
		{
			DoChangeEquipProperties(characterChangeGemEvt.character);
		}
	}

	private void OnCharacterChangeEquip(BaseEventContent obj)
	{
		CharacterChangeEquipEvt characterChangeEquipEvt = (CharacterChangeEquipEvt)obj;
		if (characterChangeEquipEvt.character != null)
		{
			DoChangeEquipProperties(characterChangeEquipEvt.character);
		}
	}

	private void DoChangeEquipProperties(Character c)
	{
		ChangeSystemProperties evt = Singleton<EventManager>.instance.GetEvt<ChangeSystemProperties>();
		c?.Refresh();
		evt.systemSource = 3;
		evt.isReplace = true;
		evt.properties = c.GetEquipProperty();
		evt.traget = c;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.ChangeSystemProperties, evt);
		SyncSystemPropertiesToBattle evt2 = Singleton<EventManager>.instance.GetEvt<SyncSystemPropertiesToBattle>();
		Dictionary<int, float> properties = DictionaryPool<int, float>.Get();
		c?.systemProperty.GetSystemPropertiesBySource(SystemPropertySource.Equip, ref properties);
		if (properties.Count > 0)
		{
			evt2.traget = c;
			evt2.properties = properties;
			evt2.isRemove = false;
			evt2.propertySourceUid = 3;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.SyncSystemPropertiesChangeToBattle, evt2);
		}
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt2);
		DictionaryPool<int, float>.Release(properties);
	}

	protected override void UnInit()
	{
		DictionaryPool<int, EquipSlotInfo[]>.Release(SlotInfos);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterEnterWorld, RefreshCharacterEquipSlots);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Character_ChangeEquip, OnCharacterChangeEquip);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnCharcterNtf, RefreshCharacterEquipSlots);
	}

	private void RefreshCharacterEquipSlots(BaseEventContent evt)
	{
		RefreshCharacterEquipSlots();
	}

	private void RefreshCharacterEquipSlots()
	{
		SlotInfos.Clear();
		List<Character> curAllCharacters = CharacterDataHelper.GetCurAllCharacters();
		if (curAllCharacters != null)
		{
			for (int i = 0; i < curAllCharacters.Count; i++)
			{
				Character character = curAllCharacters[i];
				SlotInfos[character.Id] = DeserializeSlots(character.Id);
			}
		}
	}

	private EquipSlotInfo[] DeserializeSlots(int characterID)
	{
		string text = ServerPlayerPrefs.GetString($"EquipInfo_{characterID}", string.Empty);
		EquipSlotInfo[] array = null;
		if (!string.IsNullOrEmpty(text))
		{
			try
			{
				array = (JObject.Parse(text)["slotInfo"] as JArray)?.ToObject<EquipSlotInfo[]>();
			}
			catch (Exception exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception);
				}
			}
		}
		int num = Math.Max(array?.Length ?? 0, 4);
		EquipSlotInfo[] array2 = new EquipSlotInfo[num];
		for (int i = 0; i < num; i++)
		{
			EquipSlotInfo equipSlotInfo = ((array != null && i < array.Length) ? array[i] : null);
			if (equipSlotInfo == null)
			{
				equipSlotInfo = new EquipSlotInfo();
			}
			EquipSlotInfo equipSlotInfo2 = equipSlotInfo;
			if (equipSlotInfo2.SuitIDs == null)
			{
				HashSet<int> hashSet = (equipSlotInfo2.SuitIDs = new HashSet<int>());
			}
			equipSlotInfo2 = equipSlotInfo;
			if (equipSlotInfo2.SortIDs == null)
			{
				List<int> list = (equipSlotInfo2.SortIDs = new List<int>());
			}
			array2[i] = equipSlotInfo;
		}
		return array2;
	}

	public void SerializeSlots()
	{
		foreach (KeyValuePair<int, EquipSlotInfo[]> slotInfo in SlotInfos)
		{
			JObject jObject = new JObject();
			jObject.Add("slotInfo", JArray.FromObject(slotInfo.Value));
			ServerPlayerPrefs.SetString($"EquipInfo_{slotInfo.Key}", jObject.ToString());
		}
		ServerPlayerPrefs.Save();
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Equip))
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Forbidden,
				Message = Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.Equip)
			};
		}
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.CanJump
		};
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		switch (jumpData.Params[1])
		{
		case 0:
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_EQUIPBUILD).Forget();
			break;
		case 1:
			Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_GEMREBUILD).Forget();
			break;
		}
	}

	public bool CanBuildEquip(EquipData equipData)
	{
		if (equipData == null)
		{
			return false;
		}
		EquipCreatMaterialData data = CoreUtils.GetData(equipData.CreatmaterialListID, RuntimeConfigs.data.equipCreatMaterialDatas);
		if (data == null)
		{
			return false;
		}
		if (G.localPlayer.Inventory.GetItemCount(2) >= data.coinEach)
		{
			return GameUtility.ItemsIsEnough(data.equipMaterialItem);
		}
		return false;
	}
}
