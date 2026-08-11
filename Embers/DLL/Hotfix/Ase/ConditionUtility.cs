using System;
using Ase.ECS;

namespace Ase;

public class ConditionUtility
{
	public static bool CompareTargetInTeamType(BaseEntity subject, EntityTeamType teamType)
	{
		switch (teamType)
		{
		case EntityTeamType.Self:
		case EntityTeamType.Creator:
			return true;
		case EntityTeamType.Monster:
			return subject is MonsterEntity;
		case EntityTeamType.Ally:
			return false;
		case EntityTeamType.Hero:
			return subject is HeroEntity;
		case EntityTeamType.Boss:
			if (subject is MonsterEntity monsterEntity)
			{
				return monsterEntity.IsBoss;
			}
			break;
		case EntityTeamType.Bandit:
			if (subject is MonsterEntity monsterEntity2)
			{
				return !monsterEntity2.IsBoss;
			}
			break;
		case EntityTeamType.Any:
			return true;
		case EntityTeamType.Actor:
			if (subject is HeroEntity heroEntity2)
			{
				return heroEntity2.IsActorEntity;
			}
			return false;
		case EntityTeamType.AI:
			if (subject is HeroEntity heroEntity)
			{
				return heroEntity.IsAi;
			}
			return false;
		}
		return false;
	}

	[Obsolete]
	public static bool CompareTargetInTeamType(BaseEntity subject, BaseEntity from, EntityTeamType teamType)
	{
		switch (teamType)
		{
		case EntityTeamType.Self:
		case EntityTeamType.Creator:
			return subject == from;
		case EntityTeamType.Monster:
			return from is MonsterEntity;
		case EntityTeamType.Ally:
			if (subject != from)
			{
				return from is HeroEntity;
			}
			return false;
		case EntityTeamType.Hero:
			return from is HeroEntity;
		case EntityTeamType.Boss:
			if (from is MonsterEntity monsterEntity2)
			{
				return monsterEntity2.IsBoss;
			}
			break;
		case EntityTeamType.Bandit:
			if (from is MonsterEntity monsterEntity)
			{
				return !monsterEntity.IsBoss;
			}
			break;
		case EntityTeamType.Any:
			return true;
		}
		return false;
	}

	public static bool CompareTargetInTeamType(BaseEntity subject, BaseEntity from, BaseEntity to, EntityTeamType teamType)
	{
		switch (teamType)
		{
		case EntityTeamType.Self:
			return subject == to;
		case EntityTeamType.Creator:
			return subject == from;
		case EntityTeamType.Monster:
			return subject is MonsterEntity;
		case EntityTeamType.Ally:
			if (subject != to)
			{
				return subject is HeroEntity;
			}
			return false;
		case EntityTeamType.Hero:
			return subject is HeroEntity;
		case EntityTeamType.Boss:
			if (subject is MonsterEntity monsterEntity2)
			{
				return monsterEntity2.IsBoss;
			}
			break;
		case EntityTeamType.Bandit:
			if (subject is MonsterEntity monsterEntity)
			{
				return !monsterEntity.IsBoss;
			}
			break;
		case EntityTeamType.Any:
			return true;
		case EntityTeamType.Actor:
			if (subject is HeroEntity heroEntity2)
			{
				return heroEntity2.IsActorEntity;
			}
			return false;
		case EntityTeamType.AI:
			if (subject is HeroEntity heroEntity)
			{
				return heroEntity.IsAi;
			}
			return false;
		}
		return false;
	}

	public static bool ConditionRelationTypeEnum(RelationTypeEnum relation, string str)
	{
		RelationTypeEnum orDefault = EnumCache<RelationTypeEnum>.GetOrDefault(str, RelationTypeEnum.Unknown);
		if (orDefault != RelationTypeEnum.Unknown)
		{
			return orDefault == relation;
		}
		return true;
	}

	public static bool ConditionSkillExecuteStateEnum(SkillExecuteState skillExecuteState, string str)
	{
		return EnumCache<SkillExecuteState>.GetOrDefault(str, SkillExecuteState.None) == skillExecuteState;
	}

	public static bool ConditionHeroSkillTypeEnum(HeroSkillTypeEnum heroSkillTypeEnum, string str)
	{
		return EnumCache<HeroSkillTypeEnum>.GetOrDefault(str, HeroSkillTypeEnum.None) == heroSkillTypeEnum;
	}

	public static bool ConditionCompareMethodTypeEnum(CompareMethodType methodType, string str)
	{
		return false;
	}

	public static bool ConditionNumericalValueTypeEnum(NumericalValueType valueType, string str)
	{
		return false;
	}
}
