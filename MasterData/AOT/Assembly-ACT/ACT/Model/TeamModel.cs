using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Utility;
using UnityEngine;

namespace ACT.Model;

public class TeamModel : Model<TeamModel>, IJumpable
{
	public int curSelectedIndex;

	public int lastSelectedIndex;

	public int curBattleIndex;

	public int curSeatIndex;

	public List<PresetTeam> uiTeamProfiles;

	public List<PresetTeam> rawTeamProfile;

	public int rawBattleIndex;

	private int _strongGuideAddBtnIndex;

	private int _strongGuideCharacterId;

	private const int RECOMMENDLEVEL_OFFSET = 5;

	public TeamProfileSource source;

	public int[] templeCharactersId;

	public int[] rawTempleCharactersId;

	public List<PresetTeam> raidTeamProfiles;

	public PresetTeam traingingGroundProfiles;

	public PresetTeam templeGroundProfiles;

	public List<PresetTeam> rawRaidTeamProfiles;

	public int[] rawTrainingGroudCharactersId;

	public int[] trainingGroudCharactersId;

	public bool bagSingleSelect;

	public int singleSelectCharacter;

	public int[] quickSelectCharacters;

	public int templeId;

	public bool teamSelectBagInit;

	private Action _onQuickSelectPopClosed;

	public int StrongGuideAddBtnIndex => _strongGuideAddBtnIndex;

	public int StrongGuideCharacterId => _strongGuideCharacterId;

	public int[] CurSelectedTeamCharacters => source switch
	{
		TeamProfileSource.World => CurSelectedTeamProfile.CharacterIds.ToArray(), 
		TeamProfileSource.Raid => CurSelectedTeamProfile.CharacterIds.ToArray(), 
		TeamProfileSource.Temple => templeCharactersId, 
		TeamProfileSource.Traininground => trainingGroudCharactersId, 
		_ => throw new ArgumentOutOfRangeException(), 
	};

	public int[] BattleTeamCharacters => source switch
	{
		TeamProfileSource.World => uiTeamProfiles[curBattleIndex].CharacterIds.ToArray(), 
		TeamProfileSource.Raid => raidTeamProfiles[curBattleIndex].CharacterIds.ToArray(), 
		TeamProfileSource.Temple => templeCharactersId, 
		TeamProfileSource.Traininground => trainingGroudCharactersId, 
		_ => throw new ArgumentOutOfRangeException(), 
	};

	public int[] RawBattleTeamCharacters => source switch
	{
		TeamProfileSource.World => rawTeamProfile[rawBattleIndex].CharacterIds.ToArray(), 
		TeamProfileSource.Raid => rawRaidTeamProfiles[rawBattleIndex].CharacterIds.ToArray(), 
		TeamProfileSource.Temple => rawTempleCharactersId, 
		TeamProfileSource.Traininground => rawTrainingGroudCharactersId, 
		_ => throw new ArgumentOutOfRangeException(), 
	};

	public PresetTeam CurSelectedTeamProfile => source switch
	{
		TeamProfileSource.Temple => templeGroundProfiles, 
		TeamProfileSource.World => uiTeamProfiles[curSelectedIndex], 
		TeamProfileSource.Raid => raidTeamProfiles[curSelectedIndex], 
		TeamProfileSource.Traininground => traingingGroundProfiles, 
		_ => throw new ArgumentOutOfRangeException(), 
	};

	public PresetTeam CurBattleTeamProfile => source switch
	{
		TeamProfileSource.Temple => templeGroundProfiles, 
		TeamProfileSource.World => uiTeamProfiles[curBattleIndex], 
		TeamProfileSource.Raid => raidTeamProfiles[curBattleIndex], 
		TeamProfileSource.Traininground => traingingGroundProfiles, 
		_ => throw new ArgumentOutOfRangeException(), 
	};

	private PresetTeam _serverBattleTeamProfile => G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx];

	public bool NeedLoad
	{
		get
		{
			if (rawBattleIndex == curBattleIndex)
			{
				return !Enumerable.SequenceEqual(RawBattleTeamCharacters, BattleTeamCharacters);
			}
			return true;
		}
	}

	public bool BattleBottleIsChange
	{
		get
		{
			if (rawBattleIndex == curBattleIndex)
			{
				return _serverBattleTeamProfile.EquipPotionId != CurSelectedTeamProfile.EquipPotionId;
			}
			return true;
		}
	}

	public UniTaskCompletionSource EntityLoadCompletion { get; set; }

	public long TeamInBattleStamp { get; set; }

	public long SwitchRoleBattleStamp { get; set; }

	public LuminModelType JumpSourceType => LuminModelType.Team;

	public event Action OnQuickSelectPopClosed
	{
		add
		{
			_onQuickSelectPopClosed = (Action)Delegate.Combine(_onQuickSelectPopClosed, value);
		}
		remove
		{
			_onQuickSelectPopClosed = (Action)Delegate.Remove(_onQuickSelectPopClosed, value);
		}
	}

	public void InvokeQuickSelectPopClosed()
	{
		_onQuickSelectPopClosed?.Invoke();
	}

	protected override void Init()
	{
		uiTeamProfiles = ListPool<PresetTeam>.Get();
		rawTeamProfile = ListPool<PresetTeam>.Get();
		rawRaidTeamProfiles = ListPool<PresetTeam>.Get();
		raidTeamProfiles = ListPool<PresetTeam>.Get();
		_strongGuideAddBtnIndex = -1;
		_strongGuideCharacterId = 0;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeBattleCharacterChange, OnSwitchRole);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Team_ServerInfoChange, OnServerTeamInfoChangeEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Team_BattleIndexChange, OnBattleTeamIndexChangeEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Team_ChangeAllTeamProfile, OnChangeAllTeamProfileEvent);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Team_SnapshotTeamChange, OnSnapshotTeamChangeEvent);
		MonoECS.instance.playerStateChange += new Action<PlayState, PlayState>(OnPlayerStateChange);
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeBattleCharacterChange, OnSwitchRole);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Team_ServerInfoChange, OnServerTeamInfoChangeEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Team_BattleIndexChange, OnBattleTeamIndexChangeEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Team_ChangeAllTeamProfile, OnChangeAllTeamProfileEvent);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Team_SnapshotTeamChange, OnSnapshotTeamChangeEvent);
		if (MonoECS.instance != null)
		{
			MonoECS.instance.playerStateChange -= new Action<PlayState, PlayState>(OnPlayerStateChange);
		}
		ListPool<PresetTeam>.Release(uiTeamProfiles);
		ListPool<PresetTeam>.Release(rawTeamProfile);
		ListPool<PresetTeam>.Release(rawRaidTeamProfiles);
		ListPool<PresetTeam>.Release(raidTeamProfiles);
		_strongGuideAddBtnIndex = -1;
		_strongGuideCharacterId = 0;
	}

	public void InitRawTeamProfileData(int choseIndex)
	{
		rawTeamProfile.Clear();
		rawTeamProfile.AddRange(G.localPlayer.teamInfo.PresetTeams.Clone());
		curBattleIndex = (rawBattleIndex = G.localPlayer.teamInfo.MainTeamIdx);
		curSelectedIndex = choseIndex;
		if (_strongGuideAddBtnIndex == -1)
		{
			curSeatIndex = 0;
		}
	}

	public void InitSeverTeamProfileData()
	{
		source = TeamProfileSource.World;
		uiTeamProfiles.Clear();
		uiTeamProfiles.AddRange(G.localPlayer.teamInfo.PresetTeams.Clone());
	}

	public void InitTempleTeamProfileData(int[] charactersId, int id, int potionId)
	{
		source = TeamProfileSource.Temple;
		templeCharactersId = DeepCopyArray(charactersId);
		rawTempleCharactersId = DeepCopyArray(charactersId);
		templeGroundProfiles = new PresetTeam
		{
			CharacterIds = { (IEnumerable<int>)templeCharactersId },
			EquipPotionId = potionId
		};
		templeId = id;
	}

	public void InitRaidTeamProfileData(int[] charactersId)
	{
		source = TeamProfileSource.Raid;
		rawRaidTeamProfiles.Clear();
		rawRaidTeamProfiles.AddRange(G.localPlayer.teamInfo.PresetTeams.Clone());
		raidTeamProfiles.Clear();
		raidTeamProfiles.AddRange(G.localPlayer.teamInfo.PresetTeams.Clone());
	}

	public void InitTrainingGroundTeamProfileData(int[] charactersId)
	{
		source = TeamProfileSource.Traininground;
		trainingGroudCharactersId = DeepCopyArray(charactersId);
		rawTrainingGroudCharactersId = DeepCopyArray(charactersId);
		traingingGroundProfiles = new PresetTeam
		{
			CharacterIds = { (IEnumerable<int>)trainingGroudCharactersId },
			EquipPotionId = TeamInfoExtension.GetTeamInfo().EquipPotionId
		};
	}

	public void UpdateCurSelectedIndex(int index)
	{
		curSelectedIndex = index;
	}

	public void UpdateCurBattleIndex(int index)
	{
		curBattleIndex = index;
	}

	public void OnLeft()
	{
		lastSelectedIndex = curSelectedIndex;
		curSelectedIndex--;
		if (curSelectedIndex == -1)
		{
			switch (source)
			{
			case TeamProfileSource.World:
				curSelectedIndex = uiTeamProfiles.Count - 1;
				break;
			case TeamProfileSource.Raid:
				curSelectedIndex = raidTeamProfiles.Count - 1;
				break;
			}
		}
	}

	public void OnRight()
	{
		lastSelectedIndex = curSelectedIndex;
		curSelectedIndex++;
		if (source == TeamProfileSource.World && curSelectedIndex == uiTeamProfiles.Count)
		{
			curSelectedIndex = 0;
		}
		else if (source == TeamProfileSource.Raid && curSelectedIndex == raidTeamProfiles.Count)
		{
			curSelectedIndex = 0;
		}
	}

	public bool CompareTeamProfile()
	{
		for (int i = 0; i < rawTeamProfile.Count; i++)
		{
			if (!rawTeamProfile[i].Name.Equals(uiTeamProfiles[i].Name))
			{
				return true;
			}
			if (!rawTeamProfile[i].CharacterIds.Equals(uiTeamProfiles[i].CharacterIds))
			{
				return true;
			}
			if (rawTeamProfile[i].EquipPotionId != uiTeamProfiles[i].EquipPotionId)
			{
				return true;
			}
		}
		return false;
	}

	public void RearrangeCharactersArray(ref int[] characters)
	{
		int num = 0;
		for (int i = 0; i < characters.Length; i++)
		{
			if (characters[i] != 0)
			{
				num++;
			}
		}
		if (num == 0 || num == characters.Length)
		{
			return;
		}
		int[] array = new int[characters.Length];
		int num2 = 0;
		for (int j = 0; j < characters.Length; j++)
		{
			if (characters[j] != 0)
			{
				array[num2++] = characters[j];
			}
		}
		while (num2 < characters.Length)
		{
			array[num2++] = 0;
		}
		for (int k = 0; k < characters.Length; k++)
		{
			characters[k] = array[k];
		}
	}

	internal bool CanBattle(int[] ids)
	{
		for (int i = 0; i < ids.Length; i++)
		{
			if (ids[i] != 0 && GetTeamRuntimeCharacter(ids[i]).IsRuntimeAlive())
			{
				return true;
			}
		}
		return false;
	}

	public int[] DeepCopyListToArray(List<int> source)
	{
		if (source == null)
		{
			return null;
		}
		int[] array = new int[source.Count];
		for (int i = 0; i < source.Count; i++)
		{
			array[i] = source[i];
		}
		return array;
	}

	public int[] DeepCopyArray(int[] source)
	{
		if (source == null)
		{
			return null;
		}
		int[] array = new int[source.Length];
		Array.Copy(source, array, source.Length);
		return array;
	}

	public void ServerTeamInfoChange(PresetTeam teamProfile, int index, ProfileChangeType changeType, TeamProfileSource evtSource, Action<bool> finishAction)
	{
		bool isBattleTeam = curBattleIndex == index;
		UpdateBattleCharacterIndex(teamProfile, isBattleTeam);
		G.service.TeamCharacterChange(teamProfile, index, (bool r) =>
		{
			if (r)
			{
				int[] beforeCharacterIds = (isBattleTeam ? G.localPlayer.teamInfo.PresetTeams[rawBattleIndex].CharacterIds.ToArray() : null);
				switch (changeType)
				{
				case ProfileChangeType.Characters:
					if (evtSource != TeamProfileSource.Temple)
					{
						ApplyTeamProfile(index, teamProfile, isBattleTeam);
					}
					if (isBattleTeam && evtSource != TeamProfileSource.Temple)
					{
						MPPlayer.local.ReplaceNormalRuntimeBattleTeam(beforeCharacterIds, teamProfile.CharacterIds.ToArray()).Forget(Debug.LogException);
					}
					break;
				case ProfileChangeType.Name:
				case ProfileChangeType.Index:
					if (evtSource != TeamProfileSource.Temple)
					{
						ApplyTeamProfile(index, teamProfile, isBattleTeam);
					}
					break;
				}
			}
			finishAction?.Invoke(r);
		});
	}

	public void BattleTeamIndexChange(int battleIndex)
	{
		G.service.BattleTeamChange(battleIndex, () =>
		{
			MPPlayer.local.RefreshNormalRuntimeBattleTeamPotion();
		});
	}

	public void ChangeAllTeamProfile(List<PresetTeam> teamProfiles, int battleTeamIndex)
	{
		bool needEntityChange = source == TeamProfileSource.World && (NeedLoad || BattleBottleIsChange);
		int[] beforeChars = (needEntityChange ? RawBattleTeamCharacters : null);
		int[] afterChars = (needEntityChange ? BattleTeamCharacters : null);
		List<PresetTeam> profiles = ListPool<PresetTeam>.Get();
		profiles.AddRange(teamProfiles);
		UpdateBattleCharacterIndex(profiles[battleTeamIndex], isBattleTeam: true);
		G.service.SaveTeamProfile(profiles, battleTeamIndex, (bool r) =>
		{
			if (r)
			{
				for (int i = 0; i < profiles.Count; i++)
				{
					ApplyTeamProfile(i, profiles[i], i == battleTeamIndex);
				}
				if (needEntityChange)
				{
					MPPlayer.local.ReplaceNormalRuntimeBattleTeam(beforeChars, afterChars).Forget(Debug.LogException);
				}
				else
				{
					EntityLoadCompletion?.TrySetResult();
				}
			}
			else
			{
				EntityLoadCompletion?.TrySetResult();
			}
			ListPool<PresetTeam>.Release(profiles);
		});
	}

	public void SnapshotTeamChange(int[] before, int[] after)
	{
		int battleCharacterIndexByHp = GetBattleCharacterIndexByHp(after);
		MPPlayer.local.ReplaceNormalRuntimeBattleTeam(before, after, loadSave: false, battleCharacterIndexByHp).Forget(Debug.LogException);
	}

	private void OnServerTeamInfoChangeEvent(BaseEventContent obj)
	{
		ServerTeamCharacterChange serverTeamCharacterChange = (ServerTeamCharacterChange)obj;
		ServerTeamInfoChange(serverTeamCharacterChange.teamProfile, serverTeamCharacterChange.index, serverTeamCharacterChange.changeType, serverTeamCharacterChange.source, serverTeamCharacterChange.finishAction);
	}

	private void OnBattleTeamIndexChangeEvent(BaseEventContent obj)
	{
		BattleTeamIndexChange battleTeamIndexChange = (BattleTeamIndexChange)obj;
		BattleTeamIndexChange(battleTeamIndexChange.index);
	}

	private void OnChangeAllTeamProfileEvent(BaseEventContent obj)
	{
		ChangeAllTeamProfile changeAllTeamProfile = (ChangeAllTeamProfile)obj;
		ChangeAllTeamProfile(changeAllTeamProfile.teamProfiles, changeAllTeamProfile.battleTeamIndex);
	}

	private void OnSnapshotTeamChangeEvent(BaseEventContent obj)
	{
		SnapshotTeamCharacterChange snapshotTeamCharacterChange = (SnapshotTeamCharacterChange)obj;
		SnapshotTeamChange(snapshotTeamCharacterChange.beforeCharactersId.ToArray(), snapshotTeamCharacterChange.afterCharactersId.ToArray());
	}

	private void OnPlayerStateChange(PlayState from, PlayState to)
	{
		if (from == PlayState.UnBattle && to == PlayState.Battle)
		{
			TeamInBattleStamp = TimeManager.LocalTime.NowTimestamp;
			SwitchRoleBattleStamp = TimeManager.LocalTime.NowTimestamp;
		}
		else if (to == PlayState.UnBattle && from == PlayState.Battle)
		{
			TeamInBattleStamp = 0L;
			SwitchRoleBattleStamp = 0L;
		}
	}

	private void OnSwitchRole(BaseEventContent obj)
	{
		SwitchRoleBattleStamp = TimeManager.LocalTime.NowTimestamp;
	}

	private void ApplyTeamProfile(int index, PresetTeam teamProfile, bool isBattleTeam)
	{
		PresetTeam presetTeam = G.localPlayer.teamInfo.PresetTeams[index];
		presetTeam.CharacterIds.CopyValueFrom(teamProfile.CharacterIds);
		presetTeam.EquipPotionId = teamProfile.EquipPotionId;
		presetTeam.Name = teamProfile.Name;
		presetTeam.BattleCharacterIdx = teamProfile.BattleCharacterIdx;
		ProfileChangeSuccess evt = Singleton<EventManager>.instance.GetEvt<ProfileChangeSuccess>();
		evt.teamProfile = teamProfile;
		evt.isBattleTeam = isBattleTeam;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Team_ProfileChangeSuccessed, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void UpdateBattleCharacterIndex(PresetTeam teamProfile, bool isBattleTeam)
	{
		if (isBattleTeam)
		{
			teamProfile.BattleCharacterIdx = GetBattleCharacterIndexByHp(teamProfile.CharacterIds);
		}
	}

	private int GetBattleCharacterIndexByHp(IReadOnlyList<int> ids)
	{
		int num = MPPlayer.local?.battleEntityIndex ?? (-1);
		if (IsAliveCharacter(ids, num))
		{
			return num;
		}
		if (ids != null)
		{
			for (int i = 0; i < ids.Count; i++)
			{
				if (IsAliveCharacter(ids, i))
				{
					return i;
				}
			}
		}
		return 0;
	}

	private static Character GetTeamRuntimeCharacter(int characterId)
	{
		if (characterId == 0)
		{
			return null;
		}
		return G.localPlayer.GetCharacter(characterId) ?? G.localPlayer.GetBagCharacter(characterId);
	}

	private bool IsAliveCharacter(IReadOnlyList<int> ids, int index)
	{
		if (ids == null || index < 0 || index >= ids.Count || ids[index] == 0)
		{
			return false;
		}
		return GetTeamRuntimeCharacter(ids[index]).IsRuntimeAlive();
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Team))
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.CanJump
			};
		}
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.Forbidden,
			Message = Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.Team)
		};
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEAM, new TeamViewData
		{
			choseTeamIndex = jumpData.Params[1]
		});
	}

	public void SetGuideDefaultSelectAddCharacterBtn(int index)
	{
		_strongGuideAddBtnIndex = index;
		curSeatIndex = index;
	}

	public void ResetGuideDefaultSelectAddCharacterBtn()
	{
		_strongGuideAddBtnIndex = -1;
		curSeatIndex = 0;
	}

	public void SetGuideDefaultSelectCharacter(int characterId)
	{
		_strongGuideCharacterId = characterId;
	}

	public void ResetGuideDefaultSelectCharacter()
	{
		_strongGuideCharacterId = 0;
	}

	public bool IsLowLevel(PresetTeam presetTeam, int recommandLevel)
	{
		if (recommandLevel <= 0)
		{
			return false;
		}
		int num = 0;
		Character[] teamCharacters = presetTeam.GetTeamCharacters();
		for (int i = 0; i < teamCharacters.Length; i++)
		{
			if (teamCharacters[i] != null)
			{
				num += teamCharacters[i].Level;
			}
		}
		return Mathf.Max(0, num / BattleConsts.TEAMCAPITAL) < recommandLevel - 5;
	}

	public bool IsLowLevel(TeamUsage teamUsage, int recommandLevel)
	{
		if (recommandLevel <= 0)
		{
			return false;
		}
		int num = 0;
		foreach (TeamCharacterUsage item in teamUsage.CharacterUsage)
		{
			if (item != null && item.CharacterId > 0)
			{
				Character curCharacterByCharacterId = CharacterDataHelper.GetCurCharacterByCharacterId(item.CharacterId);
				if (curCharacterByCharacterId != null)
				{
					num += curCharacterByCharacterId.Level;
				}
			}
		}
		return Mathf.Max(0, num / BattleConsts.TEAMCAPITAL) < recommandLevel - 5;
	}
}
