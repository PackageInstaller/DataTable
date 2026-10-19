using ACT.Battle;
using ACT.Battle.Configs;
using ACT.World;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.MissionSystem;

internal sealed class MonsterEntityMissionPoint : MissionPointData
{
	private readonly Entity _monster;

	public bool IsMonsterAlive
	{
		get
		{
			if (_monster.IsAlive())
			{
				return _monster.IsLogicAvailable();
			}
			return false;
		}
	}

	public MonsterEntityMissionPoint(int missionId, int pointId, bool use3DLogic, MapArea area, Entity monster, bool needEffect)
		: base(missionId, pointId, use3DLogic, area, needEffect)
	{
		_monster = monster;
	}

	public override Vector3 GetActualPos()
	{
		if (!IsMonsterAlive)
		{
			return Vector3.zero;
		}
		CompTransform compTransform = _monster.GetCompTransform();
		return compTransform.colliderPosition + Vector3.up * (compTransform.size.y * 0.5f + 0.2f);
	}
}
