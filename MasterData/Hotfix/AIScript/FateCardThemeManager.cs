using System.Collections.Generic;
using AIScript.FateCardTheme;

namespace AIScript;

public class FateCardThemeManager : AIBase
{
	private readonly List<BaseFateCardTheme> themes = new List<BaseFateCardTheme>();

	public virtual void OnEnable()
	{
		Init();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_REFRESH_FATECARD_THEME", OnRefreshTheme);
	}

	public virtual void OnDisable()
	{
		Clear();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_REFRESH_FATECARD_THEME", OnRefreshTheme);
	}

	private void OnRefreshTheme(IEvent _evt)
	{
		if (!(_evt is ActorRefreshFateCardTheme))
		{
			return;
		}
		foreach (Lua2CSharpInfo_FateCardThemeInfo fateCardThemeInfo in ModuleController<AdventureModuleController>.Instance.FateCardThemeInfos)
		{
			if (fateCardThemeInfo.operateType == 1)
			{
				CreateInstance(fateCardThemeInfo.theme, fateCardThemeInfo.rank, fateCardThemeInfo.triggerTypes);
			}
			else if (fateCardThemeInfo.operateType == 2)
			{
				RemoveOldTheme(fateCardThemeInfo.theme);
				CreateInstance(fateCardThemeInfo.theme, fateCardThemeInfo.rank, fateCardThemeInfo.triggerTypes);
			}
			else if (fateCardThemeInfo.operateType == 3)
			{
				RemoveOldTheme(fateCardThemeInfo.theme);
			}
		}
		void RemoveOldTheme(HotfixEnum.fateCardTheme themeType)
		{
			BaseFateCardTheme baseFateCardTheme = null;
			foreach (BaseFateCardTheme theme in themes)
			{
				if (theme.theme == themeType)
				{
					baseFateCardTheme = theme;
					break;
				}
			}
			if (baseFateCardTheme != null)
			{
				baseFateCardTheme.OnDisable();
				themes.Remove(baseFateCardTheme);
			}
		}
	}

	private void Init()
	{
		foreach (Lua2CSharpInfo_FateCardThemeInfo fateCardThemeInfo in ModuleController<AdventureModuleController>.Instance.FateCardThemeInfos)
		{
			CreateInstance(fateCardThemeInfo.theme, fateCardThemeInfo.rank, fateCardThemeInfo.triggerTypes);
		}
	}

	private void Clear()
	{
		for (int i = 0; i < themes.Count; i++)
		{
			themes.get_Item(i).OnDisable();
			themes.set_Item(i, (BaseFateCardTheme)null);
		}
		themes.Clear();
	}

	private void CreateInstance(HotfixEnum.fateCardTheme theme, HotfixEnum.fateCardThemeRank rank, HotfixEnum.fateCardThemeTriggerType[] triggerTypes)
	{
		BaseFateCardTheme baseFateCardTheme = null;
		switch (theme)
		{
		case HotfixEnum.fateCardTheme.FireRing:
			baseFateCardTheme = new FateCard_FireRing();
			break;
		case HotfixEnum.fateCardTheme.FireWave:
			baseFateCardTheme = new FateCard_FireWave();
			break;
		case HotfixEnum.fateCardTheme.Meteor:
			baseFateCardTheme = new FateCard_FallingStone();
			break;
		case HotfixEnum.fateCardTheme.ChainLightning:
			baseFateCardTheme = new FateCard_LightingChain();
			break;
		case HotfixEnum.fateCardTheme.LightningBolt:
			baseFateCardTheme = new FateCard_LightingBolt();
			break;
		case HotfixEnum.fateCardTheme.WindBlade:
			baseFateCardTheme = new FateCard_WindBlade();
			break;
		case HotfixEnum.fateCardTheme.Blizzard:
			baseFateCardTheme = new FateCard_Blizzard();
			break;
		case HotfixEnum.fateCardTheme.WhirlWind:
			baseFateCardTheme = new FateCard_WhirlWind();
			break;
		case HotfixEnum.fateCardTheme.WindEagle:
			baseFateCardTheme = new FateCard_WindEagle();
			break;
		case HotfixEnum.fateCardTheme.LightingGhost:
			baseFateCardTheme = new FateCard_LightingGhost();
			break;
		case HotfixEnum.fateCardTheme.Shark:
			baseFateCardTheme = new FateCard_Shark();
			break;
		case HotfixEnum.fateCardTheme.CloudBottle:
			baseFateCardTheme = new FateCard_CloudBottle();
			break;
		case HotfixEnum.fateCardTheme.EarthSpike:
			baseFateCardTheme = new FateCard_EarthSpike();
			break;
		case HotfixEnum.fateCardTheme.EarthSpear:
			baseFateCardTheme = new FateCard_EarthSpear();
			break;
		case HotfixEnum.fateCardTheme.EarthQuake:
			baseFateCardTheme = new FateCard_EarthQuake();
			break;
		case HotfixEnum.fateCardTheme.EarthFissure:
			baseFateCardTheme = new FateCard_EarthFissure();
			break;
		case HotfixEnum.fateCardTheme.DarkBurst:
			baseFateCardTheme = new FateCard_Dark_DarkBurst();
			break;
		case HotfixEnum.fateCardTheme.NightPierce:
			baseFateCardTheme = new FateCard_Dark_NightPierce();
			break;
		case HotfixEnum.fateCardTheme.ShadowSphere:
			baseFateCardTheme = new FateCard_Dark_ShadowSphere();
			break;
		case HotfixEnum.fateCardTheme.VoidVortex:
			baseFateCardTheme = new FateCard_Dark_VoidVortex();
			break;
		}
		if (baseFateCardTheme != null)
		{
			baseFateCardTheme.OnInit(theme, rank, triggerTypes);
			baseFateCardTheme.OnEnable();
			themes.Add(baseFateCardTheme);
		}
	}
}
