#define LOG_DEBUG
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using Nova.Hotfix;
using Pathfinding;
using TrueSync;
using Unity.Mathematics;
using UnityEngine;

public static class CommonHelper
{
	private static int encryptionKey;

	private static bool alreadyGetResistanceConfig;

	private static FP highResistanceValueUpperLimit;

	private static FP highResistanceValueLowerLimit;

	private static FP highResistanceAmendUpperLimit;

	private static FP highResistanceAmendLowerLimit;

	private static FP middleResistanceValueUpperLimit;

	private static FP middleResistanceValueLowerLimit;

	private static FP middleResistanceAmendUpperLimit;

	private static FP middleResistanceAmendLowerLimit;

	private static FP lowResistanceValueUpperLimit;

	private static FP lowResistanceValueLowerLimit;

	private static FP lowResistanceAmendUpperLimit;

	private static FP lowResistanceAmendLowerLimit;

	public const int TerrainLayerMask = 2048;

	public const int FlyLayerMask = 16;

	public const float MaxTerrainHeight = 200f;

	private static bool alreadyGetDefConfig = false;

	private static FDP defMaxReduceLimit;

	private static readonly AttributeSetLimitInfo[] limits = new AttributeSetLimitInfo[7];

	private static void GenerateEncryptionKey()
	{
		System.Random random = new System.Random();
		byte[] array = new byte[6];
		random.NextBytes(array);
		encryptionKey = BitConverter.ToInt32(array, 0);
	}

	public static int Encrypt(int value)
	{
		if (encryptionKey == 0)
		{
			GenerateEncryptionKey();
		}
		return value ^ encryptionKey;
	}

	public static int Decrypt(int value, int defaultV = 0)
	{
		if (value == defaultV)
		{
			return defaultV;
		}
		if (encryptionKey == 0)
		{
			GenerateEncryptionKey();
		}
		return value ^ encryptionKey;
	}

	public static int ParseStringParamToInt(string value)
	{
		return StringParamHelper.ParseStringParamToInt(value);
	}

	public static bool TryParseStringParamToInt(string value, out int intValue)
	{
		return StringParamHelper.TryParseStringParamToInt(value, out intValue);
	}

	public static float ParseStringParamToFloat(string value)
	{
		return StringParamHelper.ParseStringParamToFloat(value);
	}

	public static bool TryParseStringParamToFloat(string value, out float floatValue)
	{
		return StringParamHelper.TryParseStringParamToFloat(value, out floatValue);
	}

	public static FP ParseStringParamToFP(string value)
	{
		return (FP)decimal.Parse(value, CultureInfo.InvariantCulture);
	}

	public static bool TryParseStringParamToFP(string value, out FP fpValue)
	{
		if (decimal.TryParse(value, NumberStyles.Float | NumberStyles.AllowThousands, CultureInfo.InvariantCulture, out var result))
		{
			fpValue = (FP)result;
			return true;
		}
		fpValue = FP.Zero;
		return false;
	}

	public static FDP ParseStringParamToFDP(string value)
	{
		return (FDP)decimal.Parse(value, CultureInfo.InvariantCulture);
	}

	public static bool TryParseStringParamToFDP(string value, out FDP fpValue)
	{
		if (decimal.TryParse(value, NumberStyles.Float | NumberStyles.AllowThousands, CultureInfo.InvariantCulture, out var result))
		{
			fpValue = (FDP)result;
			return true;
		}
		fpValue = FDP.Zero;
		return false;
	}

	public static int StringToHash(string value)
	{
		if (!string.IsNullOrWhiteSpace(value))
		{
			return Animator.StringToHash(value);
		}
		return 0;
	}

	public static bool TryGetLogicComponent<T>(this GameObject gameObject, out T comp) where T : ILogicComponent
	{
		if (gameObject.TryGetComponent<LogicEntity>(out var component))
		{
			comp = component.GetLogicComponent<T>();
			return comp != null;
		}
		comp = default;
		return false;
	}

	public static bool TryGetParentLogicComponent<T>(this LogicEntity entity, out T comp) where T : ILogicComponent
	{
		comp = entity.GetLogicComponent<T>();
		if (comp != null)
		{
			return true;
		}
		if (entity.Parent != null)
		{
			return entity.Parent.TryGetParentLogicComponent<T>(out comp);
		}
		return false;
	}

	public static bool TryGetParentLogicComponent<T>(this GameObject go, out T comp) where T : ILogicComponent
	{
		if (go.TryGetComponent<LogicEntity>(out var component))
		{
			return component.TryGetParentLogicComponent<T>(out comp);
		}
		comp = default;
		return false;
	}

	public static bool TryGetParentComponent<T>(this GameObject go, out T comp) where T : MonoBehaviour
	{
		while (true)
		{
			if (go.TryGetComponent<T>(out comp))
			{
				return true;
			}
			if (!go.TryGetComponent<LogicEntity>(out var component) || !(component.Parent != null))
			{
				break;
			}
			go = component.Parent.gameObject;
		}
		comp = null;
		return false;
	}

	public static FP GetRadius(this LogicEntity entity)
	{
		if (entity == null)
		{
			return FP.Zero;
		}
		DeterministicCollider logicComponent = entity.GetLogicComponent<DeterministicCollider>();
		if (!(logicComponent != null))
		{
			return FP.Zero;
		}
		return logicComponent.Radius;
	}

	public static FP DistanceWithRadius(this LogicEntity aEntity, LogicEntity bEntity)
	{
		if (aEntity == null || bEntity == null)
		{
			return FP.MaxValue;
		}
		FP fP = TSVector2.Distance(aEntity.tsTransform.Position, bEntity.tsTransform.Position);
		FP fP2 = FP.Zero;
		FP fP3 = FP.Zero;
		DeterministicCollider logicComponent = aEntity.GetLogicComponent<DeterministicCollider>();
		if (logicComponent != null)
		{
			fP2 = logicComponent.Radius;
		}
		logicComponent = bEntity.GetLogicComponent<DeterministicCollider>();
		if (logicComponent != null)
		{
			fP3 = logicComponent.Radius;
		}
		return fP - (fP2 + fP3);
	}

	public static void StartWeaponFeature(List<WeaponFeature> features)
	{
		for (int i = 0; i < features.Count; i++)
		{
			WeaponFeature weaponFeature = features.get_Item(i);
			for (int j = weaponFeature.level; j < weaponFeature.initLevel; j++)
			{
				weaponFeature.UpgradeLevel();
			}
		}
		for (int k = 0; k < features.Count; k++)
		{
			features.get_Item(k).OnStart();
		}
	}

	public static void UpdateWeaponFeature(List<WeaponFeature> features)
	{
		for (int num = features.Count - 1; num >= 0; num--)
		{
			features.get_Item(num).OnUpdate();
		}
	}

	public static void SetDeterministicCollider(this LogicEntity entity, ref Collider collider, ref DeterministicCollider dtCollider, bool isRC = false)
	{
		if (collider == null)
		{
			collider = entity.gameObject.GetComponent<Collider>();
		}
		if (collider == null)
		{
			GameObject gameObject;
			if (!isRC)
			{
				collider = (gameObject = entity.gameObject).AddComponent<SphereCollider>();
			}
			else
			{
				collider = (gameObject = entity.gameObject).AddComponent<BoxCollider>();
			}
			Debug.LogError(gameObject.name + " 需要碰撞体组件!!!");
		}
		if (collider != null)
		{
			if (collider.gameObject == entity.gameObject)
			{
				dtCollider = entity.AddOrGetMonoLogicComponent<DeterministicCollider>();
			}
			else
			{
				Debug.LogError("碰撞体配置有误,自身:" + entity.gameObject.name + ",碰撞体:" + collider.gameObject.name);
			}
		}
	}

	public static void SearchEntityWithinRange(this LogicEntity entity, List<LogicEntity> scope, FP range)
	{
		for (int num = scope.Count - 1; num >= 0; num--)
		{
			if (scope.get_Item(num).DistanceWithRadius(entity) > range)
			{
				scope.RemoveAt(num);
			}
		}
	}

	public static void SearchEntityFriendly(this LogicEntity entity, List<LogicEntity> scope)
	{
		for (int num = scope.Count - 1; num >= 0; num--)
		{
			LogicEntity entityB = scope.get_Item(num);
			if (entity.IsConfrontWith(entityB))
			{
				scope.RemoveAt(num);
			}
		}
	}

	public static void SearchTeamMembers(string GroupId, List<LogicEntity> scope, bool excludeFromScope)
	{
		if (GroupId == null)
		{
			return;
		}
		AdventureEntityGroup adventureEntityGroup = SceneSingleton<ActorGroupManager>.Instance.QueryEntityGroupByID(GroupId);
		if (adventureEntityGroup == null)
		{
			return;
		}
		for (int num = scope.Count - 1; num >= 0; num--)
		{
			if (excludeFromScope)
			{
				if (adventureEntityGroup.ContainMember(scope.get_Item(num)))
				{
					scope.RemoveAt(num);
				}
			}
			else if (!adventureEntityGroup.ContainMember(scope.get_Item(num)))
			{
				scope.RemoveAt(num);
			}
		}
	}

	public static void SearchEntityViewable(this LogicEntity entity, List<LogicEntity> scope, bool searchFirst)
	{
		TSVector2 origin = entity.tsTransform.Position;
		if (searchFirst)
		{
			for (int i = 0; i < scope.Count; i++)
			{
				LogicEntity logicEntity = scope.get_Item(i);
				TSVector2 tSVector = logicEntity.tsTransform.Position - origin;
				TSVector2 direction = tSVector.normalized;
				if (!SceneSingleton<DeterministicCollisionManager>.Instance.Raycast(ref origin, ref direction, out var hitInfo, tSVector.magnitude, 4096))
				{
					scope.Clear();
					scope.Add(logicEntity);
					return;
				}
				AdventureObstacle adventureObstacle = hitInfo.collider.Entity as AdventureObstacle;
				if (adventureObstacle != null && !adventureObstacle.preventNormalAttack)
				{
					scope.Clear();
					scope.Add(logicEntity);
					return;
				}
			}
			scope.Clear();
			return;
		}
		for (int num = scope.Count - 1; num >= 0; num--)
		{
			TSVector2 tSVector2 = scope.get_Item(num).tsTransform.Position - origin;
			TSVector2 direction = tSVector2.normalized;
			if (SceneSingleton<DeterministicCollisionManager>.Instance.Raycast(ref origin, ref direction, out var hitInfo2, tSVector2.magnitude, 4096))
			{
				AdventureObstacle adventureObstacle2 = hitInfo2.collider.Entity as AdventureObstacle;
				if (adventureObstacle2 == null || adventureObstacle2.preventNormalAttack)
				{
					scope.RemoveAt(num);
				}
			}
		}
	}

	public static void SearchEntityOutOfRange(this LogicEntity entity, List<LogicEntity> scope, FP range)
	{
		for (int num = scope.Count - 1; num >= 0; num--)
		{
			if (scope.get_Item(num).DistanceWithRadius(entity) <= range)
			{
				scope.RemoveAt(num);
			}
		}
	}

	public static void SearchEntitySortByDistance(this LogicEntity entity, List<LogicEntity> scope)
	{
		for (int num = scope.Count - 1; num >= 0; num--)
		{
			LogicEntity logicEntity = scope.get_Item(num);
			FP value = logicEntity.DistanceWithRadius(entity);
			logicEntity.GetLogicComponent<LogicVariable>()?.SetLogicTagValue("SearchActorSortByDistance", value);
		}
		scope.Sort((LogicEntity a, LogicEntity b) =>
		{
			LogicVariable logicComponent = a.GetLogicComponent<LogicVariable>();
			LogicVariable logicComponent2 = b.GetLogicComponent<LogicVariable>();
			FP logicTagValue = logicComponent.GetLogicTagValue("SearchActorSortByDistance");
			FP logicTagValue2 = logicComponent2.GetLogicTagValue("SearchActorSortByDistance");
			if (logicTagValue < logicTagValue2)
			{
				return -1;
			}
			return (logicTagValue > logicTagValue2) ? 1 : 0;
		});
	}

	public static void SearchEntitySortByAngle(this LogicEntity entity, List<LogicEntity> scope)
	{
		for (int num = scope.Count - 1; num >= 0; num--)
		{
			LogicEntity logicEntity = scope.get_Item(num);
			FP value = TSVector2.Angle(entity.tsTransform.Forward, logicEntity.tsTransform.Position - entity.tsTransform.Position);
			logicEntity.GetLogicComponent<LogicVariable>()?.SetLogicTagValue("SearchActorSortByAngle", value);
		}
		scope.Sort((LogicEntity a, LogicEntity b) =>
		{
			LogicVariable logicComponent = a.GetLogicComponent<LogicVariable>();
			LogicVariable logicComponent2 = b.GetLogicComponent<LogicVariable>();
			FP logicTagValue = logicComponent.GetLogicTagValue("SearchActorSortByAngle");
			FP logicTagValue2 = logicComponent2.GetLogicTagValue("SearchActorSortByAngle");
			if (logicTagValue < logicTagValue2)
			{
				return -1;
			}
			return (logicTagValue > logicTagValue2) ? 1 : 0;
		});
	}

	public static void SearchEntitySortByHP(List<LogicEntity> scope, bool compareByPercentage)
	{
		if (compareByPercentage)
		{
			scope.Sort((LogicEntity a, LogicEntity b) =>
			{
				ActorHealthInfo logicComponent = a.GetLogicComponent<ActorHealthInfo>();
				ActorHealthInfo logicComponent2 = b.GetLogicComponent<ActorHealthInfo>();
				if (logicComponent.hpPercentage < logicComponent2.hpPercentage)
				{
					return -1;
				}
				return (logicComponent.hpPercentage > logicComponent2.hpPercentage) ? 1 : 0;
			});
			return;
		}
		scope.Sort((LogicEntity a, LogicEntity b) =>
		{
			ActorHealthInfo logicComponent = a.GetLogicComponent<ActorHealthInfo>();
			ActorHealthInfo logicComponent2 = b.GetLogicComponent<ActorHealthInfo>();
			if (logicComponent.hp < logicComponent2.hp)
			{
				return -1;
			}
			return (logicComponent.hp > logicComponent2.hp) ? 1 : 0;
		});
	}

	public static void SearchEntityAlive(List<LogicEntity> scope)
	{
		for (int num = scope.Count - 1; num >= 0; num--)
		{
			if (!IsEntityAlive(scope.get_Item(num)))
			{
				scope.RemoveAt(num);
			}
		}
	}

	public static void SearchEntityAlive(List<DeterministicCollider> scope)
	{
		for (int num = scope.Count - 1; num >= 0; num--)
		{
			if (!IsEntityAlive(scope.get_Item(num).Entity))
			{
				scope.RemoveAt(num);
			}
		}
	}

	public static bool IsEntityAlive(LogicEntity entity)
	{
		if (!(entity is AdventureActor adventureActor))
		{
			return false;
		}
		ActorHealthInfo logicComponent = entity.GetLogicComponent<ActorHealthInfo>();
		if (adventureActor.state != ActorState.Spawn)
		{
			return logicComponent?.isAlive ?? false;
		}
		return false;
	}

	public static void SearchEntityConfront(this LogicEntity entity, List<LogicEntity> scope)
	{
		AdventureActor adventureActor = entity as AdventureActor;
		if (adventureActor == null)
		{
			return;
		}
		for (int num = scope.Count - 1; num >= 0; num--)
		{
			if (!adventureActor.IsEntityConfrontAndSearchable(scope.get_Item(num)))
			{
				scope.RemoveAt(num);
			}
		}
	}

	public static bool IsEntityConfrontAndSearchable(this AdventureActor actor, LogicEntity otherEntity)
	{
		if (!(otherEntity is AdventureActor adventureActor))
		{
			return false;
		}
		return adventureActor.IsSearchableByEnemy(actor);
	}

	public static void InitSearchEntityContext(this LogicEntity entity, List<LogicEntity> scope, bool onlyAlive, bool includeSelf)
	{
		scope.Clear();
		List<Searchable> searchables = ModuleController<AdventureModuleController>.Instance.searchables;
		for (int i = 0; i < searchables.Count; i++)
		{
			Searchable searchable = searchables.get_Item(i);
			if (searchable != null && !(searchable.entity == null))
			{
				scope.Add(searchable.entity);
			}
		}
		if (onlyAlive)
		{
			for (int num = scope.Count - 1; num >= 0; num--)
			{
				LogicEntity logicEntity = scope.get_Item(num);
				ActorHealthInfo logicComponent = logicEntity.GetLogicComponent<ActorHealthInfo>();
				if (logicComponent == null || !logicComponent.isAlive)
				{
					scope.RemoveAt(num);
				}
				else if (!includeSelf && logicEntity == entity)
				{
					scope.RemoveAt(num);
				}
			}
			return;
		}
		for (int num2 = scope.Count - 1; num2 >= 0; num2--)
		{
			LogicEntity logicEntity2 = scope.get_Item(num2);
			if (!includeSelf && logicEntity2 == entity)
			{
				scope.RemoveAt(num2);
			}
		}
	}

	public static Vector3 GetCapsuleColliderBoundPosition(this AdventureActor self, AdventureActor target, out Quaternion rotation)
	{
		Vector3 position;
		if (target == null)
		{
			Transform transform = self.transform;
			rotation = transform.rotation;
			position = transform.position;
			return new Vector3(position.x, self.dtCollider.colliderBounds.center.y, position.z);
		}
		Vector3 vector = target.transform.position - self.transform.position;
		vector.Normalize();
		rotation = ((vector != Vector3.zero) ? Quaternion.LookRotation(new Vector3(vector.x, 0f, vector.z)) : self.transform.rotation);
		float num;
		float num2;
		if (self.dtCollider.Radius < AdventureModuleController.Config.dtRadius)
		{
			num = 0f;
			num2 = 0f;
		}
		else
		{
			float num3 = 0f;
			if (target is PlayerAdventureActor playerAdventureActor && self.actorInfo.hurtFxRadialOffsets != null)
			{
				num3 = ((playerAdventureActor.actorInfo.attackType == HotfixEnum.characterAttackType.MELEE) ? ((float)self.actorInfo.hurtFxRadialOffsets.get_Item(0)) : ((float)self.actorInfo.hurtFxRadialOffsets.get_Item(1)));
			}
			float f = Mathf.Acos(Vector3.Dot(Vector3.right, vector));
			num = Mathf.Cos(f) * ((float)self.dtCollider.Radius + num3);
			num2 = Mathf.Sin(f) * ((float)self.dtCollider.Radius + num3);
			if (Vector3.Dot(Vector3.forward, vector) < 0f)
			{
				num2 = 0f - num2;
			}
		}
		position = self.dtCollider.colliderBounds.center;
		return new Vector3(position.x + num, position.y, position.z + num2);
	}

	public static RelativePosition GetRelativePosition(Transform self, Transform target)
	{
		RelativePosition result = RelativePosition.OVERLAP;
		Vector3 rhs = target.position - self.position;
		rhs.Normalize();
		float num = Vector3.Dot(self.forward, rhs);
		float num2 = Vector3.Dot(self.right, rhs);
		float num3 = num;
		if (!(num3 > 0f))
		{
			if (!(num3 < 0f))
			{
				if (num3 == 0f)
				{
					if (num2 > 0f)
					{
						result = RelativePosition.RIGHT;
					}
					else if (num2 < 0f)
					{
						result = RelativePosition.LEFT;
					}
					else if (num2 == 0f)
					{
						result = RelativePosition.OVERLAP;
					}
				}
			}
			else if (num2 > 0f)
			{
				result = RelativePosition.DOWN_RIGHT;
			}
			else if (num2 < 0f)
			{
				result = RelativePosition.DOWN_LEFT;
			}
			else if (num2 == 0f)
			{
				result = RelativePosition.DOWN;
			}
		}
		else if (num2 > 0f)
		{
			result = RelativePosition.UP_RIGHT;
		}
		else if (num2 < 0f)
		{
			result = RelativePosition.UP_LEFT;
		}
		else if (num2 == 0f)
		{
			result = RelativePosition.UP;
		}
		return result;
	}

	public static void GetEEAndER(HotfixEnum.elementType type, AttributeList toAttributeList, AttributeList fromAttributeList, out FDP fromEE, out FDP fromER, out FDP fromEP, out FDP fromEI, out FDP fromEERCD, out FDP toEE, out FDP toER, out FDP toEP, out FDP toEI, out FDP toEERCD)
	{
		fromEE = FDP.Zero;
		fromER = FDP.Zero;
		fromEP = FDP.Zero;
		fromEI = FDP.Zero;
		fromEERCD = FDP.Zero;
		toEE = FDP.Zero;
		toER = FDP.Zero;
		toEP = FDP.Zero;
		toEI = FDP.Zero;
		toEERCD = FDP.Zero;
		if (type != HotfixEnum.elementType.NONE && type != HotfixEnum.elementType.INHERIT && toAttributeList != null && fromAttributeList != null)
		{
			fromEE = fromAttributeList.GetHarmElementValue(type);
			fromER = fromAttributeList.GetResistanceElementValue(type);
			fromEP = fromAttributeList.GetPentrateElementValue(type);
			fromEI = fromAttributeList.GetIgnoringInjuredElementValue(type);
			fromEERCD = fromAttributeList.GetInjuredElementValue(type);
			toEE = toAttributeList.GetHarmElementValue(type);
			toER = toAttributeList.GetResistanceElementValue(type);
			toEP = toAttributeList.GetPentrateElementValue(type);
			toEI = toAttributeList.GetIgnoringInjuredElementValue(type);
			toEERCD = toAttributeList.GetInjuredElementValue(type);
		}
	}

	public static FDP GetAdditionalSkillAbsAmend(HitDamage hitDamage, AdventureActor fromActor, AdventureActor toActor, int skillLevel)
	{
		FDP zero = FDP.Zero;
		if (hitDamage.AdditionalType == 0)
		{
			return zero;
		}
		AdventureActor adventureActor = toActor;
		if (hitDamage.AdditionalSource == 2)
		{
			adventureActor = fromActor;
		}
		zero = GetAttrByType((HotfixEnum.effectAttributeType)hitDamage.AdditionalType, adventureActor.attributeList);
		int index = Mathf.Clamp(skillLevel, 0, hitDamage.AdditionalPercent.Count - 1);
		return zero * FDP.FromPercent(hitDamage.AdditionalPercent.get_Item(index));
	}

	public static FDP GetAttrByType(HotfixEnum.effectAttributeType attributeType, AdventureActor actor)
	{
		return GetAttrByType(attributeType, actor.attributeList);
	}

	public static FDP GetAttrByType(HotfixEnum.effectAttributeType attributeType, AttributeList attributeList)
	{
		return attributeList?.GetAttributeValue(attributeType) ?? FDP.Zero;
	}

	public static void GetSkillAndTalentGroupAmend(int skillLevel, int talentGroupLevel, HitDamage hitDamageConfig, out FDP skillPercentAmend, out FDP skillAbsAmend, out FDP talentGroupPercentAmend, out FDP talentGroupAbsAmend)
	{
		if (hitDamageConfig.SkillPercentAmend.Count > 0)
		{
			int index = Mathf.Clamp(skillLevel, 0, hitDamageConfig.SkillPercentAmend.Count - 1);
			skillPercentAmend = hitDamageConfig.SkillPercentAmend.get_Item(index);
		}
		else
		{
			NovaLogger.Debug($"HitDamage表，id：{hitDamageConfig.Id},技能百分比修正没有配置！");
			skillPercentAmend = FDP.Zero;
		}
		if (hitDamageConfig.SkillAbsAmend.Count > 0)
		{
			int index2 = Mathf.Clamp(skillLevel, 0, hitDamageConfig.SkillAbsAmend.Count - 1);
			skillAbsAmend = hitDamageConfig.SkillAbsAmend.get_Item(index2);
		}
		else
		{
			NovaLogger.Debug($"HitDamage表，id：{hitDamageConfig.Id},技能绝对值修正没有配置！");
			skillAbsAmend = FDP.Zero;
		}
		talentGroupAbsAmend = FDP.Zero;
		talentGroupPercentAmend = FDP.Zero;
		if (talentGroupLevel != -1)
		{
			talentGroupLevel--;
			if (hitDamageConfig.TalentAbsAmend.Count > 0)
			{
				int index3 = Mathf.Clamp(talentGroupLevel, 0, hitDamageConfig.TalentAbsAmend.Count - 1);
				talentGroupAbsAmend = hitDamageConfig.TalentAbsAmend.get_Item(index3);
			}
			else
			{
				Debug.LogError($"HitDamage表，id：{hitDamageConfig.Id},天赋分支组合等级绝对值修正没有配置！");
			}
			if (hitDamageConfig.TalentPercentAmend.Count > 0)
			{
				int index3 = Mathf.Clamp(talentGroupLevel, 0, hitDamageConfig.TalentPercentAmend.Count - 1);
				talentGroupPercentAmend = hitDamageConfig.TalentPercentAmend.get_Item(index3);
			}
			else
			{
				Debug.LogError($"HitDamage表，id：{hitDamageConfig.Id},天赋分支组合等级百分比修正没有配置！");
			}
		}
	}

	public static void ResetConfigCache()
	{
		alreadyGetResistanceConfig = false;
		for (int i = 0; i < limits.Length; i++)
		{
			limits[i] = null;
		}
		alreadyGetDefConfig = false;
	}

	public static void GetResistanceLimits(FP finalResistance, out FP valueUpperLimit, out FP valueLowerLimit, out FP amendUpperLimit, out FP amendLowerLimit, out int hudColorIndexTemp)
	{
		if (!alreadyGetResistanceConfig)
		{
			alreadyGetResistanceConfig = true;
			highResistanceValueUpperLimit = ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("HighResistanceValueUpperLimit").Value);
			highResistanceValueLowerLimit = ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("HighResistanceValueLowerLimit").Value);
			highResistanceAmendUpperLimit = ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("HighResistanceAmendUpperLimit").Value);
			highResistanceAmendLowerLimit = ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("HighResistanceAmendLowerLimit").Value);
			middleResistanceValueUpperLimit = ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("MiddleResistanceValueUpperLimit").Value);
			middleResistanceValueLowerLimit = ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("MiddleResistanceValueLowerLimit").Value);
			middleResistanceAmendUpperLimit = ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("MiddleResistanceAmendUpperLimit").Value);
			middleResistanceAmendLowerLimit = ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("MiddleResistanceAmendLowerLimit").Value);
			lowResistanceValueUpperLimit = ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("LowResistanceValueUpperLimit").Value);
			lowResistanceValueLowerLimit = ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("LowResistanceValueLowerLimit").Value);
			lowResistanceAmendUpperLimit = ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("LowResistanceAmendUpperLimit").Value);
			lowResistanceAmendLowerLimit = ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("LowResistanceAmendLowerLimit").Value);
		}
		valueUpperLimit = highResistanceValueUpperLimit;
		valueLowerLimit = highResistanceValueLowerLimit;
		amendUpperLimit = highResistanceAmendUpperLimit;
		amendLowerLimit = highResistanceAmendLowerLimit;
		hudColorIndexTemp = 5;
		if (finalResistance >= lowResistanceValueLowerLimit && finalResistance <= lowResistanceValueUpperLimit)
		{
			valueUpperLimit = lowResistanceValueUpperLimit;
			valueLowerLimit = lowResistanceValueLowerLimit;
			amendUpperLimit = lowResistanceAmendUpperLimit;
			amendLowerLimit = lowResistanceAmendLowerLimit;
			hudColorIndexTemp = 3;
		}
		else if (finalResistance >= middleResistanceValueLowerLimit && finalResistance <= middleResistanceValueUpperLimit)
		{
			valueUpperLimit = middleResistanceValueUpperLimit;
			valueLowerLimit = middleResistanceValueLowerLimit;
			amendUpperLimit = middleResistanceAmendUpperLimit;
			amendLowerLimit = middleResistanceAmendLowerLimit;
			hudColorIndexTemp = 4;
		}
	}

	public static FP GetHighResistanceAmendUpperLimit()
	{
		if (alreadyGetResistanceConfig)
		{
			return highResistanceAmendUpperLimit;
		}
		return ParseStringParamToFP(Singleton<GameDataController>.Instance.GetConfig("HighResistanceAmendUpperLimit").Value);
	}

	public static float GetTerrainHeight(Vector2 targetPosition, float defaultPositionY, out bool raycastHit)
	{
		return GetNavmeshLayerHeight(2048, targetPosition, defaultPositionY, out raycastHit);
	}

	public static float GetFlyHeight(Vector2 targetPosition, float defaultPositionY, out bool raycastHit)
	{
		return GetNavmeshLayerHeight(16, targetPosition, defaultPositionY, out raycastHit);
	}

	public static FP GetFlyHeight(TSVector2 targetPosition, FP defaultPositionY, out bool raycastHit)
	{
		return GetFlyHeight(targetPosition.ToVector2(), (float)defaultPositionY, out raycastHit);
	}

	public static FP GetFlyHeight(TSVector2 targetPosition, FP defaultPositionY)
	{
		bool raycastHit;
		return GetFlyHeight(targetPosition.ToVector2(), (float)defaultPositionY, out raycastHit);
	}

	public static float GetNavmeshLayerHeight(int layMask, Vector2 targetPosition, float defaultPositionY, out bool raycastHit)
	{
		raycastHit = false;
		float result = defaultPositionY;
		if (Physics.Raycast(new Vector3(targetPosition.x, 100f, targetPosition.y), Vector3.down, out var hitInfo, 200f, layMask, QueryTriggerInteraction.Ignore))
		{
			result = hitInfo.point.y;
			raycastHit = true;
		}
		return result;
	}

	public static FP GetTerrainHeight(TSVector2 targetPosition, FP defaultPositionY)
	{
		bool raycastHit;
		return GetTerrainHeight(targetPosition.ToVector2(), (float)defaultPositionY, out raycastHit);
	}

	public static FP GetTerrainHeight(TSVector2 targetPosition, FP defaultPositionY, out bool raycastHit)
	{
		return GetTerrainHeight(targetPosition.ToVector2(), (float)defaultPositionY, out raycastHit);
	}

	public static FP GetGroundHeightByActorMoveType(AdventureActor actor, TSVector2 targetPosition, FP defaultPositionY)
	{
		if (actor == null)
		{
			return defaultPositionY;
		}
		if (actor.actorInfo.moveType != HotfixEnum.actorMovType.FLY)
		{
			return GetTerrainHeight(targetPosition, defaultPositionY);
		}
		return GetFlyHeight(targetPosition, defaultPositionY);
	}

	public static bool QueryPositionWalkableOnAllLayer(TSVector2 position)
	{
		NNConstraint _reachableConstraint = NNConstraint.Default;
		if (!QueryPositionWalkable(position, NavAgentTypeNames.HumanoidGraphMask, GetTerrainHeight(position, 0)))
		{
			return QueryPositionWalkable(position, NavAgentTypeNames.FlyingGraphMask, GetFlyHeight(position, 0));
		}
		return true;
		static NavmeshBase GetNavmeshGraph(GraphMask mask)
		{
			NavGraph[] graphs = AstarPath.active.graphs;
			for (int i = 0; i < graphs.Length; i++)
			{
				NavGraph navGraph = graphs[i];
				if (navGraph != null && mask.Contains(i))
				{
					return navGraph as NavmeshBase;
				}
			}
			return null;
		}
		bool QueryPositionWalkable(TSVector2 tSVector, GraphMask mask, FP positionY)
		{
			NavmeshBase navmeshBase = GetNavmeshGraph(mask);
			if (navmeshBase == null)
			{
				return true;
			}
			_reachableConstraint.graphMask = mask;
			_reachableConstraint.constrainDistance = true;
			_reachableConstraint.distanceXZ = true;
			_reachableConstraint.constrainWalkability = true;
			_reachableConstraint.walkable = true;
			return navmeshBase.PointOnNavmesh(new TSVector(tSVector.x, positionY, tSVector.y), _reachableConstraint) != null;
		}
	}

	public static bool QueryPositionReachableOnAllLayer(TSVector2 startPosition, TSVector2 position)
	{
		NNConstraint _reachableConstraint = NNConstraint.Default;
		if (!QueryPositionReachable(startPosition, position, NavAgentTypeNames.HumanoidGraphMask, GetTerrainHeight(position, 0)))
		{
			return QueryPositionReachable(startPosition, position, NavAgentTypeNames.HumanoidGraphMask, GetTerrainHeight(position, 0));
		}
		return true;
		bool QueryPositionReachable(TSVector2 tSVector, TSVector2 tSVector2, GraphMask mask, FP positionY)
		{
			AstarPath.active.maxNearestNodeDistance = AdventureModuleController.Config.Level_ReachableNearestNodeDistance;
			try
			{
				_reachableConstraint.graphMask = mask;
				_reachableConstraint.constrainDistance = true;
				_reachableConstraint.distanceXZ = true;
				_reachableConstraint.constrainWalkability = true;
				_reachableConstraint.walkable = true;
				TSVector start = new TSVector(tSVector.x, positionY, tSVector.y);
				TSVector end = new TSVector(tSVector2.x, positionY, tSVector2.y);
				ABPath aBPath = ABPath.Construct(start, end);
				aBPath.nnConstraint = _reachableConstraint;
				AstarPath.StartPath(aBPath);
				aBPath.BlockUntilCalculated();
				UnityEngine.Object o = new UnityEngine.Object();
				aBPath.Claim(o);
				if (aBPath.error)
				{
					aBPath.Release(o);
					return false;
				}
				aBPath.Release(o);
				return true;
			}
			finally
			{
				AstarPath.active.maxNearestNodeDistance = AdventureModuleController.Config.Level_NavigationMaxNearestNodeDistance;
			}
		}
	}

	public static Vector3 GetBezierPointByT(Vector3 begin, Vector3 handle, Vector3 end, float t)
	{
		float num = Mathf.Pow(1f - t, 2f);
		float x = num * begin.x + 2f * t * (1f - t) * handle.x + t * t * end.x;
		float y = num * begin.y + 2f * t * (1f - t) * handle.y + t * t * end.y;
		float z = num * begin.z + 2f * t * (1f - t) * handle.z + t * t * end.z;
		return new Vector3(x, y, z);
	}

	public static Vector3 GetBezier3PointByT(Vector3 begin, Vector3 handle1, Vector3 handle2, Vector3 end, float t)
	{
		Vector3 bezierPointByT = GetBezierPointByT(begin, handle1, handle2, t);
		Vector3 bezierPointByT2 = GetBezierPointByT(handle1, handle2, end, t);
		return Vector3.Lerp(bezierPointByT, bezierPointByT2, t);
	}

	public static TSVector GetBezierPointByT(TSVector begin, TSVector handle, TSVector end, FP t)
	{
		FP fP = FP.One - t;
		FP fP2 = fP * fP;
		FP fP3 = t * t;
		FP fP4 = 2 * t * fP;
		FP x = fP2 * begin.x + fP4 * handle.x + fP3 * end.x;
		FP y = fP2 * begin.y + fP4 * handle.y + fP3 * end.y;
		FP z = fP2 * begin.z + fP4 * handle.z + fP3 * end.z;
		return new TSVector(x, y, z);
	}

	public static TSVector GetBezier3PointByT(TSVector begin, TSVector handle1, TSVector handle2, TSVector end, FP t)
	{
		TSVector bezierPointByT = GetBezierPointByT(begin, handle1, handle2, t);
		TSVector bezierPointByT2 = GetBezierPointByT(handle1, handle2, end, t);
		return TSVector.Lerp(bezierPointByT, bezierPointByT2, t);
	}

	public static string GetUltraSkillTimelineAlias(AdventureActor actor, int phaseIndex, bool addPlayTime)
	{
		UIGameSystemSetup.TimeLinePlayType playType = Singleton<UIGameSystemSetup>.Instance.PlayType;
		string dateKey = $"{AdventureModuleHelper.playerUid}_{actor.dataID}day";
		string timeKey = $"{AdventureModuleHelper.playerUid}_{actor.dataID}Time";
		int num = GetPlayTime(dateKey, timeKey);
		string result = GetTimelineAlias(actor, normal: true, phaseIndex);
		switch (playType)
		{
		case UIGameSystemSetup.TimeLinePlayType.dayOnce:
			result = GetTimelineAlias(actor, num < 1, phaseIndex);
			break;
		case UIGameSystemSetup.TimeLinePlayType.dayThree:
			result = GetTimelineAlias(actor, num < 3, phaseIndex);
			break;
		case UIGameSystemSetup.TimeLinePlayType.none:
			result = GetTimelineAlias(actor, normal: false, phaseIndex);
			break;
		}
		if (addPlayTime)
		{
			SetPlayTime(dateKey, timeKey, ++num);
		}
		return result;
		static int GetPlayTime(string key, string key2)
		{
			int day = DateTime.Now.Day;
			if (PlayerPrefs.GetInt(key, 0) == day)
			{
				return PlayerPrefs.GetInt(key2, 0);
			}
			return 0;
		}
		static string GetTimelineAlias(AdventureActor adventureActor, bool normal, int num2)
		{
			ComboGroup comboGroup = adventureActor.comboGroup;
			if (adventureActor is PlayerAdventureActor { isSkin: not false } playerAdventureActor && playerAdventureActor.comboGroupForSkin != null)
			{
				comboGroup = playerAdventureActor.comboGroupForSkin;
			}
			return num2 switch
			{
				1 => normal ? comboGroup.timelineAlias : comboGroup.timelineAliasN, 
				2 => normal ? comboGroup.timelineAlias_1 : comboGroup.timelineAliasN_1, 
				3 => normal ? comboGroup.timelineAlias_2 : comboGroup.timelineAliasN_2, 
				4 => normal ? comboGroup.timelineAlias_3 : comboGroup.timelineAliasN_3, 
				_ => "", 
			};
		}
		static void SetPlayTime(string key, string key2, int time)
		{
			int day = DateTime.Now.Day;
			PlayerPrefs.SetInt(key, day);
			PlayerPrefs.SetInt(key2, time);
		}
	}

	public static int GetValueConfigIdByLevelType(AdventureActor actor, int mainConfigId, HotfixEnum.levelTypeData type, int data)
	{
		int num = 0;
		if (actor == null)
		{
			return mainConfigId;
		}
		PlayerAdventureActor playerAdventureActor = actor as PlayerAdventureActor;
		PlayerAdventureActor summoner;
		SummonType summonType;
		if (playerAdventureActor != null)
		{
			num = GetLevelByLevelType(actor.dataID, type, playerAdventureActor.playerSkillCd, data);
		}
		else if (actor.IsPlayerSummoned(out summoner, out summonType))
		{
			num = GetLevelByLevelType(summoner.dataID, type, summoner.playerSkillCd, data);
		}
		return mainConfigId + num * 10;
	}

	public static int GetLevelByLevelType(int actorDataId, HotfixEnum.levelTypeData type, PlayerSkillCd skillCd, int data)
	{
		return type switch
		{
			HotfixEnum.levelTypeData.Exclusive => ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(data), 
			HotfixEnum.levelTypeData.Actor => ModuleController<AdventureModuleController>.Instance.GetActorLevel(actorDataId), 
			HotfixEnum.levelTypeData.SkillSlot => skillCd?.GetSkillLevel((ActionKey)data) ?? 0, 
			HotfixEnum.levelTypeData.BreakCount => ModuleController<AdventureModuleController>.Instance.GetActorBreakCount(actorDataId), 
			HotfixEnum.levelTypeData.DiscSkill => ModuleController<AdventureModuleController>.Instance.GetDiscSkillLevel(data), 
			HotfixEnum.levelTypeData.Note => ModuleController<AdventureModuleController>.Instance.GetNoteCount(data), 
			HotfixEnum.levelTypeData.BuildLevel => ModuleController<AdventureModuleController>.Instance.BuildLevel, 
			_ => 0, 
		};
	}

	public static void EnableSkillInput(bool enable, List<string> btnList = null)
	{
		StringBuilder stringBuilder = new StringBuilder();
		if (btnList == null || btnList.Count == 0)
		{
			btnList = new List<string> { "Fire1", "Fire2", "Fire4", "ActorSwitch1", "ActorSwitch2", "SwitchWithUltra1", "SwitchWithUltra2" };
		}
		foreach (string btn in btnList)
		{
			stringBuilder.Append("+");
			stringBuilder.Append(btn);
		}
		MonoSingleton<LuaManager>.Instance.FireEvent("EnableBtnControl", stringBuilder.ToString(), enable);
	}

	public static int GetMonsterTeammateId(int teamId, int index)
	{
		int result = 0;
		MonsterTeam teamConfig = Singleton<HotfixDataController>.Instance.GetMonsterTeam(teamId);
		if (teamConfig != null)
		{
			result = index switch
			{
				0 => teamConfig.Mate0Id, 
				1 => teamConfig.Mate1Id, 
				2 => teamConfig.Mate2Id, 
				3 => teamConfig.Mate3Id, 
				4 => teamConfig.Mate4Id, 
				5 => teamConfig.Mate5Id, 
				6 => teamConfig.Mate6Id, 
				7 => teamConfig.Mate7Id, 
				_ => GetMonsterTeammateMoreId(), 
			};
		}
		return result;
		int GetMonsterTeammateMoreId()
		{
			int num = index - 8;
			if (num >= 0 && num < teamConfig.MateMoreId.Count)
			{
				return teamConfig.MateMoreId.get_Item(num);
			}
			return 0;
		}
	}

	public static long CalculateNormalDamage(AdventureActor fromActor, AdventureActor toActor, HitDamage hitDamageConfig, int skillLevel, bool isCrit, bool isDot, out int hudColorIndex, out FDP skillPercentAmend, out FDP talentGroupPercentAmend, out FDP skillAbsAmend, out FDP talentGroupAbsAmend, out FDP perkIntensityRatio, out FDP slotDmgRatio, out FDP fromEE, out FDP erAmend, out FDP defAmend, out FDP rcdSlotDmgRatio, out FDP toEERCD, out FDP skillIntensityRatio, out FDP toughnessBrokenDmgRatio, out FDP critRatio, out FDP envAmendRatio)
	{
		ActorAdditionalAttrInfo fromAdditionalAttrInfo = AdventureActor.fromAdditionalAttrInfo;
		ActorAdditionalAttrInfo toAdditionalAttrInfo = AdventureActor.toAdditionalAttrInfo;
		_ = toActor.actorElementInfo.elementType;
		_ = toActor.actorElementInfo.weakElementType;
		HotfixEnum.elementType hitDamageElementType = GetHitDamageElementType(hitDamageConfig, fromActor);
		FDP attributeValue = fromAdditionalAttrInfo.GetAttributeValue((HotfixEnum.effectAttributeType)hitDamageConfig.DamageBonusType);
		GetSkillAndTalentGroupAmend(skillLevel, -1, hitDamageConfig, out skillPercentAmend, out skillAbsAmend, out talentGroupPercentAmend, out talentGroupAbsAmend);
		skillAbsAmend += GetAdditionalSkillAbsAmend(hitDamageConfig, fromActor, toActor, skillLevel);
		FDP y = attributeValue * ((skillPercentAmend + talentGroupPercentAmend) / 10000L / 100L) + skillAbsAmend + talentGroupAbsAmend;
		y = FDP.Max(FDP.One, y);
		FDP fDP = toAdditionalAttrInfo.def * (FDP.One - fromAdditionalAttrInfo.defIgnore) - fromAdditionalAttrInfo.defPenetrate;
		if (!alreadyGetDefConfig)
		{
			defMaxReduceLimit = ParseStringParamToFDP(Singleton<GameDataController>.Instance.GetConfig("DynamicDEFCap")?.Value);
			alreadyGetDefConfig = true;
		}
		FDP attributeOriginValue = toAdditionalAttrInfo.GetAttributeOriginValue(HotfixEnum.effectAttributeType.DEF);
		FDP fDP2 = attributeOriginValue - fDP;
		if (fDP2 > defMaxReduceLimit)
		{
			fDP2 = defMaxReduceLimit;
		}
		fDP = attributeOriginValue - fDP2;
		FDP fDP3 = (defAmend = FDP.One - fDP * 40L / (fDP * 32L + 24000L));
		GetEEAndER(hitDamageElementType, toAdditionalAttrInfo.attributeList, fromAdditionalAttrInfo.attributeList, out fromEE, out var _, out var fromEP, out var fromEI, out var _, out var _, out var toER, out var _, out var _, out toEERCD);
		switch (hitDamageElementType)
		{
		case HotfixEnum.elementType.WE:
			fromEP = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.WEP, HotfixEnum.elementType.NONE, (HotfixEnum.damageType)hitDamageConfig.DamageType);
			break;
		case HotfixEnum.elementType.FE:
			fromEP = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.FEP, HotfixEnum.elementType.NONE, (HotfixEnum.damageType)hitDamageConfig.DamageType);
			break;
		case HotfixEnum.elementType.SE:
			fromEP = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.SEP, HotfixEnum.elementType.NONE, (HotfixEnum.damageType)hitDamageConfig.DamageType);
			break;
		case HotfixEnum.elementType.AE:
			fromEP = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.AEP, HotfixEnum.elementType.NONE, (HotfixEnum.damageType)hitDamageConfig.DamageType);
			break;
		case HotfixEnum.elementType.LE:
			fromEP = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.LEP, HotfixEnum.elementType.NONE, (HotfixEnum.damageType)hitDamageConfig.DamageType);
			break;
		case HotfixEnum.elementType.DE:
			fromEP = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.DEP, HotfixEnum.elementType.NONE, (HotfixEnum.damageType)hitDamageConfig.DamageType);
			break;
		}
		rcdSlotDmgRatio = FDP.One;
		slotDmgRatio = FDP.One;
		FDP attributeSetValue = FDP.Zero;
		FDP fDP4 = FDP.Zero;
		switch ((HotfixEnum.damageType)hitDamageConfig.DamageType)
		{
		case HotfixEnum.damageType.NORMAL:
			rcdSlotDmgRatio = toAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.RCDNORMALDMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			slotDmgRatio = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.NORMALDMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.NORMALCRITPOWER, hitDamageElementType, HotfixEnum.damageType.NONE);
			fDP4 = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.NORMAL_SUPPRESS, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		case HotfixEnum.damageType.SKILL:
			rcdSlotDmgRatio = toAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.RCDSKILLDMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			slotDmgRatio = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.SKILLDMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.SKILLCRITPOWER, hitDamageElementType, HotfixEnum.damageType.NONE);
			fDP4 = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.SKILL_SUPPRESS, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		case HotfixEnum.damageType.ULTIMATE:
			rcdSlotDmgRatio = toAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.RCDULTRADMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			slotDmgRatio = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.ULTRADMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.ULTRACRITPOWER, hitDamageElementType, HotfixEnum.damageType.NONE);
			fDP4 = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.ULTRA_SUPPRESS, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		case HotfixEnum.damageType.OTHER:
			rcdSlotDmgRatio = toAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.RCDOTHERDMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			slotDmgRatio = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.OTHERDMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.OTHERCRITPOWER, hitDamageElementType, HotfixEnum.damageType.NONE);
			fDP4 = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.OTHER_SUPPRESS, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		case HotfixEnum.damageType.MARK:
			rcdSlotDmgRatio = toAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.RCDMARKDMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			slotDmgRatio = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.MARKDMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.MARKCRITPOWER, hitDamageElementType, HotfixEnum.damageType.NONE);
			fDP4 = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.MARK_SUPPRESS, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		case HotfixEnum.damageType.PROJECTILE:
			rcdSlotDmgRatio = toAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.RCDPROJECTILEDMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			slotDmgRatio = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.PROJECTILEDMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.PROJECTILECRITPOWER, hitDamageElementType, HotfixEnum.damageType.NONE);
			fDP4 = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.PROJECTILE_SUPPRESS, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		case HotfixEnum.damageType.SUMMON:
			rcdSlotDmgRatio = toAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.RCDSUMMONDMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			slotDmgRatio = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.SUMMONDMG, hitDamageElementType, HotfixEnum.damageType.NONE);
			attributeSetValue = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.SUMMONCRITPOWER, hitDamageElementType, HotfixEnum.damageType.NONE);
			fDP4 = fromAdditionalAttrInfo.GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType.SUMMON_SUPPRESS, hitDamageElementType, HotfixEnum.damageType.NONE);
			break;
		}
		ClampAttributeSetWithLimit(HotfixEnum.attributeFinialLimitType.FINAL_ELEMENTTYPE_DAMAGETYPE_EP, fromActor, ref fromEP);
		ClampAttributeSetWithLimit(HotfixEnum.attributeFinialLimitType.FINAL_ELEMENTTYPE_DAMAGETYPE_RCDDMG, toActor, ref rcdSlotDmgRatio);
		ClampAttributeSetWithLimit(HotfixEnum.attributeFinialLimitType.FINAL_ELEMENTTYPE_DAMAGETYPE_DMG, fromActor, ref slotDmgRatio);
		ClampAttributeSetWithLimit(HotfixEnum.attributeFinialLimitType.FINAL_ELEMENTTYPE_DAMAGETYPE_CRITPOWER, fromActor, ref attributeSetValue);
		FDP attributeSetValue2 = fromAdditionalAttrInfo.suppressRatio + fDP4;
		ClampAttributeSetWithLimit(HotfixEnum.attributeFinialLimitType.FINAL_ELEMENTTYPE_DAMAGETYPE_SUPPRESS, fromActor, ref attributeSetValue2);
		FDP fDP5 = toER * (FDP.One - fromEI) - fromEP;
		hudColorIndex = 2;
		FDP zero = FDP.Zero;
		if (fDP5 > FDP.Zero)
		{
			GetResistanceLimits((FP)fDP5, out var valueUpperLimit, out var valueLowerLimit, out var amendUpperLimit, out var amendLowerLimit, out hudColorIndex);
			FDP fDP6 = (fDP5 - valueLowerLimit) / ((FDP)valueUpperLimit - (FDP)valueLowerLimit);
			zero = amendLowerLimit + ((FDP)amendUpperLimit - (FDP)amendLowerLimit) * (fDP6 * fDP6);
			FP fP = GetHighResistanceAmendUpperLimit();
			if (zero > fP)
			{
				zero = fP;
				hudColorIndex = 5;
			}
			zero = FDP.One - zero;
		}
		else
		{
			zero = FDP.One + attributeSetValue2 * ModuleController<AdventureModuleController>.Instance.BaseSuppress + attributeSetValue2 * fDP5 * (FDP)(-0.01) * ModuleController<AdventureModuleController>.Instance.DynamicSuppress;
		}
		if (hitDamageElementType == HotfixEnum.elementType.NONE)
		{
			fromEE = FDP.One;
			zero = FDP.One;
			toEERCD = FDP.One;
		}
		erAmend = zero;
		toughnessBrokenDmgRatio = toAdditionalAttrInfo.toughnessBrokenDmgRatio;
		envAmendRatio = toAdditionalAttrInfo.envAmendRatio;
		FDP fDP7 = zero * fDP3 * rcdSlotDmgRatio * toEERCD * toAdditionalAttrInfo.genDmgRcdRatio * toughnessBrokenDmgRatio * envAmendRatio;
		FDP fDP8 = FDP.One;
		if (hitDamageConfig.LevelTypeData == 1 && hitDamageConfig.PerkIntensity.Count > 0)
		{
			int index = Mathf.Clamp(skillLevel, 0, hitDamageConfig.PerkIntensity.Count - 1);
			fDP8 = FDP.FromMyriad(hitDamageConfig.PerkIntensity.get_Item(index)) * fromAdditionalAttrInfo.intensityRatio;
		}
		perkIntensityRatio = fDP8;
		FDP fDP9 = FDP.One;
		if (!isDot & isCrit)
		{
			fDP9 = fromAdditionalAttrInfo.critPower + attributeSetValue;
		}
		critRatio = fDP9;
		FDP one = FDP.One;
		if (fromActor is PlayerAdventureActor)
		{
			one += fromAdditionalAttrInfo.skillIntensityRatio;
		}
		skillIntensityRatio = one;
		return math.clamp((((y * one * fDP8 * slotDmgRatio * fromEE * fromAdditionalAttrInfo.genDmgRatio + fromAdditionalAttrInfo.dmgPlus) * fDP9 * fDP7 + toAdditionalAttrInfo.dmgPlusRcd) * fromAdditionalAttrInfo.finalDmgRatio + fromAdditionalAttrInfo.finalDmgPlus).AsLong(), 1L, long.MaxValue);
	}

	public static HotfixEnum.elementType GetHitDamageElementType(HitDamage hitDamageConfig, AdventureActor fromActor)
	{
		HotfixEnum.elementType elementType = (HotfixEnum.elementType)hitDamageConfig.ElementType;
		if (elementType == HotfixEnum.elementType.INHERIT && (fromActor is FakeAdventureActor || fromActor is MonsterAdventureActor || fromActor is TrapAdventureActor || fromActor is MonsterCloneAdventureActor || (fromActor != null && fromActor.UseInheritElementOnHit)))
		{
			elementType = fromActor.actorElementInfo.elementType;
		}
		return elementType;
	}

	public static int ConvertAttributeTypeAndElementTypeToKey(HotfixEnum.effectAttributeType attributeType, HotfixEnum.elementType elementType, bool isBaseValue = true, bool isAssignValue = false)
	{
		return ConvertAttributeTypeAndElementOrDamageTypeToKey((int)attributeType, (int)elementType, isElementType: true, isBaseValue, isAssignValue);
	}

	public static int ConvertAttributeTypeAndDamageTypeToKey(HotfixEnum.effectAttributeType attributeType, HotfixEnum.damageType damageType, bool isBaseValue = true, bool isAssignValue = false)
	{
		return ConvertAttributeTypeAndElementOrDamageTypeToKey((int)attributeType, (int)damageType, isElementType: false, isBaseValue, isAssignValue);
	}

	public static int ConvertAttributeTypeAndElementOrDamageTypeToKey(int attributeType, int elementOrDamageType, bool isElementType, bool isBaseValue, bool isAssignValue)
	{
		int num = (isElementType ? 1 : 0) << 24;
		int num2 = (attributeType & 0xFF) << 16;
		int num3 = (elementOrDamageType & 0xFF) << 8;
		int num4 = ((!isBaseValue) ? (isAssignValue ? 1 : 2) : 0);
		return num | num2 | num3 | num4;
	}

	public static void ConvertKeyToAttributeTypeAndElementOrDamageType(int key, out int attributeType, out int elementOrDamageType, out bool isElementType, out bool isBaseValue, out bool isAssignValue, out bool isPercentValue)
	{
		isElementType = ((key >> 24) & 0xFF) == 1;
		attributeType = (key >> 16) & 0xFF;
		elementOrDamageType = (key >> 8) & 0xFF;
		int num = key & 0xFF;
		isBaseValue = num == 0;
		isAssignValue = num == 1;
		isPercentValue = num == 2;
	}

	private static AttributeSetLimitInfo GetLimit(HotfixEnum.attributeFinialLimitType type)
	{
		if (type == HotfixEnum.attributeFinialLimitType.MAX)
		{
			return null;
		}
		AttributeSetLimitInfo attributeSetLimitInfo = limits[(int)type];
		if (attributeSetLimitInfo != null)
		{
			return attributeSetLimitInfo;
		}
		AttributeSetLimit attributeSetLimit = Singleton<HotfixDataController>.Instance.GetAttributeSetLimit((int)type);
		attributeSetLimitInfo = ((attributeSetLimit != null && attributeSetLimit.IsLimited) ? new AttributeSetLimitInfo(attributeSetLimit.IsLimited, FDP.FromMyriad(attributeSetLimit.Lower), FDP.FromMyriad(attributeSetLimit.Upper), attributeSetLimit.IsPlayer) : new AttributeSetLimitInfo());
		limits[(int)type] = attributeSetLimitInfo;
		return attributeSetLimitInfo;
	}

	public static void ClampAttributeSetWithLimit(HotfixEnum.attributeFinialLimitType limitType, AdventureActor actor, ref FDP attributeSetValue)
	{
		AttributeSetLimitInfo limit = GetLimit(limitType);
		if (limit == null || !limit.IsLimited)
		{
			return;
		}
		if (limit.OnlyLimitPlayer)
		{
			if (actor is PlayerAdventureActor)
			{
				attributeSetValue = FDP.Clamp(attributeSetValue, limit.Lower, limit.Upper);
			}
		}
		else
		{
			attributeSetValue = FDP.Clamp(attributeSetValue, limit.Lower, limit.Upper);
		}
	}

	public static HotfixEnum.skillSlotType GetSkillSlotType(SkillPhaseFeatureFlag skillCastBehaviourType)
	{
		HotfixEnum.skillSlotType result = HotfixEnum.skillSlotType.NONE;
		if ((skillCastBehaviourType & SkillPhaseFeatureFlag.Normal) != 0)
		{
			result = HotfixEnum.skillSlotType.NORMAL;
		}
		else if ((skillCastBehaviourType & SkillPhaseFeatureFlag.Skill1) != 0)
		{
			result = HotfixEnum.skillSlotType.B;
		}
		else if ((skillCastBehaviourType & SkillPhaseFeatureFlag.Skill2) != 0)
		{
			result = HotfixEnum.skillSlotType.C;
		}
		else if ((skillCastBehaviourType & SkillPhaseFeatureFlag.Ultimate) != 0)
		{
			result = HotfixEnum.skillSlotType.D;
		}
		else if ((skillCastBehaviourType & SkillPhaseFeatureFlag.Dodge) != 0)
		{
			result = HotfixEnum.skillSlotType.A;
		}
		return result;
	}
}
