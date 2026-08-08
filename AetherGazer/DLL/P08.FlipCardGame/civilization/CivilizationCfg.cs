using System.Collections.Generic;
using System.Linq;

namespace civilization;

public static class CivilizationCfg
{
	public static List<Age> age = new List<Age>();

	public static List<Factor> factor = new List<Factor>();

	public static List<Skill> skill = new List<Skill>();

	public static List<Hero> hero = new List<Hero>();

	public static List<TechLevel> techCost = new List<TechLevel>();

	public static List<Stage> stage = new List<Stage>();

	public static void Init()
	{
		age.Clear();
		factor.Clear();
		skill.Clear();
		hero.Clear();
		techCost.Clear();
		stage.Clear();
	}

	public static Stage GetStage(int id)
	{
		return stage.Find((Stage s) => s.ID == id);
	}

	public static Hero GetHero(int id)
	{
		return hero.Find((Hero h) => h.id == id);
	}

	public static Factor GetFactorByID(int id)
	{
		return factor.Find((Factor f) => f.id == id);
	}

	public static Skill GetSkillByID(int id)
	{
		return skill.Find((Skill s) => s.id == id);
	}

	public static int GetNeedTechCost(int state)
	{
		if (state >= techCost.Count)
		{
			return 99999999;
		}
		return techCost.Find((TechLevel t) => t.level == state + 1).cost;
	}

	public static bool IsTechShow(int state, int techID)
	{
		if (state >= techCost.Count)
		{
			return true;
		}
		List<TechLevel> list = techCost.FindAll((TechLevel t) => t.level < state + 1);
		if (list.Find((TechLevel t) => t.techList.Contains(techID)) != null)
		{
			return true;
		}
		return false;
	}

	public static int[] GetCanChooseHex(int hexIndex, int heroID)
	{
		return hero.Find((Hero h) => h.id == heroID).hexFactor[hexIndex];
	}
}
