using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.MultiPlayer;
using ACT.VolumeControl;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Runtime.Utility;
using UnityEngine;

namespace ACT.Utility;

public static class CharacterSkinRuntimeUtility
{
	private const string SkinPathFormat = "Skin/{0}";

	public static int ResolveBagCharacterSkinId(int characterId)
	{
		if (G.localPlayer == null || !CharacterDataHelper.TryGetBagCharacterById(characterId, out var character))
		{
			return characterId;
		}
		return character.GetCharacterSkinId();
	}

	public static bool TryResolveBattleThenBagCharacterSource(int characterId, out ICharacterSource source)
	{
		source = null;
		if (characterId <= 0)
		{
			return false;
		}
		IReadOnlyList<Character> readOnlyList = MPPlayer.local?.CurrentRuntimeBattleTeam?.Characters;
		if (readOnlyList != null)
		{
			for (int i = 0; i < readOnlyList.Count; i++)
			{
				Character character = readOnlyList[i];
				if (character != null && character.Id == characterId)
				{
					source = character;
					return true;
				}
			}
		}
		if (CharacterDataHelper.TryGetBagCharacterById(characterId, out var character2) && character2 != null)
		{
			source = character2;
			return true;
		}
		return false;
	}

	public static int ResolveSkinId(int characterId, ICharacterSource source = null, int fallbackSkinId = 0)
	{
		if (source != null)
		{
			try
			{
				int characterSkinId = source.GetCharacterSkinId();
				if (characterSkinId > 0)
				{
					return characterSkinId;
				}
			}
			catch
			{
			}
		}
		if (fallbackSkinId > 0)
		{
			return fallbackSkinId;
		}
		if (G.localPlayer != null && CharacterDataHelper.TryGetBagCharacterById(characterId, out var character) && character.GetCharacterSkinId() > 0)
		{
			return character.GetCharacterSkinId();
		}
		if (G.localPlayer != null && CharacterDataHelper.TryGetCharacter(CharacterDataHelper.GetCurCharacterRepository(), characterId, out var character2) && character2.GetCharacterSkinId() > 0)
		{
			return character2.GetCharacterSkinId();
		}
		return 0;
	}

	public static bool TryGetSkin(int skinId, out Skin skin)
	{
		skin = null;
		if (skinId > 0 && RuntimeConfigs.data?.Skins != null && RuntimeConfigs.data.Skins.TryGetValue(skinId, out skin))
		{
			return skin != null;
		}
		return false;
	}

	public static string GetModelPath(int characterId, int skinId, CharacterModelUsage usage)
	{
		if (TryGetSkin(skinId, out var skin) && !string.IsNullOrEmpty(skin.model))
		{
			return $"Skin/{skin.model}";
		}
		RuntimeConfigs.data.entityCharacterDatas.TryGetValue(characterId, out var value);
		RuntimeConfigs.data.dialogueCharacterDatas.TryGetValue(characterId, out var value2);
		return usage switch
		{
			CharacterModelUsage.Character => value?.DetaileShowModel, 
			CharacterModelUsage.Team => value?.showModel, 
			CharacterModelUsage.Catalog => value?.showModel, 
			CharacterModelUsage.Avg => (!string.IsNullOrEmpty(value2?.model)) ? value2.model : value?.showModel, 
			CharacterModelUsage.Lounge => value2?.model, 
			CharacterModelUsage.Npc => (!string.IsNullOrEmpty(value2?.model)) ? value2.model : value?.showModel, 
			_ => null, 
		};
	}

	public static string GetAnimatorAssetId(int skinId, CharacterModelUsage usage)
	{
		if (!TryGetSkin(skinId, out var skin))
		{
			return null;
		}
		return usage switch
		{
			CharacterModelUsage.Character => $"Skin/{skin.characterAnimator}", 
			CharacterModelUsage.Team => $"Skin/{skin.teamAnimator}", 
			CharacterModelUsage.Lounge => $"Skin/{skin.loungeAnimator}", 
			CharacterModelUsage.Avg => $"Skin/{skin.avgAnimator}", 
			CharacterModelUsage.Skin => $"Skin/{skin.skinUIAnimator}", 
			_ => null, 
		};
	}

	public static string GetBattleMappingAssetId(int skinId)
	{
		if (!TryGetSkin(skinId, out var skin) || string.IsNullOrEmpty(skin.battleMapping))
		{
			return null;
		}
		return $"Skin/{skin.battleMapping}";
	}

	public static GameObject ResolveDisplayObject(GameObject instance)
	{
		if (instance == null)
		{
			return null;
		}
		ControlDetailShowLight component = instance.GetComponent<ControlDetailShowLight>();
		if (component != null && component.idlePrefab != null)
		{
			return component.idlePrefab;
		}
		if (instance.transform.Find("Bip001") != null)
		{
			return instance;
		}
		if (instance.transform.childCount > 0)
		{
			GameObject gameObject = instance.transform.GetChild(0).gameObject;
			if (gameObject.transform.Find("Bip001") != null || gameObject.GetComponentInChildren<Animator>() != null)
			{
				return gameObject;
			}
		}
		return instance;
	}

	public static void ApplyAnimatorOverride(GameObject instance, RuntimeAnimatorController controller)
	{
		if (!(instance == null) && !(controller == null))
		{
			Animator[] componentsInChildren = instance.GetComponentsInChildren<Animator>(includeInactive: true);
			for (int i = 0; i < componentsInChildren.Length; i++)
			{
				componentsInChildren[i].runtimeAnimatorController = controller;
			}
		}
	}

	public static AnimationClip ResolveBattleClip(Entity entity, State state, ConfigMotion motion)
	{
		if (motion == null)
		{
			return null;
		}
		ConfigSkinBattleMapping configSkinBattleMapping = entity.GetCompBehave().ConfigSkinBattleMapping;
		if (configSkinBattleMapping != null && state != null)
		{
			int num = 1073741824;
			bool flag = (state.index & num) == 0;
			int num2 = (flag ? state.index : (state.index & ~num));
			AnimationClip[] array = (flag ? configSkinBattleMapping.moveAnimations : configSkinBattleMapping.attackAnimations);
			if (array != null && num2 >= 0 && num2 < array.Length && array[num2] != null)
			{
				return array[num2];
			}
		}
		return motion.clip;
	}

	public static async UniTask ChangeCharacterSkin(int characterId, int skinId)
	{
		Character character = G.localPlayer.GetCharacter(characterId);
		if (character == null || !EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
		{
			return;
		}
		MPPlayer localPlayer = MonoECS.instance.localPlayer;
		int index = localPlayer.IndexOfTeamCharacter(entity);
		if (index != -1)
		{
			int battleIndex = localPlayer.battleEntityIndex;
			Vector3 pos = entity.GetCompTransform()?.physicsPosition ?? Vector3.zero;
			bool left = entity.IsFaceLeft();
			character.SkinId = skinId;
			GameManager.cameraSystem.DestroyCharacterVCam(entity.Id);
			MonoECS.instance.ReleaseCharacterBattleEntity(entity);
			SetTeamCharacterEntity(localPlayer, index, EntityId.Invalid, battleIndex);
			Entity entity2 = await MonoECS.instance.SpawnOwnerCharacter(MPEntityType.Character, characterId, index, character, left, pos, loadSave: true, battleIndex);
			SetTeamCharacterEntity(localPlayer, index, entity2.IsValid ? entity2.Id : EntityId.Invalid, battleIndex);
			if (!entity2.IsValid && LuminApplication.LogEnabled)
			{
				Debug.LogError($"角色 {characterId} 切换皮肤 {skinId} 时重新生成 BattleEntity 失败");
			}
		}
	}

	private static void SetTeamCharacterEntity(MPPlayer localPlayer, int changedIndex, EntityId changedEntityId, int preferredBattleIndex)
	{
		EntityId[] array = new EntityId[BattleConsts.TEAMCAPITAL];
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = ((i == changedIndex) ? changedEntityId : localPlayer.GetTeamUid(i));
		}
		localPlayer.SetTeamCharacters(array, preferredBattleIndex, localPlayer.CurrentRuntimeBattleTeam.Characters);
	}
}
