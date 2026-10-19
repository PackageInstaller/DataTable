using System;
using ACT.Game.Data;
using ACT.Model;
using ACT.Net;
using Google.Protobuf.Collections;
using Runtime.Model;
using UnityEngine;

namespace ACT.Game;

public class LocalSave : ScriptableObject
{
	public string openID;

	public string nickName;

	public LocalPlayerProfile playerProfile;

	public LocalCharacterProfile[] characters;

	public LocalInventorySave inventory;

	public LocalMissionSave mission;

	public Attribute[] attributes;

	public LoaclAssistSave robot;

	public LocalNPCInfo[] npcs;

	public LocalMapSave[] maps;

	public int[] openSystems;

	public Player ToPB()
	{
		Player player = new Player();
		player.Profile = playerProfile.ToPB();
		player.Inventory = inventory.ToPB();
		CharacterRepository characterRepository = new CharacterRepository();
		for (int i = 0; i < characters.Length; i++)
		{
			Character character = characters[i].ToPB();
			character.Refresh();
			characterRepository.Characters.Add(character.Id, character);
		}
		player.characterRepository[0] = characterRepository;
		for (int j = 0; j < robot.assists.Length; j++)
		{
			player.Robots.Add(robot.assists[j].ToPB());
		}
		for (int k = 0; k < mission.states.Length; k++)
		{
			player.Missions.Add(mission.states[k].ToPB());
		}
		for (int l = 0; l < npcs.Length; l++)
		{
			player.Npcs.Add(npcs[l].ToPB());
		}
		for (int m = 0; m < maps.Length; m++)
		{
			player.Maps.Add(maps[m].wid, maps[m].ToPB());
		}
		for (int n = 0; n < openSystems.Length; n++)
		{
			player.OpenSystems.Add(openSystems[n]);
		}
		Achievements achievements = new Achievements();
		achievements.Info = new AchievementInfo();
		achievements.ProgressData = new AchievementProgressData();
		player.Achievements = achievements;
		player.littleItems = new LittleItems();
		player.AssistantSystem = new AssistantSystem();
		LocalTeam[] teams = playerProfile.teams;
		foreach (LocalTeam localTeam in teams)
		{
			player.teamInfo.PresetTeams.Add(localTeam.ToPB());
		}
		BuildSaveInfo(player);
		Model<TreasureModel>.CreateModel();
		Model<BloodBottleModel>.CreateModel();
		Model<BloodBottleModel>.Interface.SetWorldPotions(0, new MapField<int, PotionItem>());
		Model<CharacterModel>.CreateModel();
		Model<TheOtherWorldModel>.CreateModel();
		return player;
	}

	public DetailUserInfo ToUserPB()
	{
		DetailUserInfo detailUserInfo = new DetailUserInfo();
		BriefUserInfo briefUserInfo = (detailUserInfo.Brief = new BriefUserInfo());
		briefUserInfo.OpenId = openID;
		briefUserInfo.Nickname = nickName;
		Attribute[] array = attributes;
		for (int i = 0; i < array.Length; i++)
		{
			Attribute attribute = array[i];
			detailUserInfo.Attributes.Add((int)attribute.playerAttribute, attribute.keyValue);
		}
		foreach (int value2 in Enum.GetValues(typeof(PlayerAttribute)))
		{
			if (!detailUserInfo.Attributes.TryGetValue(value2, out var _))
			{
				detailUserInfo.Attributes.Add(value2, 0L);
			}
		}
		return detailUserInfo;
	}

	private async void BuildSaveInfo(Player player)
	{
	}
}
