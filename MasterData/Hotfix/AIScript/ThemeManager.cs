using System.Collections.Generic;
using AIScript.ThemePerk;

namespace AIScript;

public class ThemeManager : AIBase
{
	private readonly List<BaseTheme> themeClsList = new List<BaseTheme>();

	public virtual void OnEnable()
	{
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REFRESH_THEMEPERK", OnRefreshTheme);
		ParseThemeData();
		for (int i = 0; i < themeClsList.Count; i++)
		{
			themeClsList.get_Item(i).OnEnable();
		}
	}

	public virtual void OnDisable()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REFRESH_THEMEPERK", OnRefreshTheme);
		for (int i = 0; i < themeClsList.Count; i++)
		{
			themeClsList.get_Item(i).OnDisable();
		}
		themeClsList.Clear();
	}

	private void ParseThemeData()
	{
		List<int> perkThemes = ModuleController<AdventureModuleController>.Instance.PerkThemes;
		if (perkThemes == null)
		{
			return;
		}
		foreach (int item in perkThemes)
		{
			CreateInstance((HotfixEnum.rglTheme)item);
		}
	}

	private void CreateInstance(HotfixEnum.rglTheme type)
	{
		switch (type)
		{
		case HotfixEnum.rglTheme.FireRing:
			themeClsList.Add(new Theme_FireRing());
			break;
		case HotfixEnum.rglTheme.FireWave:
			themeClsList.Add(new Theme_FireWave());
			break;
		case HotfixEnum.rglTheme.Meteor:
			themeClsList.Add(new Theme_FallingStone());
			break;
		case HotfixEnum.rglTheme.LightningBall:
			themeClsList.Add(new Theme_ElectroBall());
			break;
		case HotfixEnum.rglTheme.ChainLightning:
			themeClsList.Add(new Theme_LightingChain());
			break;
		case HotfixEnum.rglTheme.FireBall:
			themeClsList.Add(new Theme_FireBall());
			break;
		case HotfixEnum.rglTheme.LightningBolt:
			themeClsList.Add(new Theme_LightningBolt());
			break;
		case HotfixEnum.rglTheme.WindBlade:
			themeClsList.Add(new Theme_WindBlade());
			break;
		case HotfixEnum.rglTheme.Blizzard:
			themeClsList.Add(new Theme_Blizzard());
			break;
		case HotfixEnum.rglTheme.WhirlWind:
			themeClsList.Add(new Theme_WhirlWind());
			break;
		case HotfixEnum.rglTheme.WindEagle:
			themeClsList.Add(new Theme_WindEagle());
			break;
		case HotfixEnum.rglTheme.WindArea:
			themeClsList.Add(new Theme_WindArea());
			break;
		case HotfixEnum.rglTheme.LightingGhost:
			themeClsList.Add(new Theme_LightingGhost());
			break;
		case HotfixEnum.rglTheme.Shark:
			themeClsList.Add(new Theme_Shark());
			break;
		case HotfixEnum.rglTheme.CloudBottle:
			themeClsList.Add(new Theme_CloudBottle());
			break;
		case HotfixEnum.rglTheme.FreezeArea:
			themeClsList.Add(new Theme_FreezeArea());
			break;
		}
	}

	private void OnRefreshTheme(IEvent _evt)
	{
		if (_evt is ActorRefreshThemePerk)
		{
			for (int i = 0; i < themeClsList.Count; i++)
			{
				themeClsList.get_Item(i).OnDisable();
				themeClsList.set_Item(i, (BaseTheme)null);
			}
			themeClsList.Clear();
			ParseThemeData();
			for (int j = 0; j < themeClsList.Count; j++)
			{
				themeClsList.get_Item(j).OnEnable();
			}
		}
	}
}
