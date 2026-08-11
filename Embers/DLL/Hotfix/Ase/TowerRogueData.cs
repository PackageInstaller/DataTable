using System.Collections.Generic;

namespace Ase;

public class TowerRogueData
{
	public List<int> RogueBuffs = new List<int>(6);

	public int RefreshCount;

	public int RoleId;

	public int TryTeamId;

	public List<int> BattlePropIds = new List<int>(2);

	public int MaxLayer;

	public int EndlessLayer;
}
