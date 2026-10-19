using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.Utility;
using UnityEngine;

namespace ACT.MultiPlayer;

public class MPPlayer : IDisposable
{
	public static MPPlayer local;

	private const int TEAM_MEMBER_COUNT = 3;

	private Entity _battleEntity;

	private readonly RuntimeBattleTeam _currentRuntimeBattleTeam = new RuntimeBattleTeam();

	private int normalBattleEntityIndex;

	private bool hasNormalRuntimeBattleTeam;

	private int _runtimeBattleTeamReplaceDepth;

	public long battleStartTimeStamp;

	public Entity battleEntity
	{
		get
		{
			return _battleEntity;
		}
		protected set
		{
			_battleEntity = value;
		}
	}

	public PresetTeam NormalBattleTeamData => G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx];

	public PresetTeam CurrentBattleTeam => NormalBattleTeamData;

	public RuntimeBattleTeam CurrentRuntimeBattleTeam => _currentRuntimeBattleTeam;

	public bool IsTrialRuntimeBattleTeam => _currentRuntimeBattleTeam.Source == RuntimeBattleTeamSource.MainTrial;

	public int CurrentActiveBattlePotionId => _currentRuntimeBattleTeam.EquipPotionId;

	private EntityId[] ActiveTeamEntityRefs => _currentRuntimeBattleTeam.EntityRefs;

	private EntityId[] ActiveSwitchEntityRefs => _currentRuntimeBattleTeam.SwitchEntityRefs;

	public int battleEntityIndex
	{
		get
		{
			return _currentRuntimeBattleTeam.BattleEntityIndex;
		}
		set
		{
			_currentRuntimeBattleTeam.BattleEntityIndex = value;
			if (_currentRuntimeBattleTeam.Source == RuntimeBattleTeamSource.MainNormal)
			{
				normalBattleEntityIndex = value;
			}
		}
	}

	public int NormalBattleEntityIndex => normalBattleEntityIndex;

	public bool HasNormalRuntimeBattleTeam => hasNormalRuntimeBattleTeam;

	public bool IsReplacingRuntimeBattleTeam => _runtimeBattleTeamReplaceDepth > 0;

	public Entity TeamBattleEntity
	{
		get
		{
			EntityId[] activeTeamEntityRefs = ActiveTeamEntityRefs;
			int num = battleEntityIndex;
			if (num < 0 || num >= activeTeamEntityRefs.Length)
			{
				return default;
			}
			return GameManager.entities.GetEntity(activeTeamEntityRefs[num]);
		}
	}

	public Entity robotEntity { get; protected set; }

	private RuntimeBattleTeamSource GetRuntimeBattleTeamSource(bool isTrialTeam)
	{
		if (MonoECS.instance == null || MonoECS.instance.sceneStatus != SceneStatus.Main)
		{
			return RuntimeBattleTeamSource.OtherScene;
		}
		if (!isTrialTeam)
		{
			return RuntimeBattleTeamSource.MainNormal;
		}
		return RuntimeBattleTeamSource.MainTrial;
	}

	public int GetNormalRuntimeBattleIndex(int configuredBattleIndex)
	{
		if (!hasNormalRuntimeBattleTeam)
		{
			return configuredBattleIndex;
		}
		return normalBattleEntityIndex;
	}

	public MPPlayer()
	{
		local = this;
	}

	public void Dispose()
	{
		local = null;
	}

	public void SetProtagonistEntity(Entity protagonistEntity)
	{
		battleEntity = protagonistEntity;
	}

	public void RestoreFromProtagonist()
	{
		battleEntity = TeamBattleEntity;
	}

	public void SetCharacterVisible(Entity entity, bool visible, float dissolveDuration = 0.5f)
	{
		if (!entity.IsValid || MonoECS.instance == null)
		{
			return;
		}
		MonoEntity mono = entity.GetMono();
		if ((bool)mono)
		{
			mono.ControlShadowCollider(visible);
			mono.GetComponent<MonoDestinyEffect>()?.SetVisible(visible);
			Renderer[] renderers = mono.renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].gameObject.SetActive(visible);
			}
		}
		SystemAbility systemAbility = Singleton<GameManager>.instance.ecsManager.systemAbility;
		EvtCharacterVisible evt = systemAbility.GetEvt<EvtCharacterVisible>(entity, null);
		evt.mainEntity = entity;
		evt.visible = visible;
		systemAbility.FireEvt(evt);
		systemAbility.ReleaseEvt(evt);
		entity.GetCompEffect()?.SetAllEffectsVisible(visible);
	}

	public int GetSwitchIndex(Entity entity)
	{
		EntityId id = entity.Id;
		EntityId[] activeSwitchEntityRefs = ActiveSwitchEntityRefs;
		for (int i = 0; i < activeSwitchEntityRefs.Length; i++)
		{
			if (activeSwitchEntityRefs[i] == id)
			{
				return i;
			}
		}
		return -1;
	}

	public Entity GetSwitchCharacter(int index)
	{
		return GameManager.entities.GetEntity(ActiveSwitchEntityRefs[index]);
	}

	public void SwitchCharacter(int index)
	{
		EntityId[] activeTeamEntityRefs = ActiveTeamEntityRefs;
		if (index >= 0 && index < activeTeamEntityRefs.Length)
		{
			battleEntity = GameManager.entities.GetEntity(activeTeamEntityRefs[index]);
			battleEntityIndex = index;
			ChangeSwitch();
		}
	}

	private void ChangeSwitch()
	{
		ChangeSwitch(ActiveTeamEntityRefs, ActiveSwitchEntityRefs);
	}

	private void ChangeSwitch(EntityId[] teamRefs, EntityId[] switchRefs)
	{
		EntityId entityId = (battleEntity.IsValid ? battleEntity.Id : EntityId.Invalid);
		for (int i = 0; i < switchRefs.Length; i++)
		{
			switchRefs[i] = EntityId.Invalid;
		}
		int num = 0;
		for (int j = 0; j < teamRefs.Length; j++)
		{
			if (teamRefs[j] != entityId && num < switchRefs.Length)
			{
				switchRefs[num++] = teamRefs[j];
			}
		}
	}

	public EntityId GetTeamUid(int index)
	{
		return ActiveTeamEntityRefs[index];
	}

	public void SetTeamCharacters(EntityId[] characterEntityIds, int battleIndex = -1, IReadOnlyList<Character> characters = null, int potionId = -1)
	{
		if (!IsTrialRuntimeBattleTeam)
		{
			if (characters == null)
			{
				SetNormalTeamCharactersAndActivate(characterEntityIds, battleIndex);
			}
			else
			{
				ApplyRuntimeBattleTeam(characters, characterEntityIds, ResolveNonTrialRuntimePotionId(potionId), battleIndex, isTrialTeam: false);
			}
		}
	}

	private int ResolveNonTrialRuntimePotionId(int potionId)
	{
		if (potionId >= 0)
		{
			return potionId;
		}
		if (GetRuntimeBattleTeamSource(isTrialTeam: false) == RuntimeBattleTeamSource.MainNormal)
		{
			return NormalBattleTeamData.EquipPotionId;
		}
		if (_currentRuntimeBattleTeam.EquipPotionId == 0)
		{
			return NormalBattleTeamData.EquipPotionId;
		}
		return _currentRuntimeBattleTeam.EquipPotionId;
	}

	public void SetTrialTeamCharacters(EntityId[] characterEntityIds, IReadOnlyList<Character> trialCharacters, int trialPotionId, int battleIndex = -1)
	{
		ApplyRuntimeBattleTeam(trialCharacters, characterEntityIds, trialPotionId, battleIndex, isTrialTeam: true);
	}

	public void SetNormalTeamCharactersAndActivate(EntityId[] characterEntityIds, int battleIndex = -1)
	{
		PresetTeam normalBattleTeamData = NormalBattleTeamData;
		ApplyRuntimeBattleTeam(normalBattleTeamData.GetTeamCharacters(), characterEntityIds, normalBattleTeamData.EquipPotionId, battleIndex, isTrialTeam: false);
	}

	public async UniTask ReplaceNormalRuntimeBattleTeam(int[] beforeCharacterIds, int[] afterCharacterIds, bool loadSave = false, int battleCharacterIdx = -1)
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		Character[] array = new Character[3];
		Character[] array2 = new Character[3];
		for (int i = 0; i < 3; i++)
		{
			int num = ((beforeCharacterIds != null && i < beforeCharacterIds.Length) ? beforeCharacterIds[i] : 0);
			int num2 = ((afterCharacterIds != null && i < afterCharacterIds.Length) ? afterCharacterIds[i] : 0);
			array[i] = ((num == 0) ? null : (worldManager.GetCharacter(num) ?? CharacterDataHelper.GetCurCharacterByCharacterId(num)));
			array2[i] = ((num2 == 0) ? null : CharacterDataHelper.GetOrCloneCurrentWorldCharacter(num2));
		}
		await ReplaceNormalRuntimeBattleTeam(array, array2, afterCharacterIds, loadSave, battleCharacterIdx);
	}

	public async UniTask ReplaceNormalRuntimeBattleTeam(IReadOnlyList<Character> beforeCharacters, IReadOnlyList<Character> afterCharacters, IReadOnlyList<int> afterCharacterIds, bool loadSave = false, int battleCharacterIdx = -1)
	{
		if (IsTrialRuntimeBattleTeam)
		{
			NotifyRuntimeBattleTeamLoaded();
			return;
		}
		PresetTeam normalBattleTeamData = NormalBattleTeamData;
		int preferredBattleIndex = ((battleCharacterIdx >= 0) ? battleCharacterIdx : normalBattleTeamData.BattleCharacterIdx);
		await ReplaceRuntimeBattleTeamCharacters(isTrialTeam: false, beforeCharacters, afterCharacters, afterCharacterIds, normalBattleTeamData.EquipPotionId, preferredBattleIndex, resetNormalWorldData: true, loadSave);
	}

	public async UniTask ReplaceTrialRuntimeBattleTeam(IReadOnlyList<Character> beforeCharacters, IReadOnlyList<Character> afterCharacters, int trialPotionId, int battleIndex)
	{
		await ReplaceRuntimeBattleTeamCharacters(isTrialTeam: true, beforeCharacters, afterCharacters, GetCharacterIds(afterCharacters), trialPotionId, battleIndex, resetNormalWorldData: false, loadSave: false);
	}

	public async UniTask RestoreNormalRuntimeBattleTeam(IReadOnlyList<Character> beforeCharacters, IReadOnlyList<Character> afterCharacters, int battleIndex)
	{
		await ReplaceRuntimeBattleTeamCharacters(isTrialTeam: false, beforeCharacters, afterCharacters, GetCharacterIds(afterCharacters), NormalBattleTeamData.EquipPotionId, battleIndex, resetNormalWorldData: true, loadSave: false);
	}

	public void RefreshNormalRuntimeBattleTeamPotion()
	{
		if (!IsTrialRuntimeBattleTeam)
		{
			_currentRuntimeBattleTeam.SetPotionId(NormalBattleTeamData.EquipPotionId);
			Singleton<GameManager>.instance.worldManager.ResetTeamPotion(_currentRuntimeBattleTeam.EquipPotionId);
		}
	}

	private void RefreshTrialRuntimeBattleTeamPotion()
	{
		if (!IsTrialRuntimeBattleTeam)
		{
			return;
		}
		ClearRuntimeBattleTeamPotion();
		int equipPotionId = _currentRuntimeBattleTeam.EquipPotionId;
		if (equipPotionId != 0)
		{
			if (!Model<BloodBottleModel>.Interface.TryCreateLocalBloodBottle(equipPotionId, out var _))
			{
				Debug.LogError($"创建试用血瓶失败：未找到试用血瓶配置 {equipPotionId}。");
			}
			else
			{
				Model<BloodBottleModel>.Interface.ChangeWorldLocalPotion(equipPotionId);
			}
		}
	}

	private void ClearRuntimeBattleTeamPotion()
	{
		BloodBottleModel bloodBottleModel = Model<BloodBottleModel>.Interface;
		if (bloodBottleModel.isCurSceneEquipLocalBloodBottle)
		{
			bloodBottleModel.ClearLocalBloodBottles();
			return;
		}
		Entity entity = battleEntity;
		if (Singleton<BloodBottleBuffHandler>.HasInstance() && entity.IsValid)
		{
			Singleton<BloodBottleBuffHandler>.instance.RemoveAllBuffsFromEntity(entity);
		}
		bloodBottleModel.ChangeWorldPotion(MonoECS.instance.sceneStatus, 0);
		if (Singleton<BloodBottleBuffHandler>.HasInstance())
		{
			Singleton<BloodBottleBuffHandler>.instance.UpdateBuffData(0);
		}
		if (Singleton<BloodBottleHandler>.HasInstance())
		{
			Singleton<BloodBottleHandler>.instance.SendBottleChangeUpdateHudComponent(0);
		}
	}

	public void RefreshActiveTeamAbilities()
	{
		Singleton<GameManager>.instance.ecsManager.systemAbility.RemoveEnvironmentElementAbilityToAllTeamCharacter(Singleton<GameManager>.instance.worldManager.EnvironmentModule.EnvironmentElementData);
		Singleton<GameManager>.instance.ecsManager.systemAbility.AddEnvironmentElementAbilityToAllTeamCharacter(Singleton<GameManager>.instance.worldManager.EnvironmentModule.EnvironmentElementData);
	}

	public void NotifyBattleCharacterChanged()
	{
		RuntimeBattleTeamMainCharacterChanged evt = Singleton<EventManager>.instance.GetEvt<RuntimeBattleTeamMainCharacterChanged>();
		evt.ecsId = (battleEntity.IsValid ? battleEntity.Id : EntityId.Invalid);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RuntimeBattleTeam_MainCharacterChanged, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void ResetRuntimeBattleTeamForSession()
	{
		_currentRuntimeBattleTeam.Reset(RuntimeBattleTeamSource.MainNormal, null, null, 0, 0);
		normalBattleEntityIndex = 0;
		hasNormalRuntimeBattleTeam = false;
		battleEntity = default;
	}

	private void ApplyRuntimeBattleTeam(IReadOnlyList<Character> characters, EntityId[] entityRefs, int potionId, int preferredBattleIndex, bool isTrialTeam)
	{
		RuntimeBattleTeamSource runtimeBattleTeamSource = GetRuntimeBattleTeamSource(isTrialTeam);
		bool flag = runtimeBattleTeamSource == RuntimeBattleTeamSource.MainNormal;
		int currentIndex = (flag ? normalBattleEntityIndex : _currentRuntimeBattleTeam.BattleEntityIndex);
		int num = SelectBattleEntityIndex(entityRefs, preferredBattleIndex, currentIndex);
		_currentRuntimeBattleTeam.Reset(runtimeBattleTeamSource, characters, entityRefs, potionId, num);
		if (flag)
		{
			normalBattleEntityIndex = num;
			hasNormalRuntimeBattleTeam = true;
		}
		ApplyActiveTeamCharacters();
	}

	private void ApplyActiveTeamCharacters()
	{
		Singleton<GameManager>.instance.ecsManager.systemAbility.RemoveEnvironmentElementAbilityToAllTeamCharacter(Singleton<GameManager>.instance.worldManager.EnvironmentModule.EnvironmentElementData);
		battleEntity = TeamBattleEntity;
		ChangeSwitch();
		NotifyBattleCharacterChanged();
		Singleton<GameManager>.instance.ecsManager.systemAbility.AddEnvironmentElementAbilityToAllTeamCharacter(Singleton<GameManager>.instance.worldManager.EnvironmentModule.EnvironmentElementData);
	}

	private async UniTask ReplaceRuntimeBattleTeamCharacters(bool isTrialTeam, IReadOnlyList<Character> beforeCharacters, IReadOnlyList<Character> afterCharacters, IReadOnlyList<int> afterCharacterIds, int potionId, int preferredBattleIndex, bool resetNormalWorldData, bool loadSave)
	{
		_runtimeBattleTeamReplaceDepth++;
		try
		{
			await ReplaceRuntimeBattleTeamCharactersInternal(isTrialTeam, beforeCharacters, afterCharacters, afterCharacterIds, potionId, preferredBattleIndex, resetNormalWorldData, loadSave);
		}
		finally
		{
			if (_runtimeBattleTeamReplaceDepth > 0)
			{
				_runtimeBattleTeamReplaceDepth--;
			}
		}
	}

	private async UniTask ReplaceRuntimeBattleTeamCharactersInternal(bool isTrialTeam, IReadOnlyList<Character> beforeCharacters, IReadOnlyList<Character> afterCharacters, IReadOnlyList<int> afterCharacterIds, int potionId, int preferredBattleIndex, bool resetNormalWorldData, bool loadSave)
	{
		if (!isTrialTeam && IsTrialRuntimeBattleTeam)
		{
			ClearRuntimeBattleTeamPotion();
		}
		Entity mainEntity = MonoECS.instance.mainEntity;
		bool isLeft = mainEntity.IsValid && mainEntity.IsFaceLeft();
		float degree = (mainEntity.IsValid ? mainEntity.GetCompTransform().physicsRotateDegree : 0f);
		Vector3 position = (mainEntity.IsValid ? mainEntity.GetRootTransform().position : Vector3.zero);
		float z = (mainEntity.IsValid ? mainEntity.GetCompPhysics().GetConstZ : 0f);
		if (resetNormalWorldData)
		{
			Singleton<GameManager>.instance.worldManager.ResetTeamCharacters(new List<int>(afterCharacterIds), preferredBattleIndex);
		}
		for (int i = 0; i < 3; i++)
		{
			Character characterAt = GetCharacterAt(beforeCharacters, i);
			bool flag = isTrialTeam || !ContainsCharacter(afterCharacters, characterAt);
			if ((characterAt != null) & flag)
			{
				await Singleton<GameManager>.instance.worldManager.RemoveTeamCharacter(characterAt);
			}
		}
		for (int i = 0; i < 3; i++)
		{
			Character characterAt2 = GetCharacterAt(afterCharacters, i);
			if (characterAt2 != null && !ContainsCharacter(beforeCharacters, characterAt2))
			{
				if (!isTrialTeam)
				{
					characterAt2.Status.ExPower = 0f;
					characterAt2.Status.EnergyPower = 0f;
					characterAt2.Status.SpecialEnergyPower = 0f;
					characterAt2.Status.AssistPower = 0f;
				}
				await Singleton<GameManager>.instance.worldManager.SpawnTeamCharacter(characterAt2, i, preferredBattleIndex, isLeft, position, loadSave);
			}
		}
		EntityId[] characterEntityIds = GetCharacterEntityIds(afterCharacters);
		if (isTrialTeam)
		{
			SetTrialTeamCharacters(characterEntityIds, afterCharacters, potionId, preferredBattleIndex);
			RefreshTrialRuntimeBattleTeamPotion();
		}
		else
		{
			ApplyRuntimeBattleTeam(afterCharacters, characterEntityIds, potionId, preferredBattleIndex, isTrialTeam: false);
			RefreshNormalRuntimeBattleTeamPotion();
		}
		if (robotEntity.IsValid)
		{
			robotEntity.GetCompProduct().caster = MonoECS.instance.mainEntity;
		}
		for (int j = 0; j < 3; j++)
		{
			if (GetCharacterAt(afterCharacters, j) == null)
			{
				continue;
			}
			Entity entity = GameManager.entities.GetEntity(characterEntityIds[j]);
			if (!entity.IsValid)
			{
				continue;
			}
			if (isTrialTeam)
			{
				if (battleEntityIndex == j)
				{
					GameManager.cameraSystem.ShowCharacterVCam(show: true, entity.Id, entity);
					MonoECS.instance.ShowCharacter(entity, show: true, isLeft, degree, position, z);
				}
				else
				{
					GameManager.cameraSystem.ShowCharacterVCam(show: false, entity.Id);
					MonoECS.instance.ShowCharacter(entity, show: false, isLeft, degree, position, z);
				}
			}
			else
			{
				if (!entity.IsAlive())
				{
					continue;
				}
				if (battleEntityIndex != j && entity.IsActive())
				{
					GameManager.cameraSystem.ShowCharacterVCam(show: false, entity.Id);
					MonoECS.instance.ShowCharacter(entity, show: false, isLeft, degree, position, z);
				}
				else if (battleEntityIndex == j)
				{
					if (!entity.IsActive())
					{
						GameManager.cameraSystem.ShowCharacterVCam(show: true, entity.Id, entity);
						MonoECS.instance.ShowCharacter(entity, show: true, isLeft, degree, position, z);
					}
					else
					{
						MonoECS.instance.ForceToIdle(entity);
					}
				}
			}
		}
		NotifyRuntimeBattleTeamLoaded();
	}

	private static List<int> GetCharacterIds(IReadOnlyList<Character> characters)
	{
		List<int> list = new List<int>(3);
		for (int i = 0; i < 3; i++)
		{
			list.Add(GetCharacterAt(characters, i)?.Id ?? 0);
		}
		return list;
	}

	private static EntityId[] GetCharacterEntityIds(IReadOnlyList<Character> characters)
	{
		EntityId[] array = new EntityId[3];
		for (int i = 0; i < array.Length; i++)
		{
			Character characterAt = GetCharacterAt(characters, i);
			array[i] = ((characterAt != null && EntityHelper.TryGetBattleEntityByCharacter(characterAt, out var entity)) ? entity.Id : EntityId.Invalid);
		}
		return array;
	}

	private static Character GetCharacterAt(IReadOnlyList<Character> characters, int index)
	{
		if (characters == null || index < 0 || index >= characters.Count)
		{
			return null;
		}
		return characters[index];
	}

	private static bool ContainsCharacter(IReadOnlyList<Character> characters, Character target)
	{
		if (characters == null || target == null)
		{
			return false;
		}
		for (int i = 0; i < characters.Count; i++)
		{
			if (characters[i] == target)
			{
				return true;
			}
		}
		return false;
	}

	private static void NotifyRuntimeBattleTeamLoaded()
	{
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.Team_LoadComplete, null);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Team_Refresh, null);
		if (Model<TeamModel>.HasInstance())
		{
			Model<TeamModel>.Interface.EntityLoadCompletion?.TrySetResult();
		}
	}

	internal int SelectAliveMemberIndex(int memberCount, int preferredIndex, int currentIndex, int fallbackIndex, Func<int, bool> isAlive)
	{
		if (IsAliveMember(memberCount, preferredIndex, isAlive))
		{
			return preferredIndex;
		}
		if (currentIndex != preferredIndex && IsAliveMember(memberCount, currentIndex, isAlive))
		{
			return currentIndex;
		}
		if (isAlive != null)
		{
			for (int i = 0; i < memberCount; i++)
			{
				if (isAlive(i))
				{
					return i;
				}
			}
		}
		return ClampMemberIndex(memberCount, fallbackIndex);
	}

	private bool IsAliveMember(int memberCount, int index, Func<int, bool> isAlive)
	{
		if (isAlive != null && index >= 0 && index < memberCount)
		{
			return isAlive(index);
		}
		return false;
	}

	private int ClampMemberIndex(int memberCount, int index)
	{
		if (memberCount <= 0 || index < 0)
		{
			return 0;
		}
		if (index < memberCount)
		{
			return index;
		}
		return memberCount - 1;
	}

	private int SelectBattleEntityIndex(EntityId[] teamRefs, int preferredIndex, int currentIndex)
	{
		return SelectAliveMemberIndex(teamRefs.Length, preferredIndex, currentIndex, 0, (int index) => IsAlive(teamRefs[index]));
	}

	private bool IsAlive(EntityId entityId)
	{
		Entity entity = GameManager.entities.GetEntity(entityId);
		if (entity.IsValid)
		{
			return entity.IsAlive();
		}
		return false;
	}

	public Entity GetTeamCharacter(int index)
	{
		return GameManager.entities.GetEntity(ActiveTeamEntityRefs[index]);
	}

	public List<int> GetTeamCharacterSkinIds()
	{
		List<int> list = new List<int>(3);
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = GetTeamCharacter(i);
			if (teamCharacter.IsValid)
			{
				list.Add(teamCharacter.GetCompCharacter().characterSource.GetCharacterSkinId());
			}
		}
		return list;
	}

	public int IndexOfTeamCharacter(Entity entity)
	{
		EntityId[] activeTeamEntityRefs = ActiveTeamEntityRefs;
		for (int i = 0; i < activeTeamEntityRefs.Length; i++)
		{
			if (activeTeamEntityRefs[i] == entity.Id)
			{
				return i;
			}
		}
		return -1;
	}

	public Entity IdOfTeamCharacter(int id)
	{
		ECSManager ecsManager = Singleton<GameManager>.instance.ecsManager;
		EntityId[] activeTeamEntityRefs = ActiveTeamEntityRefs;
		foreach (EntityId id2 in activeTeamEntityRefs)
		{
			Entity entity = ecsManager.GetEntity(id2);
			if (entity.IsValid && entity.GetCompCharacter().characterSource.Id() == id)
			{
				return entity;
			}
		}
		return default;
	}

	public bool IdIsSwitchCharacter(EntityId id)
	{
		ECSManager ecsManager = Singleton<GameManager>.instance.ecsManager;
		EntityId[] activeSwitchEntityRefs = ActiveSwitchEntityRefs;
		foreach (EntityId id2 in activeSwitchEntityRefs)
		{
			Entity entity = ecsManager.GetEntity(id2);
			if (entity.IsValid && entity.Id == id && id != battleEntity.Id)
			{
				return true;
			}
		}
		return false;
	}

	public bool IdIsTeamCharacter(EntityId id)
	{
		ECSManager ecsManager = Singleton<GameManager>.instance.ecsManager;
		EntityId[] activeTeamEntityRefs = ActiveTeamEntityRefs;
		foreach (EntityId id2 in activeTeamEntityRefs)
		{
			Entity entity = ecsManager.GetEntity(id2);
			if (entity.IsValid && entity.Id == id)
			{
				return true;
			}
		}
		return false;
	}

	public bool TryGetTeamCharacter(int characterId, out Entity entity)
	{
		entity = default;
		EntityId[] activeTeamEntityRefs = ActiveTeamEntityRefs;
		foreach (EntityId id in activeTeamEntityRefs)
		{
			Entity entity2 = GameManager.entities.GetEntity(id);
			if (entity2.IsValid && entity2.GetCompCharacter().characterSource.Id() == characterId)
			{
				entity = entity2;
				return true;
			}
		}
		return false;
	}

	public void ChangeToEnemyServerRpc()
	{
		EntityId[] activeTeamEntityRefs = ActiveTeamEntityRefs;
		foreach (EntityId entityId in activeTeamEntityRefs)
		{
			ChangeToEnemy(entityId);
		}
	}

	private void ChangeToEnemy(EntityId entityId)
	{
		Entity entity = Singleton<GameManager>.instance.ecsManager.GetEntity(entityId);
		if (entity.IsValid)
		{
			entity.SetAlliance(Alliance.Enemy);
		}
	}

	public bool GetLocalPlayerAlive()
	{
		if (IsReplacingRuntimeBattleTeam)
		{
			return true;
		}
		bool flag = false;
		for (int i = 0; i < 3; i++)
		{
			Entity teamCharacter = GetTeamCharacter(i);
			if (teamCharacter != null && teamCharacter.IsValid)
			{
				flag = true;
				if (teamCharacter.IsAlive())
				{
					return true;
				}
			}
			else if (GetCharacterAt(_currentRuntimeBattleTeam.Characters, i) != null)
			{
				return true;
			}
		}
		return !flag;
	}
}
