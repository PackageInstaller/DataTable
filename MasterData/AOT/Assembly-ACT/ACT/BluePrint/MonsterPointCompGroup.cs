using System.Collections.Generic;
using System.Linq;
using ACT.World.Asset;

namespace ACT.BluePrint;

public class MonsterPointCompGroup : MonsterPointGroup
{
	private List<MonsterPointComp> monsterPointComps;

	public List<MonsterPointComp> GetMonsterPointComps()
	{
		if (monsterPointComps == null)
		{
			monsterPointComps = transform.GetComponentsInChildren<MonsterPointComp>().ToList();
		}
		return monsterPointComps;
	}
}
