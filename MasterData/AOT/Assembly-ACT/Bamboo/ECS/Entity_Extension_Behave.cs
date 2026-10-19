using System.Collections.Generic;
using System.Threading;
using ACT;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Core;
using ACT.MultiPlayer;
using ACT.Utility;
using JetBrains.Annotations;
using RootMotion.FinalIK;
using UnityEngine;

namespace Bamboo.ECS;

public static class Entity_Extension_Behave
{
	public static bool IsDummy(this Entity entity)
	{
		return entity.GetRoot()?.CompareTag(MonoECS.DummyTag) ?? false;
	}

	public static bool IsTrajectory(this Entity entity)
	{
		return entity.HasCompTrajectory();
	}

	public static bool IsBehaveEntity(this Entity entity)
	{
		if (!entity.HasCompCharacter() && !entity.HasCompMonster())
		{
			return entity.HasCompAssistNpc();
		}
		return true;
	}

	public static bool IsMonster(this Entity entity)
	{
		return entity.HasCompMonster();
	}

	public static bool IsCharacter(this Entity entity)
	{
		return entity.HasCompCharacter();
	}

	public static bool IsBoss(this Entity entity)
	{
		if (entity.HasCompMonster())
		{
			return entity.GetEntityType() == EntityType.Boss;
		}
		return false;
	}

	public static bool IsAssistNpc(this Entity entity)
	{
		return entity.HasCompAssistNpc();
	}

	public static bool IsBattleBehaveNotCharacter(this Entity entity)
	{
		if (!entity.IsMonster())
		{
			return entity.IsAssistNpc();
		}
		return true;
	}

	public static bool IsCollection(this Entity entity)
	{
		return entity.HasCompNeutral();
	}

	public static bool IsRobot(this Entity entity)
	{
		return entity.HasCompRobot();
	}

	public static bool IsNPC(this Entity entity)
	{
		if (entity.HasCompNpc())
		{
			return entity.GetEntityType() == EntityType.Npc;
		}
		return false;
	}

	public static bool IsWeakElement(this Entity entity, Element element)
	{
		int tableId = entity.GetTableId();
		if (tableId == 0 || !RuntimeConfigs.data.entityDatas.TryGetValue(tableId, out var value))
		{
			return false;
		}
		int[] weaknessElement = value.weaknessElement;
		foreach (int num in weaknessElement)
		{
			if (element == (Element)num)
			{
				return true;
			}
		}
		return false;
	}

	public static bool IsStrongWeakElement(this Entity entity, Element element)
	{
		int tableId = entity.GetTableId();
		if (tableId == 0 || !RuntimeConfigs.data.entityDatas.TryGetValue(tableId, out var value))
		{
			return false;
		}
		int[] strongWeaknessElement = value.strongWeaknessElement;
		foreach (int num in strongWeaknessElement)
		{
			if (element == (Element)num)
			{
				return true;
			}
		}
		return false;
	}

	public static EntityType FetchEntityType(this Entity entity, int id)
	{
		EntityType entityType = RuntimeConfigs.data.entityDatas[id].type switch
		{
			1 => EntityType.Character, 
			2 => EntityType.Monster, 
			3 => EntityType.Boss, 
			4 => EntityType.Robot, 
			5 => EntityType.Npc, 
			6 => EntityType.Elite, 
			7 => EntityType.AssistNpc, 
			_ => EntityType.Null, 
		};
		entity.SetEntityType(entityType);
		return entityType;
	}

	public static EntityType GetEntityType(this Entity entity)
	{
		if (!entity.TryGetCompBehave(out CompBehave component))
		{
			return EntityType.Null;
		}
		return component.EntityType;
	}

	public static void SetEntityType(this Entity entity, EntityType type)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			component.SetEntityType(type);
			GameManager.entityTickLodSystem?.Register(entity);
		}
	}

	public static EntityType SetEntityType(this Entity entity, int id)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			component.SetEntityType(id);
			GameManager.entityTickLodSystem?.Register(entity);
		}
		return component.EntityType;
	}

	public static int GetTableId(this Entity entity)
	{
		if (entity.TryGetCompCharacter(out CompCharacter component))
		{
			return component.characterSource.Id();
		}
		if (entity.TryGetCompMonster(out CompMonster component2))
		{
			return component2.id;
		}
		if (entity.TryGetCompAssistNpc(out CompAssistNpc component3))
		{
			return component3.id;
		}
		return 0;
	}

	public static bool IsInteractable(this Entity entity)
	{
		return entity.HasCompInteract();
	}

	public static bool IsStateObject(this Entity entity)
	{
		return entity.HasCompStateObject();
	}

	public static bool IsActive(this Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			return component.IsActive;
		}
		return false;
	}

	public static void SetActive(this Entity entity, bool value)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			component.SetActive(value);
		}
	}

	public static bool IsAlive(this Entity entity)
	{
		if (!entity.IsValid)
		{
			return false;
		}
		if (entity.TryGetCompAbility(out CompAbility component))
		{
			return component.alive;
		}
		return true;
	}

	public static void HideRenderer(this Entity entity)
	{
		MonoEntity mono = entity.GetMono();
		if ((object)mono != null)
		{
			Renderer[] renderers = mono.renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].enabled = false;
			}
		}
	}

	public static void ShowRenderer(this Entity entity)
	{
		MonoEntity mono = entity.GetMono();
		if ((object)mono != null)
		{
			Renderer[] renderers = mono.renderers;
			for (int i = 0; i < renderers.Length; i++)
			{
				renderers[i].enabled = true;
			}
		}
	}

	[CanBeNull]
	public static MonoEntity GetMono(this Entity entity)
	{
		if (!entity.TryGetCompBehave(out CompBehave component))
		{
			return null;
		}
		return component.MonoEntity;
	}

	[CanBeNull]
	public static GameObject GetRoot(this Entity entity)
	{
		if (!entity.TryGetCompBehave(out CompBehave component))
		{
			return null;
		}
		return component.Root;
	}

	[CanBeNull]
	public static Transform GetBip001(this Entity entity)
	{
		if (!entity.TryGetCompBehave(out CompBehave component))
		{
			return null;
		}
		return component.Bip001;
	}

	[CanBeNull]
	public static GameObject GetModel(this Entity entity)
	{
		if (!entity.TryGetCompBehave(out CompBehave component))
		{
			return null;
		}
		return component.Model;
	}

	[CanBeNull]
	public static FullBodyBipedIK GetIK(this Entity entity)
	{
		if (!entity.TryGetCompBehave(out CompBehave component))
		{
			return null;
		}
		return component.IK;
	}

	[CanBeNull]
	public static ConfigCharacter GetConfig(this Entity entity)
	{
		if (!entity.TryGetCompBehave(out CompBehave component))
		{
			return null;
		}
		return component.Config;
	}

	[CanBeNull]
	public static Transform GetModelTrans(this Entity entity)
	{
		return entity.GetModel()?.transform;
	}

	[CanBeNull]
	public static Transform GetRootTransform(this Entity entity)
	{
		return entity.GetRoot()?.transform;
	}

	public static Vector3 GetNetPosition(this Entity entity)
	{
		return entity.GetRootTransform()?.position ?? Vector3.zero;
	}

	public static Vector3 GetNetColliderPosition(this Entity entity)
	{
		CompTransform component;
		return entity.GetNetPosition() + (entity.TryGetCompTransform(out component) ? component.center : Vector3.zero);
	}

	public static void ShowRoot(this Entity entity)
	{
		entity.GetRoot()?.SetActive(value: true);
	}

	public static void HideRoot(this Entity entity)
	{
		entity.GetRoot()?.SetActive(value: false);
	}

	public static void SetHatred(this Entity entity, Entity hatred, bool temp = false)
	{
		if (hatred.InTag(EntityTag.UnHatable))
		{
			return;
		}
		CompHatred compHatred = entity.GetCompHatred();
		CompAI compAI = entity.GetCompAI();
		if (compHatred.hatredLevel != 0)
		{
			return;
		}
		if (hatred.IsValid)
		{
			bool flag = compHatred.hatredTarget != hatred;
			compHatred.SetHatred(hatred);
			if (flag)
			{
				entity.WakeTick();
			}
			if (!temp)
			{
				entity.SetBool("battleState", value: true);
			}
			if (entity.IsBattleBehaveNotCharacter())
			{
				compAI.battleState = true;
			}
			compHatred.isTemp = temp;
		}
		else
		{
			bool isValid = compHatred.hatredTarget.IsValid;
			compHatred.ClearHatred();
			if (isValid)
			{
				entity.WakeTick();
			}
			entity.SetBool("battleState", value: false);
			compAI.battleState = false;
			if (compAI.NeedGroupAIControl())
			{
				compAI.SetAttackToken(res: false);
			}
		}
	}

	public static void SetHatred(this Entity entity, Entity hatred, int hatredLevel, bool temp = false)
	{
		CompHatred compHatred = entity.GetCompHatred();
		if (compHatred == null || compHatred.hatredLevel >= hatredLevel)
		{
			return;
		}
		compHatred.hatredLevel = hatredLevel;
		if (hatred.IsValid)
		{
			bool flag = compHatred.hatredTarget != hatred;
			compHatred.SetHatred(hatred);
			if (flag)
			{
				entity.WakeTick();
			}
			if (!temp)
			{
				entity.SetBool("battleState", value: true);
			}
			if (entity.IsBattleBehaveNotCharacter())
			{
				entity.GetCompAI().battleState = true;
			}
			compHatred.isTemp = temp;
		}
	}

	public static bool InTag(this Entity entity, EntityTag value)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			return component.EntityTags.InTag(value);
		}
		return false;
	}

	public static bool InTag(this Entity entity, MotionTag_backUp value)
	{
		if (entity.TryGetCompMotion(out CompMotion component))
		{
			return component.InTag(value);
		}
		return false;
	}

	public static bool IsLogicAvailable(this Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			return component.IsLogicAvailable();
		}
		return false;
	}

	public static bool IsTickAvailable(this Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			return component.IsTickAvailable();
		}
		return false;
	}

	public static void WakeTick(this Entity entity, float seconds = 1f)
	{
		SystemEntityTickLOD entityTickLodSystem = GameManager.entityTickLodSystem;
		CompBehave component;
		if (entityTickLodSystem != null)
		{
			entityTickLodSystem.Wake(entity, "WakeTick", seconds);
		}
		else if (entity.TryGetCompBehave(out component))
		{
			component.WakeForSeconds(seconds);
		}
	}

	public static void PushFullTick(this Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			component.PushFullTick();
		}
	}

	public static void PopFullTick(this Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			component.PopFullTick();
		}
	}

	public static bool IsBehaveAvailable(this Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			return component.IsBehaveAvailable();
		}
		return false;
	}

	public static bool IsAINavAvailable(this Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			return component.IsAINavAvailable();
		}
		return false;
	}

	public static bool IsGot(this Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			return component.IsGot();
		}
		return false;
	}

	public static bool IsToRemove(this Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			return component.IsToRemove();
		}
		return false;
	}

	public static bool CanRemove(this Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			return component.CanRemove();
		}
		return false;
	}

	public static bool IsOnRemove(this Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			return component.IsOnRemove();
		}
		return false;
	}

	public static bool IsReleased(this Entity entity)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			return component.IsReleased();
		}
		return false;
	}

	public static FilterEntityType GetBeHitFilter(this Entity entity)
	{
		return GameUtility.defaultFilterEntityType;
	}

	public static void CharacterDamageHit(this Entity entity, CmdCharacterDamageHit hit)
	{
		if (entity.TryGetCompAbility(out CompAbility component))
		{
			component.onCharacterDamageHit?.Invoke(entity, hit.characterDamageType);
		}
	}

	public static CancellationToken GetCancellationTokenOnRelease(this Entity entity)
	{
		return entity.GetCompBehave()?.GetCancellationTokenOnRelease() ?? CancellationToken.None;
	}

	public static void BodyPartGetHit(this Entity entity, CmdBodyPartHit hit)
	{
		MonoEntity mono = entity.GetMono();
		if ((object)mono != null)
		{
			mono.bodyParts[hit.bodyIndex - 1].OnHit(hit.attackerFaceLeft, hit.forceAngle, hit.touchPos, hit.hitStrength);
		}
	}

	public static HitMaterial GetHitMaterial(this Entity entity)
	{
		return entity.GetCompBehave().HitMaterial;
	}

	public static void SetMaxChangeCd(this Entity entity, float value)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			component.SetMaxChangeCD(value);
		}
	}

	public static void SetChangeCd(this Entity entity, float value)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			component.ChangeCD = value;
		}
	}

	public static float GetChangeCd(this Entity entity)
	{
		if (!entity.TryGetCompBehave(out CompBehave component))
		{
			return 0f;
		}
		return component.ChangeCD;
	}

	public static Dictionary<string, float> GetChangeCdModifiers(this Entity entity)
	{
		if (!entity.TryGetCompBehave(out CompBehave component))
		{
			return null;
		}
		return component.ChangeCDModifiers;
	}

	public static void AddChangeCDModifier(this Entity entity, string key, float addCD)
	{
		entity.GetCompBehave()?.AddChangeCDModifier(key, addCD);
	}

	public static void RemoveChangeCDModifier(this Entity entity, string key)
	{
		entity.GetCompBehave()?.RemoveChangeCDModifier(key);
	}

	public static void SetOverrideHitMaterial(this Entity entity, HitMaterial value)
	{
		if (entity.TryGetCompBehave(out CompBehave component))
		{
			component.SetOverrideHitMaterial(value);
		}
	}

	public static void ResetOverrideHitMaterial(this Entity entity)
	{
		entity.GetCompBehave()?.ResetOverrideHitMaterial();
	}
}
