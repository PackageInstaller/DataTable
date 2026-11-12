using System.Collections.Generic;
using TrueSync;

public class AdventurePrologueBattleRevival : BaseAdventureEvent
{
	public int revivalPoint;

	public TSVector2 revivalPos;

	public List<string> names;

	public Dictionary<int, Dictionary<int, int>> PersonalPerkInfos;

	public List<int> perkThemes;

	public int boxID;

	public static AdventurePrologueBattleRevival Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurePrologueBattleRevival>("PROLOGUELEVEL_REVIVAPOINT");
	}

	public AdventurePrologueBattleRevival()
		: base("PROLOGUELEVEL_REVIVAPOINT")
	{
	}

	public override void Clear()
	{
		revivalPos = default;
		names?.Clear();
		PersonalPerkInfos?.Clear();
		perkThemes?.Clear();
	}
}
