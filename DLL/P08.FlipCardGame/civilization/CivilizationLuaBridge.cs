namespace civilization;

public class CivilizationLuaBridge
{
	public static void PreLoadGame()
	{
		CivilizationCfg.Init();
	}

	public static void PreLoadFactor(int id, int type, int gainType, int[] nums)
	{
		Factor item = new Factor(id, type, gainType, nums);
		CivilizationCfg.factor.Add(item);
	}

	public static void PreLoadFactorLevel(int level, int cost, int[] techList)
	{
		TechLevel item = new TechLevel(level, cost, techList);
		CivilizationCfg.techCost.Add(item);
	}

	public static void PreLoadHero(int id, int startTech, int[] hex1, int[] hex2, int[] hex3)
	{
		Hero item = new Hero(id, startTech, hex1, hex2, hex3);
		CivilizationCfg.hero.Add(item);
	}

	public static void PreLoadAge(int id, int startAge, int turnChange, int foodCostChange, bool mapExtension, bool hex, int[] sourceChange)
	{
		Age item = new Age(id, startAge, turnChange, foodCostChange, mapExtension, hex, sourceChange);
		CivilizationCfg.age.Add(item);
	}

	public static void PreLoadSkill(int id, int cost, int cd, string spritePath)
	{
		Skill item = new Skill(id, cost, cd, spritePath);
		CivilizationCfg.skill.Add(item);
	}

	public static void PreLoadStage(int id, int activityID, int[] init_cell_list, int[] init_cells_location, int[] init_source, int[] init_factor)
	{
		Stage item = new Stage(id, activityID, init_cell_list, init_cells_location, init_source, init_factor);
		CivilizationCfg.stage.Add(item);
	}

	public static void PreLoadTeachStage(int id, int[][] init_cells_location_list, int[][] create_cells_location)
	{
		CivilizationCfg.GetStage(id)?.SetTeachInitList(init_cells_location_list, create_cells_location);
	}

	public static void StartGame(int stageID, int heroID, int activityID, bool isTeach)
	{
		GameType gameType = GameType.Normal;
		if (isTeach)
		{
			gameType = GameType.Teach;
		}
		CivilizationMain.Instance.StartGame(stageID, heroID, activityID, gameType);
	}

	public static void ChooseTech(int techID)
	{
		CivilizationMain.Instance.UnlockTech(techID, isHex: false);
		CivilizationMain.Instance.OnChooseTech(techID);
		OnCloseLuaPage();
	}

	public static void ChooseHex(int hexID)
	{
		CivilizationMain.Instance.UnlockTech(hexID, isHex: true);
		OnCloseLuaPage();
	}

	public static void EndGame()
	{
		CivilizationMain.Instance.GameOver(isWin: false, isCancel: true);
	}

	public static bool GetTechUnlock(int techID)
	{
		int curHex = CivilizationMain.Instance.curHex;
		for (int i = 0; i < curHex; i++)
		{
			for (int j = 0; j < CivilizationMain.Instance.hero.hexFactor[i].Length; j++)
			{
				if (techID == CivilizationMain.Instance.hero.hexFactor[i][j])
				{
					return true;
				}
			}
		}
		return false;
	}

	public static bool GetTechSelect(int techID)
	{
		return CivilizationMain.Instance.unlockTech.Contains(techID);
	}

	public static int[] GetInfoTips()
	{
		return new int[7]
		{
			CivilizationMain.Instance.speed,
			CivilizationMain.Instance.limits[1],
			CivilizationMain.Instance.lows[1],
			CivilizationMain.Instance.limits[3],
			CivilizationMain.Instance.lows[3],
			CivilizationMain.Instance.limits[2],
			CivilizationMain.Instance.lows[2]
		};
	}

	public static void OnCloseLuaPage()
	{
		CivilizationMain.Instance.uiInstance.OnCloseLuaPage();
	}

	public static void SetGameCanDrag(bool canDrag, bool isTeach)
	{
		CivilizationMain.Instance.SetCanDrag(canDrag);
		CivilizationMain.Instance.isTeach = isTeach;
	}

	public static bool CheckBlock(int x, int y, int kind)
	{
		return CivilizationMain.Instance.CheckBlock(x, y, kind);
	}

	public static int CheckStage()
	{
		return CivilizationMain.Instance.curAge + 1;
	}
}
