using System;
using System.Collections.Generic;
using UnityEngine;

[Serializable]
public class TargetFilterCriteriaInfo
{
	[Serializable]
	public class TargetFilterCriteria
	{
		public TargetTypeMapping targetType;

		public ElementTypeMapping elementType;

		public MonsterEpicTypeMapping monsterEpicType;

		[Space]
		public OperationType operationType;

		public TargetFilterCriteria()
		{
			targetType = TargetTypeMapping.Enemy;
			elementType = ElementTypeMapping.All;
			monsterEpicType = MonsterEpicTypeMapping.All;
			operationType = OperationType.And;
		}
	}

	[Flags]
	public enum TargetTypeMapping
	{
		Owner = 2,
		Teammate = 4,
		Friend = 8,
		Enemy = 0x10,
		Both = 0x20,
		OwnerSummoned = 0x40,
		TeammateSummoned = 0x80,
		FriendSummoned = 0x100,
		EnemySummoned = 0x200,
		BothSummoned = 0x400,
		MainPlayerActor = 0x800,
		AssitPlayerActor = 0x1000,
		TeammateWithoutSummoned = 0x2000,
		TeammateWithoutNotMinionSummoned = 0x4000,
		FriendWithoutSummoned = 0x8000,
		None = 0,
		All = Owner | Teammate | Friend | Enemy | Both | OwnerSummoned | TeammateSummoned | FriendSummoned | EnemySummoned | BothSummoned | MainPlayerActor | AssitPlayerActor | TeammateWithoutSummoned | TeammateWithoutNotMinionSummoned | FriendWithoutSummoned
	}

	[Flags]
	public enum ElementTypeMapping
	{
		WE = 2,
		FE = 4,
		SE = 8,
		AE = 0x10,
		LE = 0x20,
		DE = 0x40,
		NONE = 0x80,
		None = 0,
		All = WE | FE | SE | AE | LE | DE | NONE
	}

	[Flags]
	public enum MonsterEpicTypeMapping
	{
		NORMAL = 2,
		ELITE = 4,
		LEADER = 8,
		LORD = 0x10,
		None = 0,
		All = NORMAL | ELITE | LEADER | LORD
	}

	public enum OperationType
	{
		And,
		Or
	}

	public static readonly Dictionary<TargetTypeMapping, TargetType> TargetTypeCorrespondenceDic = new Dictionary<TargetTypeMapping, TargetType>
	{
		[TargetTypeMapping.Owner] = TargetType.Owner,
		[TargetTypeMapping.Teammate] = TargetType.Teammate,
		[TargetTypeMapping.Friend] = TargetType.Friend,
		[TargetTypeMapping.Enemy] = TargetType.Enemy,
		[TargetTypeMapping.Both] = TargetType.Both,
		[TargetTypeMapping.OwnerSummoned] = TargetType.OwnerSummoned,
		[TargetTypeMapping.TeammateSummoned] = TargetType.TeammateSummoned,
		[TargetTypeMapping.FriendSummoned] = TargetType.FriendSummoned,
		[TargetTypeMapping.EnemySummoned] = TargetType.EnemySummoned,
		[TargetTypeMapping.BothSummoned] = TargetType.BothSummoned,
		[TargetTypeMapping.MainPlayerActor] = TargetType.MainPlayerActor,
		[TargetTypeMapping.AssitPlayerActor] = TargetType.AssitPlayerActor,
		[TargetTypeMapping.TeammateWithoutSummoned] = TargetType.TeammateWithoutSummoned,
		[TargetTypeMapping.TeammateWithoutNotMinionSummoned] = TargetType.TeammateWithoutNotMinionSummoned,
		[TargetTypeMapping.FriendWithoutSummoned] = TargetType.FriendWithoutSummoned
	};

	public static readonly Dictionary<ElementTypeMapping, HotfixEnum.elementType> ElementTypeCorrespondenceDic = new Dictionary<ElementTypeMapping, HotfixEnum.elementType>
	{
		[ElementTypeMapping.WE] = HotfixEnum.elementType.WE,
		[ElementTypeMapping.FE] = HotfixEnum.elementType.FE,
		[ElementTypeMapping.SE] = HotfixEnum.elementType.SE,
		[ElementTypeMapping.AE] = HotfixEnum.elementType.AE,
		[ElementTypeMapping.LE] = HotfixEnum.elementType.LE,
		[ElementTypeMapping.DE] = HotfixEnum.elementType.DE,
		[ElementTypeMapping.NONE] = HotfixEnum.elementType.NONE
	};

	public static readonly Dictionary<MonsterEpicTypeMapping, HotfixEnum.monsterEpicType> MonsterEpicTypeCorrespondenceDic = new Dictionary<MonsterEpicTypeMapping, HotfixEnum.monsterEpicType>
	{
		[MonsterEpicTypeMapping.NORMAL] = HotfixEnum.monsterEpicType.NORMAL,
		[MonsterEpicTypeMapping.ELITE] = HotfixEnum.monsterEpicType.ELITE,
		[MonsterEpicTypeMapping.LEADER] = HotfixEnum.monsterEpicType.LEADER,
		[MonsterEpicTypeMapping.LORD] = HotfixEnum.monsterEpicType.LORD
	};

	public List<TargetFilterCriteria> filterCriteriaList;

	[Space]
	public OperationType operationType;

	public bool CheckFilterCriteria(LogicEntity self, LogicEntity target)
	{
		if (self == null || target == null)
		{
			return false;
		}
		if (filterCriteriaList == null || filterCriteriaList.Count <= 0)
		{
			return true;
		}
		for (int i = 0; i < filterCriteriaList.Count; i++)
		{
			TargetFilterCriteria targetFilterCriteria = filterCriteriaList.get_Item(i);
			bool flag = Operation(CheckTargetType(self, target, targetFilterCriteria.targetType), CheckElementType(target, targetFilterCriteria.elementType), targetFilterCriteria.operationType);
			if (target is MonsterAdventureActor monster)
			{
				flag = Operation(flag, CheckMonsterType(monster, targetFilterCriteria.monsterEpicType), targetFilterCriteria.operationType);
			}
			if (operationType == OperationType.And && !flag)
			{
				return false;
			}
			if (operationType == OperationType.Or && flag)
			{
				return true;
			}
		}
		return operationType == OperationType.And;
	}

	private static bool Operation(bool resultA, bool resultB, OperationType operationType)
	{
		if (operationType == OperationType.And)
		{
			return resultA & resultB;
		}
		return resultA | resultB;
	}

	private static bool CheckTargetType(LogicEntity A, LogicEntity B, TargetTypeMapping targetTypeMapping)
	{
		switch (targetTypeMapping)
		{
		case TargetTypeMapping.None:
			return false;
		case TargetTypeMapping.All:
			return true;
		default:
			foreach (KeyValuePair<TargetTypeMapping, TargetType> item in TargetTypeCorrespondenceDic)
			{
				TargetTypeMapping key = item.Key;
				TargetType value = item.Value;
				if (targetTypeMapping.HasFlag(key) && A.CheckTarget(B, value))
				{
					return true;
				}
			}
			return false;
		}
	}

	private static bool CheckElementType(LogicEntity target, ElementTypeMapping elementTypeMapping)
	{
		switch (elementTypeMapping)
		{
		case ElementTypeMapping.None:
			return false;
		case ElementTypeMapping.All:
			return true;
		default:
			if (target is AdventureActor adventureActor)
			{
				foreach (KeyValuePair<ElementTypeMapping, HotfixEnum.elementType> item in ElementTypeCorrespondenceDic)
				{
					ElementTypeMapping key = item.Key;
					HotfixEnum.elementType value = item.Value;
					if (elementTypeMapping.HasFlag(key) && adventureActor.actorElementInfo.elementType == value)
					{
						return true;
					}
				}
			}
			return false;
		}
	}

	private static bool CheckMonsterType(MonsterAdventureActor monster, MonsterEpicTypeMapping monsterEpicTypeMapping)
	{
		switch (monsterEpicTypeMapping)
		{
		case MonsterEpicTypeMapping.None:
			return false;
		case MonsterEpicTypeMapping.All:
			return true;
		default:
			foreach (KeyValuePair<MonsterEpicTypeMapping, HotfixEnum.monsterEpicType> item in MonsterEpicTypeCorrespondenceDic)
			{
				MonsterEpicTypeMapping key = item.Key;
				HotfixEnum.monsterEpicType value = item.Value;
				if (!monsterEpicTypeMapping.HasFlag(key))
				{
					continue;
				}
				switch (key)
				{
				case MonsterEpicTypeMapping.NORMAL:
				case MonsterEpicTypeMapping.ELITE:
				case MonsterEpicTypeMapping.LEADER:
					if (monster.monsterInfo.epicType == value)
					{
						return true;
					}
					break;
				case MonsterEpicTypeMapping.LORD:
					if (monster.IsBossMonster())
					{
						return true;
					}
					break;
				}
			}
			return false;
		}
	}
}
