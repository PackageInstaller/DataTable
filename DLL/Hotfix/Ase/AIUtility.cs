using System.Collections.Generic;
using System.Runtime.InteropServices;
using Ase.ECS;

namespace Ase;

public static class AIUtility
{
	[StructLayout(LayoutKind.Auto)]
	private struct CampPair(CampType first, CampType second)
	{
		private readonly CampType m_First = first;

		private readonly CampType m_Second = second;

		public CampType First => m_First;

		public CampType Second => m_Second;
	}

	private static Dictionary<uint, RelationTypeEnum> s_CampPairToRelation;

	private static Dictionary<KeyValuePair<CampType, RelationTypeEnum>, CampType[]> s_CampAndRelationToCamps;

	private static uint GetCampPairMask(CampType first, CampType second)
	{
		return (uint)((1 << (int)first) | (1 << (int)second));
	}

	static AIUtility()
	{
		s_CampPairToRelation = new Dictionary<uint, RelationTypeEnum>();
		s_CampAndRelationToCamps = new Dictionary<KeyValuePair<CampType, RelationTypeEnum>, CampType[]>();
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Player, CampType.Player), RelationTypeEnum.Friendly);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Player, CampType.Monster), RelationTypeEnum.Hostile);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Player, CampType.Neutral), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Player, CampType.HostileMonster), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Player, CampType.HostilePlayer), RelationTypeEnum.Hostile);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Player, CampType.Evil), RelationTypeEnum.Hostile);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Monster, CampType.Player), RelationTypeEnum.Hostile);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Monster, CampType.Monster), RelationTypeEnum.Friendly);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Monster, CampType.Neutral), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Monster, CampType.HostileMonster), RelationTypeEnum.Hostile);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Monster, CampType.HostilePlayer), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Monster, CampType.Evil), RelationTypeEnum.Hostile);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Neutral, CampType.Player), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Neutral, CampType.Monster), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Neutral, CampType.Neutral), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Neutral, CampType.HostileMonster), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Neutral, CampType.HostilePlayer), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Neutral, CampType.Evil), RelationTypeEnum.Hostile);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.HostileMonster, CampType.Player), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.HostileMonster, CampType.Monster), RelationTypeEnum.Hostile);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.HostileMonster, CampType.Neutral), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.HostileMonster, CampType.HostileMonster), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.HostileMonster, CampType.HostilePlayer), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.HostileMonster, CampType.Evil), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.HostilePlayer, CampType.Player), RelationTypeEnum.Hostile);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.HostilePlayer, CampType.Monster), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.HostilePlayer, CampType.Neutral), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.HostilePlayer, CampType.HostileMonster), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.HostilePlayer, CampType.HostilePlayer), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.HostilePlayer, CampType.Evil), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Evil, CampType.Player), RelationTypeEnum.Hostile);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Evil, CampType.Monster), RelationTypeEnum.Hostile);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Evil, CampType.Neutral), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Evil, CampType.HostileMonster), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Evil, CampType.HostilePlayer), RelationTypeEnum.Neutral);
		s_CampPairToRelation.TryAdd(GetCampPairMask(CampType.Evil, CampType.Evil), RelationTypeEnum.Neutral);
	}

	public static RelationTypeEnum GetRelation(CampType first, CampType second)
	{
		CampType num = first;
		uint num2 = (uint)second;
		if ((uint)num > num2)
		{
			CampType num3 = second;
			CampType campType = first;
			first = num3;
			second = campType;
		}
		if (s_CampPairToRelation.TryGetValue(GetCampPairMask(first, second), out var value))
		{
			return value;
		}
		return RelationTypeEnum.Unknown;
	}

	public static RelationTypeEnum GetRelation(BaseEntity firstEntity, BaseEntity secondEntity)
	{
		CampType campType = firstEntity.GetEntityCampType();
		CampType campType2 = secondEntity.GetEntityCampType();
		CampType num = campType;
		uint num2 = (uint)campType2;
		if ((uint)num > num2)
		{
			CampType num3 = campType2;
			CampType campType3 = campType;
			campType = num3;
			campType2 = campType3;
		}
		if (firstEntity.Id == secondEntity.Id)
		{
			return RelationTypeEnum.Self;
		}
		if (s_CampPairToRelation.TryGetValue(GetCampPairMask(campType, campType2), out var value))
		{
			return value;
		}
		return RelationTypeEnum.Unknown;
	}
}
