using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.World;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class RaidListenerManager
{
	private int rewardIndex;

	private int doubleRaidParamKey;

	public RaidListenerManager()
	{
		Singleton<GameManager>.instance.worldManager.RegisterOnWorldChangedCallback(OnSceneChanged);
	}

	private void OnSceneChanged(IConfigWorldPartition partition)
	{
		rewardIndex = -1;
		doubleRaidParamKey = -1;
		UnRegister();
		if (G.localPlayer.Profile.SceneStatus == SceneStatus.Raid)
		{
			int currentRaidId = Model<RaidModel>.Interface.CurrentRaidId;
			int belongEntranceData = RuntimeConfigs.data.raids[currentRaidId].belongEntranceData;
			if (RuntimeConfigs.data.raidEntranceDatas.TryGetValue(belongEntranceData, out var value) && IsRaidMultipleCosts(value.raidType))
			{
				Register();
			}
		}
	}

	private void Register()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnSpawnMonsterDataPart, OnSpawnMonsterData);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnSpawnCharacterBattlePart, OnSpawnCharacterBattlePart);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnRemoveCharacterBattlePart, OnRemoveCharacterBattlePart);
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				AddPlayerProperty(teamCharacter);
			}
		}
	}

	private void UnRegister()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnSpawnMonsterDataPart, OnSpawnMonsterData);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnSpawnCharacterBattlePart, OnSpawnCharacterBattlePart);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnRemoveCharacterBattlePart, OnRemoveCharacterBattlePart);
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = MonoECS.instance.localPlayer.GetTeamCharacter(i);
			if (teamCharacter != null)
			{
				RemovePlayerProperty(teamCharacter);
			}
		}
	}

	public bool IsRaidMultipleCosts(int raidType)
	{
		return raidType == 1;
	}

	private void OnSpawnMonsterData(BaseEventContent evt)
	{
		if (evt is SpawnMonsterDataPartEvt spawnMonsterDataPartEvt && RuntimeConfigs.data.doubleRaidParas.TryGetValue(doubleRaidParamKey, out var value))
		{
			Entity entityBehave = spawnMonsterDataPartEvt.entityBehave;
			CoreUtils.StartPropertyCal();
			CoreUtils.AddProperties(value.enemyProperty);
			CompAbility? compAbility = entityBehave.GetCompAbility();
			compAbility.PushProperties(CoreUtils.s_PropertyCal, needCal: false, PropertySource.Raid, entityBehave.GetCompMonster().id);
			compAbility.CalAllProperty();
		}
	}

	private void OnRemoveCharacterBattlePart(BaseEventContent content)
	{
		RemoveCharacterBattlePartEvt removeCharacterBattlePartEvt = content as RemoveCharacterBattlePartEvt;
		RemovePlayerProperty(removeCharacterBattlePartEvt.entityBehave);
	}

	private void OnSpawnCharacterBattlePart(BaseEventContent content)
	{
		SpawnCharacterBattlePartEvt spawnCharacterBattlePartEvt = content as SpawnCharacterBattlePartEvt;
		AddPlayerProperty(spawnCharacterBattlePartEvt.entityBehave);
	}

	public void AddPlayerProperty(Entity entityBehave)
	{
		if (entityBehave.IsCharacter() && RuntimeConfigs.data.doubleRaidParas.TryGetValue(doubleRaidParamKey, out var value))
		{
			CoreUtils.StartPropertyCal();
			CoreUtils.AddProperties(value.playerProperty);
			CompAbility? compAbility = entityBehave.GetCompAbility();
			compAbility.PushProperties(CoreUtils.s_PropertyCal, needCal: false, PropertySource.Raid, entityBehave.GetCompCharacter().characterSource.Id());
			compAbility.CalAllProperty();
		}
	}

	public void RemovePlayerProperty(Entity entityBehave)
	{
		if (RuntimeConfigs.data.doubleRaidParas.TryGetValue(doubleRaidParamKey, out var value))
		{
			CoreUtils.StartPropertyCal();
			CoreUtils.AddProperties(value.playerProperty);
			CompAbility? compAbility = entityBehave.GetCompAbility();
			compAbility.RemoveProperties(CoreUtils.s_PropertyCal, needCal: false, PropertySource.Raid, entityBehave.GetCompCharacter().characterSource.Id());
			compAbility.CalAllProperty();
		}
	}

	public int GetRaidZoomLevel()
	{
		if (RuntimeConfigs.data.doubleRaidParas.TryGetValue(doubleRaidParamKey, out var value))
		{
			return value.zoomLevel;
		}
		return 1;
	}
}
