using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.MultiPlayer;
using ACT.RichText;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;
using Utility;

namespace ACT.Model;

public class BloodBottleModel : Model<BloodBottleModel>, IJumpable
{
	private Dictionary<int, BloodBottleMaterial> _bottleMaterials;

	private int _curPotionId;

	private Dictionary<int, SceneBloodBottleInfo> _sceneAllBottles = new Dictionary<int, SceneBloodBottleInfo>();

	private int SetCount;

	private readonly Dictionary<int, BloodBottleData> _localBloodBottles = new Dictionary<int, BloodBottleData>();

	public Dictionary<int, BloodBottleMaterial> bottleMaterials => _bottleMaterials;

	public int curSceneEquipBloodBottleId => _curPotionId;

	public List<PresetTeam> allTeamProfiles => G.localPlayer.teamInfo.PresetTeams.ToList();

	public int leftCount
	{
		get
		{
			int num = CurTeamEquipBottle?.alreadyUseCount ?? 0;
			return Math.Max(0, curEquipRightCount - num);
		}
	}

	public int curEquipRightCount { get; private set; }

	public SceneBloodBottleInfo curSceneBloodBottleInfo => _sceneAllBottles[_curSceneStatus];

	public Dictionary<int, SceneBloodBottleInfo> sceneBloodBottles => _sceneAllBottles;

	private BloodBottleBuffHandler _buffHandler => Singleton<BloodBottleBuffHandler>.instance;

	private int _curSceneStatus => (int)MonoECS.instance.sceneStatus;

	public BloodBottleData curOperationBottle { get; private set; }

	public BloodBottleData CurTeamEquipBottle
	{
		get
		{
			if (!isCurSceneEquipLocalBloodBottle)
			{
				return GetBloodBottleById(curSceneEquipBloodBottleId);
			}
			return GetLocalBloodBottleById(curSceneEquipBloodBottleId);
		}
	}

	public IEnumerable<BloodBottleData> alreadyHaveBottles => GetAlreadyHaveBottles();

	public int guideDefaultSelectBottleId { get; private set; }

	public LuminModelType JumpSourceType => LuminModelType.BloodBottle;

	public bool isCurSceneEquipLocalBloodBottle { get; private set; }

	public IEnumerable<BloodBottleData> localBloodBottles => _localBloodBottles.Values;

	public void SetOperationBottle(BloodBottleData bottle)
	{
		curOperationBottle = bottle;
	}

	public void ChangeWorldPotion(SceneStatus sceneStatus, int bottleId)
	{
		_curPotionId = bottleId;
		isCurSceneEquipLocalBloodBottle = false;
		Model<BattleMainModel>.Interface.RefreshUIModuleState(UIMode.LittleItemMode);
	}

	public void SetWorldPotions(int sceneStatus, MapField<int, PotionItem> potions)
	{
		SceneBloodBottleInfo sceneBloodBottleInfo = default;
		if (_sceneAllBottles.ContainsKey(sceneStatus))
		{
			sceneBloodBottleInfo = _sceneAllBottles[sceneStatus];
			sceneBloodBottleInfo._allBottles.Clear();
		}
		else
		{
			sceneBloodBottleInfo = new SceneBloodBottleInfo(new Dictionary<int, BloodBottleData>());
			_sceneAllBottles.Add(sceneStatus, sceneBloodBottleInfo);
		}
		foreach (KeyValuePair<int, PotionData> potionData in RuntimeConfigs.data.potionDatas)
		{
			if (potions.TryGetValue(potionData.Key, out var value))
			{
				sceneBloodBottleInfo._allBottles[potionData.Key] = new BloodBottleData(potionData.Value, value);
				sceneBloodBottleInfo._allBottles[potionData.Key].SyncWineMatFromNtfData(potionData.Value, value.Additives.ToArray());
			}
			else if (potionData.Value.availableSceneTypes.Contains(sceneStatus))
			{
				sceneBloodBottleInfo._allBottles[potionData.Key] = new BloodBottleData(potionData.Value);
			}
		}
	}

	public void ChangeCurEquipRightCount(int count)
	{
		curEquipRightCount = count;
	}

	public IEnumerable<BloodBottleData> GetMainAlreadyHaveBottles()
	{
		return _sceneAllBottles[0]._allBottles.Values.Where((BloodBottleData b) => !b.isLock);
	}

	public BloodBottleData GetTargetSceneBloodBottleById(int id, int targetSceneStatus)
	{
		if (_sceneAllBottles.TryGetValue(targetSceneStatus, out var value))
		{
			return value._allBottles.GetValueOrDefault(id);
		}
		return null;
	}

	public IEnumerable<BloodBottleData> GetAlreadyHaveBottles()
	{
		if (!_sceneAllBottles.ContainsKey(_curSceneStatus))
		{
			return Enumerable.Empty<BloodBottleData>();
		}
		return _sceneAllBottles[_curSceneStatus]._allBottles.Values.Where((BloodBottleData b) => !b.isLock);
	}

	public BloodBottleData GetBloodBottleById(int id)
	{
		if (MonoECS.instance == null || G.localPlayer?.Profile == null)
		{
			return null;
		}
		if (_sceneAllBottles.TryGetValue(_curSceneStatus, out var value))
		{
			return value._allBottles?.GetValueOrDefault(id);
		}
		return null;
	}

	public BloodBottleData GetBloodBottleByItemId(int id)
	{
		if (_sceneAllBottles.TryGetValue(_curSceneStatus, out var value))
		{
			return value._allBottles.FirstOrDefault((KeyValuePair<int, BloodBottleData> i) => i.Value.id == id).Value;
		}
		return null;
	}

	public BloodBottleMaterial GetBottleMatById(int matId)
	{
		if (_bottleMaterials.TryGetValue(matId, out var value))
		{
			return value;
		}
		return null;
	}

	public BloodBottleData GetBottleThroughTeamIndex(int index)
	{
		using (List<PresetTeam>.Enumerator enumerator = allTeamProfiles.GetEnumerator())
		{
			if (enumerator.MoveNext())
			{
				PresetTeam current = enumerator.Current;
				return GetBloodBottleById(current.EquipPotionId);
			}
		}
		return null;
	}

	public int GetUnlockNextSlotLevel(int bottleId, int slotIndex)
	{
		PotionData data = CoreUtils.GetData(GetBloodBottleById(bottleId).uid, RuntimeConfigs.data.potionDatas);
		return Array.IndexOf(value: data.capacityLimit.FirstOrDefault((int x) => x == slotIndex + 1), array: data.capacityLimit) + 1;
	}

	private void InitMatData(SceneBloodBottleInfo bottleInfo)
	{
		_bottleMaterials = new Dictionary<int, BloodBottleMaterial>();
		G.localPlayer.Inventory.BloodBottleMaterials.Clear();
		foreach (Item item in G.localPlayer.Inventory.Items)
		{
			foreach (KeyValuePair<int, PotionAdditives> item2 in RuntimeConfigs.data.potionAdditivess)
			{
				if (item2.Value.itemId != item.Id || _bottleMaterials.ContainsKey(item2.Value.id))
				{
					continue;
				}
				_bottleMaterials[item2.Key] = new BloodBottleMaterial(item2.Value);
				foreach (KeyValuePair<int, BloodBottleData> allBottle in bottleInfo._allBottles)
				{
					if (allBottle.Value.materialIds.Contains(item2.Key))
					{
						_bottleMaterials[item2.Key].ResetEquipState(state: true);
						_bottleMaterials[item2.Key].SetBelongBottle(allBottle.Key);
					}
				}
				G.localPlayer.Inventory.BloodBottleMaterials.Add(_bottleMaterials[item2.Key]);
			}
		}
	}

	private void RefreshMatData(BaseEventContent obj)
	{
		if (_sceneAllBottles.ContainsKey((int)G.localPlayer.Profile.SceneStatus))
		{
			SceneBloodBottleInfo bottleInfo = _sceneAllBottles[(int)G.localPlayer.Profile.SceneStatus];
			InitMatData(bottleInfo);
			Singleton<BloodBottleBuffHandler>.instance.RefreshBuffData();
		}
	}

	private void UpdateBuffTarget(BaseEventContent obj)
	{
		BattleCharacterChangeEvt battleCharacterChangeEvt = obj as BattleCharacterChangeEvt;
		Singleton<BloodBottleBuffHandler>.instance.RemoveAllBuffsFromEntity(battleCharacterChangeEvt?.lastEb ?? default(Entity));
		Singleton<BloodBottleBuffHandler>.instance.ApplyAllBuffsToEntity(battleCharacterChangeEvt?.newEb ?? default(Entity));
	}

	private void GetNewBloodBottleItem(BaseEventContent obj)
	{
		if (!(obj is ItemUnifierProxyEvt itemUnifierProxyEvt) || itemUnifierProxyEvt.data.As<Item>().itemType != 16)
		{
			return;
		}
		foreach (KeyValuePair<int, PotionAdditives> item in RuntimeConfigs.data.potionAdditivess)
		{
			if (item.Value.itemId == itemUnifierProxyEvt.data.Id && !_bottleMaterials.ContainsKey(item.Value.id))
			{
				_bottleMaterials[item.Value.id] = new BloodBottleMaterial(item.Value);
				G.localPlayer.Inventory.BloodBottleMaterials.Add(_bottleMaterials[item.Value.id]);
			}
		}
	}

	private void OnPotionChange(BaseEventContent obj)
	{
		if (!(obj is PotionChangeEvt { potionItems: var potionItems } potionChangeEvt))
		{
			return;
		}
		SceneBloodBottleInfo sceneBloodBottleInfo = _sceneAllBottles[potionChangeEvt.sceneIndex];
		List<int> list = ListPool<int>.Get();
		int num = curSceneEquipBloodBottleId;
		bool flag = potionChangeEvt.sceneIndex == _curSceneStatus && num != 0 && potionItems.ContainsKey(num);
		if (flag && MPPlayer.local.battleEntity.IsValid)
		{
			_buffHandler.RemoveAllBuffsFromEntity(MPPlayer.local.battleEntity);
		}
		foreach (KeyValuePair<int, PotionItem> item in potionItems)
		{
			BloodBottleData bloodBottleData = sceneBloodBottleInfo._allBottles[item.Key];
			PotionData data = CoreUtils.GetData(item.Key, RuntimeConfigs.data.potionDatas);
			CharacterRepository characterRepository = CharacterDataHelper.GetCharacterRepository(potionChangeEvt.sceneIndex);
			if (bloodBottleData.isLock)
			{
				list.Add(data.itemId);
				bloodBottleData.SetLockState(state: false);
				bloodBottleData.SetRightCount(item.Value.MaxUse);
				characterRepository.Potions[item.Key] = item.Value;
				int num2 = data.capacityLimit.FirstOrDefault();
				List<int> list2 = ListPool<int>.Get();
				for (int i = 0; i < data.capacityLimit.LastOrDefault(); i++)
				{
					if (num2 >= i + 1)
					{
						list2.Add(0);
					}
					else
					{
						list2.Add(-1);
					}
				}
				sceneBloodBottleInfo._allBottles[item.Key].SetWineMatList(list2);
				if (potionChangeEvt.sceneIndex == 0)
				{
					G.localPlayer.Inventory.BloodBottles.Add(bloodBottleData);
				}
				ListPool<int>.Release(list2);
			}
			else
			{
				bloodBottleData.RefreshBottleData(item.Value);
				UpdateBottleUseCount(bloodBottleData, item.Value.UseCount);
				characterRepository.Potions[item.Key].MergeFrom(item.Value);
			}
		}
		if (flag)
		{
			_buffHandler.UpdateBuffData(num);
			if (MPPlayer.local.battleEntity.IsValid)
			{
				_buffHandler.AddAllBuffsToEntityWithoutRemove(MPPlayer.local.battleEntity);
			}
			if (Singleton<BloodBottleHandler>.HasInstance())
			{
				Singleton<BloodBottleHandler>.instance.SendBottleChangeUpdateHudComponent(num);
			}
		}
		foreach (int item2 in list)
		{
			if (G.localPlayer.Profile.SceneStatus != SceneStatus.Rogue)
			{
				Singleton<BloodBottleHandler>.instance.OpenGetBloodBottleUI(item2);
			}
		}
		ListPool<int>.Release(list);
	}

	public bool TryConsumeBottleUseCount(BloodBottleData bottle)
	{
		if (bottle == null || bottle.alreadyUseCount >= bottle.maxUseCount)
		{
			return false;
		}
		UpdateBottleUseCount(bottle, bottle.alreadyUseCount + 1);
		return true;
	}

	public void UpdateBottleUseCount(BloodBottleData bottle, int useCount)
	{
		bottle?.SetAlreadyUseCount(Mathf.Clamp(useCount, 0, bottle.maxUseCount));
	}

	public void ResetBottleUseCount(BloodBottleData bottle)
	{
		if (bottle == null)
		{
			return;
		}
		if (bottle.isLocalBottle)
		{
			UpdateBottleUseCount(bottle, 0);
			GameManager.bloodBottleRecoverUseCountSystem.CancelRecoverCd();
			return;
		}
		G.service.RecoverBottleUseCount(bottle.maxUseCount, (int count) =>
		{
			if (count != -1)
			{
				UpdateBottleUseCount(bottle, 0);
				GameManager.bloodBottleRecoverUseCountSystem.CancelRecoverCd();
			}
		});
	}

	public (float, float) GetBottleHealSkillLevelData(BloodBottleData bottle, int targetLevel)
	{
		int skillID = CoreUtils.GetData(bottle.uid, RuntimeConfigs.data.potionDatas).healSkillId * 1000 + 100 + targetLevel;
		SkillDetailLevelData bottleHealSkillLevelData = GetBottleHealSkillLevelData(skillID);
		return (bottleHealSkillLevelData.param1[0], bottleHealSkillLevelData.param1[1]);
	}

	public int GetBootleUseCount(BloodBottleData bottleData, int targetLevel)
	{
		return CoreUtils.GetData(bottleData.uid, RuntimeConfigs.data.potionDatas).usageLimit[targetLevel - 1];
	}

	public int GetBottleSlotCount(BloodBottleData bottleData, int targetLevel)
	{
		return CoreUtils.GetData(bottleData.uid, RuntimeConfigs.data.potionDatas).capacityLimit[targetLevel - 1];
	}

	public SkillDetailData GetBottleHealSkillData(BloodBottleData bottle)
	{
		return CoreUtils.GetData(CoreUtils.GetData(bottle.uid, RuntimeConfigs.data.potionDatas).healSkillId, RuntimeConfigs.data.skillDetailDatas);
	}

	public SkillDetailLevelData GetBottleHealSkillLevelData(int skillID)
	{
		return CoreUtils.GetData(skillID, RuntimeConfigs.data.skillDetailLevelDatas);
	}

	protected override async void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, UpdateBuffTarget);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ItemAdd, GetNewBloodBottleItem);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeEnterWorld, RefreshMatData);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeLeaveWorld, ClearLocalBloodBottles);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.PotionChange, OnPotionChange);
		await UniTask.WaitUntil(() => MonoECS.instance.isStartWorld);
		Singleton<BloodBottleHandler>.CreateInstance();
		Singleton<BloodBottleBuffHandler>.CreateInstance();
		if (curSceneEquipBloodBottleId != 0)
		{
			_buffHandler.UpdateBuffData(curSceneEquipBloodBottleId);
			_buffHandler.ApplyAllBuffsToEntity(MPPlayer.local.battleEntity);
		}
	}

	protected override void UnInit()
	{
		Singleton<BloodBottleHandler>.DestroyInstance();
		Singleton<BloodBottleBuffHandler>.DestroyInstance();
		_sceneAllBottles.Clear();
		ClearLocalBloodBottles();
		_bottleMaterials.Clear();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, UpdateBuffTarget);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ItemAdd, GetNewBloodBottleItem);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeEnterWorld, RefreshMatData);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeLeaveWorld, ClearLocalBloodBottles);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.PotionChange, OnPotionChange);
	}

	public void SetGuideDefaultSelectBloodBottle(int bottleId)
	{
		guideDefaultSelectBottleId = bottleId;
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.BloodBottleCultivate))
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Forbidden,
				Message = GetBottleSystemUnLockPreconditionTip()
			};
		}
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.CanJump
		};
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_BLOODBOTTLE, new BloodBottleViewData
		{
			curOperateBottle = jumpData.Params[2],
			needFuzzy = (jumpData.Params[3] != 0),
			dataFromTeam = (jumpData.Params[4] != 0),
			dataFromAbyss = (jumpData.Params[5] != 0)
		}).Forget();
	}

	public string GetBottleSystemUnLockPreconditionTip()
	{
		MissionGroup data = CoreUtils.GetData(CoreUtils.GetData(103601, RuntimeConfigs.data.systemOpens).missionId, RuntimeConfigs.data.missionGroups);
		if (data == null)
		{
			return string.Empty;
		}
		ACT.Config.Mission mission = RuntimeConfigs.data.missions[data.missionId[0]];
		if (mission == null)
		{
			return string.Empty;
		}
		return CustomTagParser.ReplacePreconditionText(mission, mission.number, mission.param);
	}

	public bool CurSceneCanCultivation()
	{
		switch (MonoECS.instance.sceneStatus)
		{
		case SceneStatus.Main:
			return true;
		case SceneStatus.Trainingground:
			return true;
		case SceneStatus.Lounge:
			return false;
		case SceneStatus.Rogue:
			return false;
		default:
		{
			WorldChallengeState? worldChallengeState = Singleton<GameManager>.instance.worldManager.GetCurrentWorld()?.WorldChallengeState;
			return !worldChallengeState.HasValue || worldChallengeState != WorldChallengeState.Normal;
		}
		}
	}

	public bool TryCreateLocalBloodBottle(int trialBottleId, out BloodBottleData bottle)
	{
		if (!RuntimeConfigs.data.trialPotions.TryGetValue(trialBottleId, out var value) || value == null)
		{
			bottle = null;
			return false;
		}
		LocalBloodBottleCreateData createData = new LocalBloodBottleCreateData
		{
			bottleUid = value.potionid,
			level = value.level,
			materialIds = value.additives
		};
		if (!RuntimeConfigs.data.potionDatas.TryGetValue(createData.bottleUid, out var value2))
		{
			bottle = null;
			return false;
		}
		int valueOrDefault = value2.usageLimit.GetValueOrDefault(createData.level - 1, 0);
		return TryCreateLocalBloodBottle(trialBottleId, createData, valueOrDefault, 0, out bottle);
	}

	public bool TryCreateTrialBloodBottle(int trialPotionConfigId, PotionItem trialPotion, out BloodBottleData bottle)
	{
		bottle = null;
		if (!RuntimeConfigs.data.trialPotions.TryGetValue(trialPotionConfigId, out var value) || value == null)
		{
			return false;
		}
		int num = ((trialPotion != null && trialPotion.Level > 0) ? trialPotion.Level : value.level);
		int[] materialIds = ((trialPotion != null && trialPotion.Additives.Count > 0) ? trialPotion.Additives.ToArray() : value.additives);
		LocalBloodBottleCreateData createData = new LocalBloodBottleCreateData
		{
			bottleUid = value.potionid,
			level = num,
			materialIds = materialIds
		};
		if (!RuntimeConfigs.data.potionDatas.TryGetValue(createData.bottleUid, out var value2))
		{
			return false;
		}
		int useCountLimit = ((trialPotion != null && trialPotion.MaxUse > 0) ? trialPotion.MaxUse : value2.usageLimit.GetValueOrDefault(num - 1, 0));
		return TryCreateLocalBloodBottle(trialPotionConfigId, createData, useCountLimit, trialPotion?.UseCount ?? 0, out bottle);
	}

	public bool RemoveLocalBloodBottle(int localBottleId)
	{
		if (!_localBloodBottles.Remove(localBottleId))
		{
			return false;
		}
		if (isCurSceneEquipLocalBloodBottle && curSceneEquipBloodBottleId == localBottleId)
		{
			if (Singleton<BloodBottleBuffHandler>.HasInstance())
			{
				if (MPPlayer.local.battleEntity.IsValid)
				{
					_buffHandler.RemoveAllBuffsFromEntity(MPPlayer.local.battleEntity);
				}
				_buffHandler.UpdateBuffData(0);
			}
			ChangeWorldPotion(MonoECS.instance.sceneStatus, 0);
			if (Singleton<BloodBottleHandler>.HasInstance())
			{
				Singleton<BloodBottleHandler>.instance.SendBottleChangeUpdateHudComponent(0);
			}
		}
		return true;
	}

	public BloodBottleData GetLocalBloodBottleById(int localBottleId)
	{
		return _localBloodBottles.GetValueOrDefault(localBottleId);
	}

	public bool ChangeWorldLocalPotion(int localBottleId)
	{
		if (!_localBloodBottles.ContainsKey(localBottleId))
		{
			return false;
		}
		_curPotionId = localBottleId;
		isCurSceneEquipLocalBloodBottle = true;
		Model<BattleMainModel>.Interface.RefreshUIModuleState(UIMode.LittleItemMode);
		_buffHandler.UpdateBuffData(localBottleId);
		if (MPPlayer.local.battleEntity.IsValid)
		{
			_buffHandler.ApplyAllBuffsToEntity(MPPlayer.local.battleEntity);
		}
		Singleton<BloodBottleHandler>.instance.SendBottleChangeUpdateHudComponent(localBottleId);
		return true;
	}

	public void ClearLocalBloodBottles(BaseEventContent obj = null)
	{
		if (isCurSceneEquipLocalBloodBottle)
		{
			if (Singleton<BloodBottleBuffHandler>.HasInstance())
			{
				if (MPPlayer.local.battleEntity.IsValid)
				{
					_buffHandler.RemoveAllBuffsFromEntity(MPPlayer.local.battleEntity);
				}
				_buffHandler.UpdateBuffData(0);
			}
			ChangeWorldPotion(MonoECS.instance.sceneStatus, 0);
			if (Singleton<BloodBottleHandler>.HasInstance())
			{
				Singleton<BloodBottleHandler>.instance.SendBottleChangeUpdateHudComponent(0);
			}
		}
		_localBloodBottles.Clear();
	}

	private bool TryCreateLocalBloodBottle(int localBottleId, LocalBloodBottleCreateData createData, int useCountLimit, int useCount, out BloodBottleData bottle)
	{
		bottle = null;
		if (!RuntimeConfigs.data.potionDatas.TryGetValue(createData.bottleUid, out var value) || createData.level < 1 || createData.level > value.levelLimit)
		{
			return false;
		}
		if (_localBloodBottles.TryGetValue(localBottleId, out bottle))
		{
			if (bottle.uid != createData.bottleUid)
			{
				bottle = null;
				return false;
			}
			bottle.InitializeLocalData(createData.level, useCountLimit, useCount, createData.materialIds ?? Array.Empty<int>());
			return true;
		}
		bottle = new BloodBottleData(value);
		bottle.InitializeLocalData(createData.level, useCountLimit, useCount, createData.materialIds ?? Array.Empty<int>());
		_localBloodBottles.Add(localBottleId, bottle);
		if (Singleton<BloodBottleBuffHandler>.HasInstance())
		{
			Singleton<BloodBottleBuffHandler>.instance.CacheBottleSkills(bottle);
		}
		return true;
	}
}
