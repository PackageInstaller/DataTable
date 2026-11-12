using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using UnityEngine;

[Serializable]
public class GameTeamConfig
{
	[SerializeField]
	[JsonRequired]
	public bool useUltraSkillLoadParams;

	[SerializeField]
	[JsonRequired]
	public bool playerUltraSkillPlayTimeline;

	[SerializeField]
	[JsonRequired]
	public bool playerIngoreCDAndEnergy;

	[JsonRequired]
	[SerializeField]
	private List<tmpThemeList> themeList = new List<tmpThemeList>();

	[JsonRequired]
	[SerializeField]
	private List<OutfiInfo> outfitList = new List<OutfiInfo>();

	[JsonRequired]
	[SerializeField]
	private List<NoteInfo> noteList = new List<NoteInfo>();

	[JsonRequired]
	[SerializeField]
	private List<FateCardThemeInfo> fateCardThemeInfos = new List<FateCardThemeInfo>();

	[JsonRequired]
	[SerializeField]
	private List<int> travelerDuelAffixes = new List<int>();

	[JsonRequired]
	[SerializeField]
	private List<DiskInfo> diskList = new List<DiskInfo>();

	public GameActorConfig[] gameActorConfigs = new GameActorConfig[3]
	{
		new GameActorConfig(),
		new GameActorConfig(),
		new GameActorConfig()
	};

	[JsonIgnore]
	public bool UseUltraSkillLoadParams => useUltraSkillLoadParams;

	[JsonIgnore]
	public bool PlayerUltraSkillPlayTimeline => playerUltraSkillPlayTimeline;

	[JsonIgnore]
	public bool PlayerIngoreCDAndEnergy => playerIngoreCDAndEnergy;

	[JsonIgnore]
	public List<int> TravelerDuelAffixes => travelerDuelAffixes;

	[JsonIgnore]
	public int[] ActorIDs => gameActorConfigs.Select((GameActorConfig t) => t.actorID).ToArray();

	[JsonIgnore]
	public int[] ActorSkins => gameActorConfigs.Select((GameActorConfig t) => t.skin).ToArray();

	[JsonIgnore]
	public int[] BreakCounts => gameActorConfigs.Select((GameActorConfig t) => t.breakCount).ToArray();

	[JsonIgnore]
	public int[] Levels => gameActorConfigs.Select((GameActorConfig t) => t.Level).ToArray();

	[JsonIgnore]
	public tmpActorBTalentList[] ActorBTalentList => gameActorConfigs.Select((GameActorConfig t) => t.talentList).ToArray();

	[JsonIgnore]
	public List<tmpThemeList> ThemeList => themeList;

	[JsonIgnore]
	public List<OutfiInfo> OutfiList => outfitList;

	[JsonIgnore]
	public List<NoteInfo> NoteList => noteList;

	[JsonIgnore]
	public List<tempActorHeartStonInfo> StoneHeartList => gameActorConfigs.Select((GameActorConfig t) => new tempActorHeartStonInfo
	{
		actorId = t.actorID,
		stoneHeartLv = t.actorLv
	}).ToList();

	public void CopyFrom(GameTeamConfig other)
	{
		useUltraSkillLoadParams = other.useUltraSkillLoadParams;
		playerUltraSkillPlayTimeline = other.playerUltraSkillPlayTimeline;
		playerIngoreCDAndEnergy = other.playerIngoreCDAndEnergy;
		themeList.Clear();
		foreach (tmpThemeList theme in other.themeList)
		{
			tmpThemeList tmpThemeList2 = new tmpThemeList();
			tmpThemeList2.LoadFrom(theme);
			themeList.Add(tmpThemeList2);
		}
		outfitList.Clear();
		foreach (OutfiInfo outfit in other.outfitList)
		{
			OutfiInfo outfiInfo = new OutfiInfo();
			outfiInfo.LoadFrom(outfit);
			outfitList.Add(outfiInfo);
		}
		noteList.Clear();
		foreach (NoteInfo note in other.noteList)
		{
			NoteInfo noteInfo = new NoteInfo();
			noteInfo.LoadFrom(note);
			noteList.Add(noteInfo);
		}
		fateCardThemeInfos.Clear();
		foreach (FateCardThemeInfo fateCardThemeInfo2 in other.fateCardThemeInfos)
		{
			FateCardThemeInfo fateCardThemeInfo = new FateCardThemeInfo();
			fateCardThemeInfo.LoadFrom(fateCardThemeInfo2);
			fateCardThemeInfos.Add(fateCardThemeInfo);
		}
		travelerDuelAffixes.Clear();
		travelerDuelAffixes.AddRange(other.travelerDuelAffixes);
		for (int i = 0; i < other.gameActorConfigs.Length; i++)
		{
			gameActorConfigs[i].LoadFrom(other.gameActorConfigs[i]);
		}
		diskList.Clear();
		foreach (DiskInfo disk in other.diskList)
		{
			DiskInfo diskInfo = new DiskInfo();
			diskInfo.LoadFrom(disk);
			diskList.Add(diskInfo);
		}
	}

	public void ResetActorConfigs(GameActorConfig[] actorConfigs)
	{
		gameActorConfigs = actorConfigs;
	}

	public void ResetActorConfigs(int[] actorIDs, int[] skinIDs = null)
	{
		if (AdventureGameContext.IsTestBattle)
		{
			for (int i = 0; i < gameActorConfigs.Length; i++)
			{
				GameActorConfig gameActorConfig = gameActorConfigs[i];
				gameActorConfig.actorID = actorIDs[i];
				if (skinIDs != null && i < skinIDs.Length)
				{
					gameActorConfig.skin = skinIDs[i];
				}
				gameActorConfigs[i] = gameActorConfig;
			}
			return;
		}
		gameActorConfigs = new GameActorConfig[actorIDs.Length];
		for (int j = 0; j < actorIDs.Length; j++)
		{
			GameActorConfig gameActorConfig2 = new GameActorConfig();
			gameActorConfig2.actorID = actorIDs[j];
			if (skinIDs != null && j < skinIDs.Length)
			{
				gameActorConfig2.skin = skinIDs[j];
			}
			gameActorConfigs[j] = gameActorConfig2;
		}
	}

	public static void ResetTeamConfigs(int[] actorIDs, int[] skinIDs = null)
	{
		GameTeamConfig gameTeamConfig = AdventureGameContext.TeamConfig;
		if (gameTeamConfig == null)
		{
			gameTeamConfig = new GameTeamConfig();
		}
		if (actorIDs != null && actorIDs.Length != 0)
		{
			gameTeamConfig.ResetActorConfigs(actorIDs, skinIDs);
			AdventureGameContext.TeamConfig = gameTeamConfig;
		}
	}

	private void OnPlayerIgnoreCDAndEnergyValueChange()
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("PlayerIgnoreCDAndEnergyValueChange", playerIngoreCDAndEnergy);
	}

	public void ResetTravelerDuelAffixs(List<int> travelerDuelAffixes)
	{
		this.travelerDuelAffixes = travelerDuelAffixes;
	}

	public void ResetBTalent()
	{
		ModuleController<AdventureModuleController>.Instance.PersonalPerkInfos.Clear();
		for (int i = 0; i < gameActorConfigs.Length; i++)
		{
			gameActorConfigs[i].ResetBTalent();
		}
	}

	public void ResetSkillSlotLevel()
	{
		ResetSkillSlotLevel(isInit: false);
	}

	public void ResetSkillSlotLevel(bool isInit)
	{
		for (int i = 0; i < gameActorConfigs.Length; i++)
		{
			gameActorConfigs[i].ResetActorSkillSlotInfos(isInit);
		}
	}

	public void ResetActorLevel()
	{
		for (int i = 0; i < gameActorConfigs.Length; i++)
		{
			gameActorConfigs[i].ResetActorLevel();
		}
	}

	public void ResetTheme()
	{
		List<int> list = new List<int>();
		List<Lua2CSharpInfo_TPPerkInfo> list2 = new List<Lua2CSharpInfo_TPPerkInfo>();
		foreach (tmpThemeList theme in themeList)
		{
			list.Add(theme.themeId);
			foreach (tempPerkInfo perk in theme.perkList)
			{
				Lua2CSharpInfo_TPPerkInfo item = new Lua2CSharpInfo_TPPerkInfo
				{
					perkId = perk.perkId,
					nCount = perk.perkLv
				};
				list2.Add(item);
			}
		}
		AdventureModuleHelper.SetRglTheme(list.ToArray());
		AdventureModuleHelper.ChangeThemePerkIds(list2.ToArray());
		ActorRefreshThemePerk actorRefreshThemePerk = ActorRefreshThemePerk.Generate();
		actorRefreshThemePerk.sender = this;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(actorRefreshThemePerk);
	}

	public void ResetFateCardTheme()
	{
		Lua2CSharpInfo_FateCardThemeInfo[] array = new Lua2CSharpInfo_FateCardThemeInfo[fateCardThemeInfos.Count];
		for (int i = 0; i < fateCardThemeInfos.Count; i++)
		{
			FateCardThemeInfo fateCardThemeInfo = fateCardThemeInfos.get_Item(i);
			Lua2CSharpInfo_FateCardThemeInfo lua2CSharpInfo_FateCardThemeInfo = new Lua2CSharpInfo_FateCardThemeInfo
			{
				operateType = 2,
				theme = fateCardThemeInfo.theme,
				rank = fateCardThemeInfo.rank,
				triggerTypes = fateCardThemeInfo.types.ToArray()
			};
			array[i] = lua2CSharpInfo_FateCardThemeInfo;
		}
		ModuleController<AdventureModuleController>.Instance.SetFateCardThemes(array);
	}

	public void ResetNote()
	{
		MonoSingleton<LuaManager>.Instance?.FireEvent("TestBedNoteChange", noteList);
	}

	public void ResetDisc()
	{
		SceneSingleton<AdventurePlayerController>.Instance.DisableDiscScripts();
		ModuleController<AdventureModuleController>.Instance.ClearDiscInfos();
		List<Lua2CSharpInfo_DiscInfo> list = new List<Lua2CSharpInfo_DiscInfo>();
		for (int i = 0; i < diskList.Count; i++)
		{
			DiskInfo diskInfo = diskList.get_Item(i);
			string discScript = "AIScript.Disc.Disc_" + diskInfo.Id;
			List<Lua2CSharpInfo_DiscSkillInfo> list2 = new List<Lua2CSharpInfo_DiscSkillInfo>();
			for (int j = 0; j < diskInfo.skillInfos.Count; j++)
			{
				list2.Add(new Lua2CSharpInfo_DiscSkillInfo
				{
					skillId = diskInfo.skillInfos.get_Item(j).skillId,
					skillLevel = diskInfo.skillInfos.get_Item(j).skillLevel
				});
			}
			Lua2CSharpInfo_DiscInfo item = new Lua2CSharpInfo_DiscInfo
			{
				discId = diskInfo.Id,
				discScript = discScript,
				skillInfos = list2.ToArray()
			};
			list.Add(item);
		}
		ModuleController<AdventureModuleController>.Instance.SetDiscInfos(list.ToArray());
		SceneSingleton<AdventurePlayerController>.Instance.EnableDiscScripts();
	}

	public void ResetDiscAuto()
	{
		List<Lua2CSharpInfo_DiscInfo> list = new List<Lua2CSharpInfo_DiscInfo>();
		for (int i = 0; i < diskList.Count; i++)
		{
			DiskInfo diskInfo = diskList.get_Item(i);
			string discScript = "AIScript.Disc.Disc_" + diskInfo.Id;
			List<Lua2CSharpInfo_DiscSkillInfo> list2 = new List<Lua2CSharpInfo_DiscSkillInfo>();
			for (int j = 0; j < diskInfo.skillInfos.Count; j++)
			{
				list2.Add(new Lua2CSharpInfo_DiscSkillInfo
				{
					skillId = diskInfo.skillInfos.get_Item(j).skillId,
					skillLevel = diskInfo.skillInfos.get_Item(j).skillLevel
				});
			}
			Lua2CSharpInfo_DiscInfo item = new Lua2CSharpInfo_DiscInfo
			{
				discId = diskInfo.Id,
				discScript = discScript,
				skillInfos = list2.ToArray()
			};
			list.Add(item);
		}
		ModuleController<AdventureModuleController>.Instance.SetDiscInfos(list.ToArray());
	}

	public void ResetBTalentAndStoneHeart()
	{
		ResetBTalent();
		ResetActorLevel();
		ResetFateCardTheme();
		ResetSkillSlotLevel(isInit: true);
		ResetDiscAuto();
	}
}
