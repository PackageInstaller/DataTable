using System.Collections.Generic;
using Ase.ECS;

namespace Ase;

public class GlobalStatInfo
{
	public struct KillHeroEntityInfo
	{
		public int battleTime;

		public int heroConfigId;

		public int entityConfigId;

		public BaseEntity AttackEntity;
	}

	public int weaknessShowCount;

	public List<KillHeroEntityInfo> killHeroEntityInfoList;

	public GlobalStatInfo()
	{
		killHeroEntityInfoList = new List<KillHeroEntityInfo>();
	}

	public void AddKillHeroEntityInfo(int battleTime, ObserverDamageProgressParams damageProgressParams)
	{
		KillHeroEntityInfo item = new KillHeroEntityInfo
		{
			battleTime = battleTime,
			heroConfigId = damageProgressParams.Defender.EntityId,
			entityConfigId = damageProgressParams.Attacker.EntityId,
			AttackEntity = damageProgressParams.Attacker
		};
		killHeroEntityInfoList.Add(item);
	}

	public void Reset()
	{
		killHeroEntityInfoList?.Clear();
	}

	public void Clear()
	{
		Reset();
	}
}
