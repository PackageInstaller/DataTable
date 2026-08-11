using System;
using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using Sirenix.OdinInspector;
using UnityEngine.Pool;

namespace Ase;

public static class BuffExtension
{
	public static void AnalysisBuffOperations(List<List<string>> operations, in List<IBuffOperation> list)
	{
		if (operations.IsNullOrEmpty())
		{
			return;
		}
		foreach (List<string> operation in operations)
		{
			IBuffOperation buffOperation = AnalysisBuffOperation(operation);
			if (buffOperation != null)
			{
				list.Add(buffOperation);
			}
		}
	}

	public static IBuffOperation AnalysisBuffOperation(List<string> operationList)
	{
		if (operationList.IsNullOrEmpty())
		{
			return null;
		}
		BuffOperationType effectType = ConvertEnumType<BuffOperationType>(operationList[0]);
		IBuffOperation buffOperation = BuffSystem.GetBuffOperation(effectType);
		if (buffOperation == null)
		{
			return null;
		}
		List<string> list = new List<string>();
		for (int i = 1; i < operationList.Count; i++)
		{
			list.Add(operationList[i]);
		}
		buffOperation.Create(effectType, list);
		return buffOperation;
	}

	public static IBuffOperation AnalysisBuffOperation(BuffOperationType operationType)
	{
		IBuffOperation buffOperation = BuffSystem.GetBuffOperation(operationType);
		if (buffOperation == null)
		{
			return null;
		}
		buffOperation.Create(operationType, null);
		return buffOperation;
	}

	public static T ConvertEnumType<T>(string value) where T : Enum
	{
		return (T)Enum.Parse(typeof(T), value);
	}

	public static ConditionList<BuffConditionBase> GenerateBuffConditions(BaseEntity unitFrom, BaseEntity unitTarget, ConditionList<List<string>> conditionLists)
	{
		ConditionList<BuffConditionBase> conditionList = ConditionListPool<BuffConditionBase>.Get();
		List<string> list = CollectionPool<List<string>, string>.Get();
		foreach (List<string> conditionList2 in conditionLists)
		{
			if (conditionList2 != null && conditionList2.Count >= 1)
			{
				BuffConditionType conditionType = ConvertEnumType<BuffConditionType>(conditionList2[0]);
				for (int i = 1; i < conditionList2.Count; i++)
				{
					list.Add(conditionList2[i]);
				}
				BuffConditionBase buffConditionBase = BuffConditionBase.Create(unitFrom, unitTarget, conditionType, list);
				list.Clear();
				if (buffConditionBase == null)
				{
					CollectionPool<List<string>, string>.Release(list);
					return null;
				}
				conditionList.Add(buffConditionBase);
			}
		}
		conditionList.conditionEnum = conditionLists.conditionEnum;
		CollectionPool<List<string>, string>.Release(list);
		return conditionList;
	}

	private static int ParseConditionString(string content, List<string[]> listData)
	{
		if (string.IsNullOrEmpty(content))
		{
			return 1;
		}
		int num = 1;
		for (int i = 0; i < content.Length; i++)
		{
			if ('|'.Equals(content[i]))
			{
				num = 0;
				break;
			}
			if ('&'.Equals(content[i]))
			{
				break;
			}
		}
		string[] array = ((num != 1) ? content.Split('|') : content.Split('&'));
		for (int j = 0; j < array.Length; j++)
		{
			listData.Add(array[j].Split(','));
		}
		return num;
	}

	public static string GetConditionsType(int type)
	{
		return type switch
		{
			0 => "|", 
			1 => "&", 
			_ => string.Empty, 
		};
	}

	public static int ParseConditionsType(string typeStr)
	{
		if (string.IsNullOrEmpty(typeStr))
		{
			return 0;
		}
		if (typeStr == "|")
		{
			return 0;
		}
		if (typeStr == "&")
		{
			return 1;
		}
		return 0;
	}

	public static string GetCompareMethodString(this CompareMethodType checkType)
	{
		return checkType switch
		{
			CompareMethodType.Equal => "=", 
			CompareMethodType.Greater => ">", 
			CompareMethodType.Less => "<", 
			CompareMethodType.GOrE => ">=", 
			CompareMethodType.LOrE => "<=", 
			CompareMethodType.NoEqual => "!=", 
			_ => "", 
		};
	}

	public static string GetCompareString(this NumericalValueType compareValueType, float compareValue)
	{
		return $"{compareValue * 100f:F2}" + ((compareValueType == NumericalValueType.Percentage) ? "%" : "");
	}

	public static List<Buff> FindTargetBuffByTeamType(BaseEntity from, BaseEntity owner, EntityTeamType teamType, int buffId, List<BaseEntity> damageList = null)
	{
		BuffSystem system = owner.GetSystem<BuffSystem>();
		if (system == null)
		{
			return null;
		}
		List<Buff> list = CollectionPool<List<Buff>, Buff>.Get();
		switch (teamType)
		{
		case EntityTeamType.Self:
		{
			Buff buff2 = system.FindEntityBuff(owner.Id, buffId);
			if (buff2 != null)
			{
				list.Add(buff2);
			}
			break;
		}
		case EntityTeamType.Creator:
		{
			Buff buff9 = system.FindEntityBuff(from.Id, buffId);
			if (buff9 != null)
			{
				list.Add(buff9);
			}
			break;
		}
		case EntityTeamType.Monster:
			foreach (BaseEntity item in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item.IsSurvival && item.GetEntityType() == EntityType.MONSTER)
				{
					Buff buff8 = system.FindEntityBuff(item.Id, buffId);
					if (buff8 != null)
					{
						list.Add(buff8);
					}
				}
			}
			break;
		case EntityTeamType.Ally:
			foreach (BaseEntity item2 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (owner.EntityId != item2.EntityId && item2.IsSurvival && item2.GetEntityType() == owner.GetEntityType())
				{
					Buff buff7 = system.FindEntityBuff(item2.Id, buffId);
					if (buff7 != null)
					{
						list.Add(buff7);
					}
				}
			}
			break;
		case EntityTeamType.Hero:
			foreach (BaseEntity item3 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item3.IsSurvival && item3.GetEntityType() == EntityType.HERO)
				{
					Buff buff6 = system.FindEntityBuff(item3.Id, buffId);
					if (buff6 != null)
					{
						list.Add(buff6);
					}
				}
			}
			break;
		case EntityTeamType.Boss:
			foreach (BaseEntity item4 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item4.IsSurvival && item4 is MonsterEntity { IsBoss: not false } monsterEntity2)
				{
					Buff buff5 = monsterEntity2.GetSystem<BuffSystem>()?.FindEntityBuff(monsterEntity2.Id, buffId);
					if (buff5 != null)
					{
						list.Add(buff5);
					}
				}
			}
			break;
		case EntityTeamType.Bandit:
			foreach (BaseEntity item5 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item5.IsSurvival && item5 is MonsterEntity { IsBoss: false } monsterEntity)
				{
					Buff buff4 = system.FindEntityBuff(monsterEntity.Id, buffId);
					if (buff4 != null)
					{
						list.Add(buff4);
					}
				}
			}
			break;
		case EntityTeamType.Any:
			foreach (BaseEntity item6 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item6.IsSurvival)
				{
					Buff buff3 = system.FindEntityBuff(item6.Id, buffId);
					if (buff3 != null)
					{
						list.Add(buff3);
					}
				}
			}
			break;
		case EntityTeamType.DamageTarget:
			if (damageList == null)
			{
				break;
			}
			foreach (BaseEntity damage in damageList)
			{
				if (damage.IsSurvival)
				{
					Buff buff = system.FindEntityBuff(damage.Id, buffId);
					if (buff != null)
					{
						list.Add(buff);
					}
				}
			}
			break;
		}
		return list;
	}

	public static List<BaseEntity> GetTargetByTeamTypeList(BaseEntity from, BaseEntity owner, EntityTeamType teamType, List<BaseEntity> damageList = null, bool isCreateNewList = true)
	{
		if (from == null || owner == null)
		{
			return null;
		}
		List<BaseEntity> list = (isCreateNewList ? new List<BaseEntity>() : CollectionPool<List<BaseEntity>, BaseEntity>.Get());
		switch (teamType)
		{
		case EntityTeamType.Self:
			list.Add(owner);
			return list;
		case EntityTeamType.Creator:
			list.Add(from);
			return list;
		case EntityTeamType.Monster:
		{
			foreach (BaseEntity item in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item.IsSurvival && item.GetEntityType() == EntityType.MONSTER)
				{
					list.Add(item);
				}
			}
			return list;
		}
		case EntityTeamType.Ally:
		{
			foreach (BaseEntity item2 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (owner.EntityId != item2.EntityId && item2.IsSurvival && item2.GetEntityType() == owner.GetEntityType())
				{
					list.Add(item2);
				}
			}
			return list;
		}
		case EntityTeamType.Hero:
		{
			foreach (BaseEntity item3 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item3.IsSurvival && item3.GetEntityType() == EntityType.HERO)
				{
					list.Add(item3);
				}
			}
			return list;
		}
		case EntityTeamType.Boss:
		{
			foreach (BaseEntity item4 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item4.IsSurvival && item4 is MonsterEntity { IsBoss: not false } monsterEntity2)
				{
					list.Add(monsterEntity2);
				}
			}
			return list;
		}
		case EntityTeamType.Bandit:
		{
			foreach (BaseEntity item5 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item5.IsSurvival && item5 is MonsterEntity { IsBoss: false } monsterEntity)
				{
					list.Add(monsterEntity);
				}
			}
			return list;
		}
		case EntityTeamType.Any:
		{
			foreach (BaseEntity item6 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item6.IsSurvival)
				{
					list.Add(item6);
				}
			}
			return list;
		}
		case EntityTeamType.DamageTarget:
			if (damageList == null)
			{
				return list;
			}
			list.AddRange(damageList);
			return list;
		case EntityTeamType.Parent:
			if (owner.Parent != null)
			{
				list.Add(owner.Parent);
			}
			return list;
		case EntityTeamType.Actor:
		{
			HeroEntity heroEntity = null;
			if (heroEntity != null)
			{
				list.Add(heroEntity);
			}
			break;
		}
		case EntityTeamType.AI:
		{
			List<HeroEntity> list2 = owner.GetSystem<EntitySystem>()?.GetAIHeroList();
			if (list2 != null && list2.Count > 0)
			{
				list.AddRange(list2);
			}
			break;
		}
		}
		return list;
	}

	public static BaseEntity GetTargetByTeamType(BaseEntity from, BaseEntity owner, EntityTeamType teamType, BaseEntity damageEntity = null)
	{
		if (from == null || owner == null)
		{
			return null;
		}
		switch (teamType)
		{
		case EntityTeamType.Self:
			return owner;
		case EntityTeamType.Creator:
			return from;
		case EntityTeamType.Monster:
			foreach (BaseEntity item in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item.IsSurvival && item.GetEntityType() == EntityType.MONSTER)
				{
					return item;
				}
			}
			break;
		case EntityTeamType.Ally:
			foreach (BaseEntity item2 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (owner.EntityId != item2.EntityId && item2.IsSurvival && item2.GetEntityType() == owner.GetEntityType())
				{
					return item2;
				}
			}
			break;
		case EntityTeamType.Hero:
			foreach (BaseEntity item3 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item3.IsSurvival && item3.GetEntityType() == EntityType.HERO)
				{
					return item3;
				}
			}
			break;
		case EntityTeamType.Boss:
			foreach (BaseEntity item4 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item4.IsSurvival && item4 is MonsterEntity { IsBoss: not false })
				{
					return item4;
				}
			}
			break;
		case EntityTeamType.Bandit:
			foreach (BaseEntity item5 in owner.GetSystem<EntitySystem>().GetAllEntity())
			{
				if (item5.IsSurvival && item5 is MonsterEntity { IsBoss: false })
				{
					return item5;
				}
			}
			break;
		case EntityTeamType.DamageTarget:
			return damageEntity;
		case EntityTeamType.Parent:
			if (owner.Parent != null)
			{
				return owner.Parent;
			}
			break;
		case EntityTeamType.Actor:
			return null;
		case EntityTeamType.AI:
		{
			List<HeroEntity> list = owner.GetSystem<EntitySystem>()?.GetAIHeroList();
			if (list != null && list.Count > 0)
			{
				return list[0];
			}
			break;
		}
		}
		return null;
	}

	public static BaseEntity GetConditonRuntimeTarget(BuffRuntimeEnum runtimeEnum, Buff buff, BuffRuntimeDataBase runtimeData)
	{
		return runtimeEnum switch
		{
			BuffRuntimeEnum.ToEntity => runtimeData?.ToEntity, 
			BuffRuntimeEnum.Creator => buff?.BuffFrom, 
			BuffRuntimeEnum.Self => buff?.BuffOwner, 
			_ => null, 
		};
	}

	public static bool GetAddConditions<T>(this Buff buff, in List<T> outAddConditions) where T : BuffConditionBase
	{
		if (buff == null)
		{
			return false;
		}
		List<BuffConditionBase> addConditions = buff.GetAddConditions();
		if (addConditions == null || addConditions.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < addConditions.Count; i++)
		{
			if (addConditions[i] is T)
			{
				outAddConditions.Add(addConditions[i] as T);
			}
		}
		return true;
	}

	public static float GetModifyDelta(ChangeType changeType, NumberType numType, float origin, float modify)
	{
		modify = ((numType == NumberType.Factor) ? (origin * modify) : modify);
		return changeType switch
		{
			ChangeType.Set => modify - origin, 
			ChangeType.Add => modify, 
			ChangeType.Dec => 0f - modify, 
			ChangeType.Mul => modify * origin - origin, 
			ChangeType.Div => modify / origin - origin, 
			_ => 0f, 
		};
	}

	public static string GetEnumLabelText(this Enum val)
	{
		Attribute customAttribute = Attribute.GetCustomAttribute(val.GetType().GetField(val.ToString()), typeof(LabelTextAttribute));
		if (customAttribute != null)
		{
			return ((LabelTextAttribute)customAttribute).Text;
		}
		return val.ToString();
	}
}
