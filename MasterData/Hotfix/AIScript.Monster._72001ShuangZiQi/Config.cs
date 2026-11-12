using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._72001ShuangZiQi;

public static class Config
{
	public static int cellSize = 5;

	public static TSVector2 centerOffset = new TSVector2(-12.5, -12.5);

	public static TSVector2 cellOffset = new TSVector2(2.5, 2.5);

	public static int mapSize = 25;

	public static int cellCount = 5;

	public static TSVector2 redBossPos = new TSVector2(0, 2);

	public static TSVector2 greenBossPos = new TSVector2(4, 2);

	public static Dictionary<int, GridColor> dicGridColor_1_2_AllWhite = new Dictionary<int, GridColor>
	{
		[20] = GridColor.White,
		[21] = GridColor.White,
		[22] = GridColor.White,
		[23] = GridColor.White,
		[24] = GridColor.White,
		[15] = GridColor.White,
		[16] = GridColor.White,
		[17] = GridColor.White,
		[18] = GridColor.White,
		[19] = GridColor.White,
		[10] = GridColor.White,
		[11] = GridColor.White,
		[12] = GridColor.White,
		[13] = GridColor.White,
		[14] = GridColor.White,
		[5] = GridColor.White,
		[6] = GridColor.White,
		[7] = GridColor.White,
		[8] = GridColor.White,
		[9] = GridColor.White,
		[0] = GridColor.White,
		[1] = GridColor.White,
		[2] = GridColor.White,
		[3] = GridColor.White,
		[4] = GridColor.White
	};

	public static Dictionary<int, GridColor> dicGridColor_1_2_Common = new Dictionary<int, GridColor>
	{
		[20] = GridColor.Green,
		[21] = GridColor.Red,
		[22] = GridColor.White,
		[23] = GridColor.Green,
		[24] = GridColor.Red,
		[15] = GridColor.Red,
		[16] = GridColor.Green,
		[17] = GridColor.White,
		[18] = GridColor.Red,
		[19] = GridColor.Green,
		[10] = GridColor.White,
		[11] = GridColor.Green,
		[12] = GridColor.White,
		[13] = GridColor.Red,
		[14] = GridColor.White,
		[5] = GridColor.Green,
		[6] = GridColor.Red,
		[7] = GridColor.White,
		[8] = GridColor.Green,
		[9] = GridColor.Red,
		[0] = GridColor.Red,
		[1] = GridColor.Green,
		[2] = GridColor.White,
		[3] = GridColor.Red,
		[4] = GridColor.Green
	};

	public static Dictionary<int, GridColor> dicGridColor_3_GreenBoss = new Dictionary<int, GridColor>
	{
		[20] = GridColor.White,
		[21] = GridColor.Red,
		[22] = GridColor.White,
		[23] = GridColor.Red,
		[24] = GridColor.White,
		[15] = GridColor.Red,
		[16] = GridColor.White,
		[17] = GridColor.Red,
		[18] = GridColor.White,
		[19] = GridColor.Red,
		[10] = GridColor.White,
		[11] = GridColor.Red,
		[12] = GridColor.White,
		[13] = GridColor.Red,
		[14] = GridColor.White,
		[5] = GridColor.Red,
		[6] = GridColor.White,
		[7] = GridColor.Red,
		[8] = GridColor.White,
		[9] = GridColor.Red,
		[0] = GridColor.White,
		[1] = GridColor.Red,
		[2] = GridColor.White,
		[3] = GridColor.Red,
		[4] = GridColor.White
	};

	public static Dictionary<int, GridColor> dicGridColor_3_RedBoss = new Dictionary<int, GridColor>
	{
		[20] = GridColor.White,
		[21] = GridColor.Green,
		[22] = GridColor.White,
		[23] = GridColor.Green,
		[24] = GridColor.White,
		[15] = GridColor.Green,
		[16] = GridColor.White,
		[17] = GridColor.Green,
		[18] = GridColor.White,
		[19] = GridColor.Green,
		[10] = GridColor.White,
		[11] = GridColor.Green,
		[12] = GridColor.White,
		[13] = GridColor.Green,
		[14] = GridColor.White,
		[5] = GridColor.Green,
		[6] = GridColor.White,
		[7] = GridColor.Green,
		[8] = GridColor.White,
		[9] = GridColor.Green,
		[0] = GridColor.White,
		[1] = GridColor.Green,
		[2] = GridColor.White,
		[3] = GridColor.Green,
		[4] = GridColor.White
	};

	public static int buffTag_red = CommonHelper.StringToHash("RedChess");

	public static int buffTag_green = CommonHelper.StringToHash("GreenChess");

	public static Dictionary<int, List<int>> buffId_red = new Dictionary<int, List<int>>
	{
		[1] = new List<int> { 720010000, 720010000, 720010000 },
		[2] = new List<int> { 720010000, 720010000, 720010000 },
		[3] = new List<int> { 720010020, 720010020, 720010020 },
		[4] = new List<int> { 720010040, 720010040, 720010040 },
		[5] = new List<int> { 720010060, 720010060, 720010060 },
		[6] = new List<int> { 720010120, 720010120, 720010120 }
	};

	public static Dictionary<int, List<int>> buffId_green = new Dictionary<int, List<int>>
	{
		[1] = new List<int> { 720010010, 720010010, 720010010 },
		[2] = new List<int> { 720010010, 720010010, 720010010 },
		[3] = new List<int> { 720010030, 720010030, 720010030 },
		[4] = new List<int> { 720010050, 720010050, 720010050 },
		[5] = new List<int> { 720010070, 720010070, 720010070 },
		[6] = new List<int> { 720010130, 720010130, 720010130 }
	};

	public static Dictionary<int, List<int>> buffMaxCount = new Dictionary<int, List<int>>
	{
		[1] = new List<int> { 1, 1, 1 },
		[2] = new List<int> { 1, 1, 1 },
		[3] = new List<int> { 1, 1, 1 },
		[4] = new List<int> { 1, 1, 1 },
		[5] = new List<int> { 1, 1, 1 },
		[6] = new List<int> { 1, 1, 1 }
	};

	public static Dictionary<int, List<FP>> interval = new Dictionary<int, List<FP>>
	{
		[1] = new List<FP> { 0.1, 0.1, 0.1 },
		[2] = new List<FP> { 0.1, 0.1, 0.1 },
		[3] = new List<FP> { 0.1, 0.1, 0.1 },
		[4] = new List<FP> { 0.1, 0.1, 0.1 },
		[5] = new List<FP> { 0.1, 0.1, 0.1 },
		[6] = new List<FP> { 0.1, 0.1, 0.1 }
	};

	public static int buffId_red_icon = 720010080;

	public static int buffId_green_icon = 720010090;

	public static string FX_W2G = "fx_m72007_base_RanSe_W2G";

	public static string FX_W2R = "fx_m72007_base_RanSe_W2R";

	public static string FX_R2W = "fx_m72007_base_RanSe_R2W";

	public static string FX_R2G = "fx_m72007_base_RanSe_R2G";

	public static string FX_G2W = "fx_m72007_base_RanSe_G2W";

	public static string FX_G2R = "fx_m72007_base_RanSe_G2R";

	public static string FX_Player_Red = "fx_m72007_base_RanSe_Red_in";

	public static string FX_Player_Green = "fx_m72007_base_RanSe_Green_in";

	public static Dictionary<int, List<TSVector2>> RedSoldierPositionList = new Dictionary<int, List<TSVector2>>
	{
		[1] = new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 3),
			new TSVector2(1, 2)
		},
		[2] = new List<TSVector2>
		{
			new TSVector2(0, 1),
			new TSVector2(0, 4),
			new TSVector2(1, 2)
		}
	};

	public static Dictionary<int, List<TSVector2>> GreenSoldierPositionList = new Dictionary<int, List<TSVector2>>
	{
		[1] = new List<TSVector2>
		{
			new TSVector2(4, 0),
			new TSVector2(4, 3),
			new TSVector2(3, 2)
		},
		[2] = new List<TSVector2>
		{
			new TSVector2(4, 1),
			new TSVector2(4, 4),
			new TSVector2(3, 2)
		}
	};

	public static List<TSVector2> SoldierPositionListP3_1 = new List<TSVector2>
	{
		new TSVector2(3, 4),
		new TSVector2(2, 4),
		new TSVector2(1, 4)
	};

	public static List<TSVector2> SoldierPositionListP3_2 = new List<TSVector2>
	{
		new TSVector2(3, 0),
		new TSVector2(2, 0),
		new TSVector2(1, 0)
	};

	public static List<int> rowList = new List<int> { 1, 3 };

	public static List<int> JumpTime_ez_List = new List<int> { 2, 2, 2 };

	public static List<int> JumpTime_hd_List = new List<int> { 2, 3, 2 };

	public static FP spawnScale = 0.25;

	public static FP jumpScale = 0.25;

	public static FP maxScale = 1.75;

	public static Dictionary<int, List<TSVector2>> RedArtilleryPositionList = new Dictionary<int, List<TSVector2>>
	{
		[0] = new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 4)
		},
		[1] = new List<TSVector2>
		{
			new TSVector2(0, 1),
			new TSVector2(0, 4)
		},
		[2] = new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 3)
		},
		[3] = new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 4)
		},
		[4] = new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 4),
			new TSVector2(4, 0),
			new TSVector2(4, 4)
		}
	};

	public static Dictionary<int, List<TSVector2>> GreenArtilleryPositionList = new Dictionary<int, List<TSVector2>>
	{
		[0] = new List<TSVector2>
		{
			new TSVector2(4, 0),
			new TSVector2(4, 4)
		},
		[1] = new List<TSVector2>
		{
			new TSVector2(4, 1),
			new TSVector2(4, 4)
		},
		[2] = new List<TSVector2>
		{
			new TSVector2(4, 0),
			new TSVector2(4, 3)
		},
		[3] = new List<TSVector2>
		{
			new TSVector2(4, 0),
			new TSVector2(4, 4)
		},
		[4] = new List<TSVector2>
		{
			new TSVector2(4, 0),
			new TSVector2(4, 4),
			new TSVector2(0, 0),
			new TSVector2(0, 4)
		}
	};

	public static int BulletAmountBase_ez = 3;

	public static int BulletAmountBase_hd = 6;

	public static int ShootAmountBase = 3;

	public static FP ShootAngle_ez = 120;

	public static FP ShootAngle_hd = 240;

	public static FP ArtilleryShootDurationBase = 2;

	public static int ArtilleryShootCountBase = 6;

	public static TSVector2 GeneralPosition_Red = new TSVector2(1, 2);

	public static TSVector2 GeneralPosition_Green = new TSVector2(3, 2);

	public static List<TSVector2> GeneralPosition_Red_P3 = new List<TSVector2>
	{
		new TSVector2(1, 1),
		new TSVector2(1, 3)
	};

	public static List<TSVector2> GeneralPosition_Green_P3 = new List<TSVector2>
	{
		new TSVector2(3, 1),
		new TSVector2(3, 3)
	};

	public static int SoldierAmount = 3;

	public static FP SoldierIntervalTime_ez = 4;

	public static FP SoldierIntervalTime_hd = 2.5;

	public static FP GeneralAttackIntervalTime_P3 = 3.5;

	public static int GeneralAttackTime_P3 = 4;

	public static List<FP> UltraSkillTotalTime = new List<FP> { 18, 18, 18, 15, 15, 15 };

	public static List<int> UltraSkillAttackTimes = new List<int> { 5, 5, 5, 4, 4, 4 };

	public static int BallCount_ez = 3;

	public static int BallCount_hd = 3;

	public static List<TSVector2> BallPosition_P3_1 = new List<TSVector2>
	{
		new TSVector2(1, 1),
		new TSVector2(1, 3),
		new TSVector2(3, 1),
		new TSVector2(3, 3)
	};

	public static List<TSVector2> BallPosition_P3_2 = new List<TSVector2>
	{
		new TSVector2(1, 3),
		new TSVector2(2, 4),
		new TSVector2(2, 0),
		new TSVector2(3, 1)
	};

	public static FP AttackTotalTime = 4;

	public static List<int> BanList = new List<int> { 10, 14 };

	public static Dictionary<int, List<TSVector2>> RedArtillery1PositionList = new Dictionary<int, List<TSVector2>>
	{
		[0] = new List<TSVector2>
		{
			new TSVector2(0, 1),
			new TSVector2(0, 3)
		},
		[1] = new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 4)
		}
	};

	public static Dictionary<int, List<TSVector2>> GreenArtillery1PositionList = new Dictionary<int, List<TSVector2>>
	{
		[0] = new List<TSVector2>
		{
			new TSVector2(4, 1),
			new TSVector2(4, 3)
		},
		[1] = new List<TSVector2>
		{
			new TSVector2(4, 0),
			new TSVector2(4, 4)
		}
	};

	public static Dictionary<int, List<TSVector2>> RedArtillery1PositionList_P3 = new Dictionary<int, List<TSVector2>>
	{
		[0] = new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 4)
		},
		[1] = new List<TSVector2>
		{
			new TSVector2(4, 0),
			new TSVector2(4, 4)
		}
	};

	public static Dictionary<int, List<TSVector2>> GreenArtillery1PositionList_P3 = new Dictionary<int, List<TSVector2>>
	{
		[0] = new List<TSVector2>
		{
			new TSVector2(4, 0),
			new TSVector2(4, 4)
		},
		[1] = new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 4)
		}
	};

	public static FP Artillery1AttackInterval = 0.75;

	public static FP Artillery1AttackInterval_P2 = 0.75;

	public static int Artillery1BossExtraAttackCount = 3;

	public static Dictionary<int, List<TSVector2>> KnightsPositionList = new Dictionary<int, List<TSVector2>>
	{
		[0] = new List<TSVector2>
		{
			new TSVector2(2, 2)
		},
		[1] = new List<TSVector2>
		{
			new TSVector2(3, 3)
		},
		[2] = new List<TSVector2>
		{
			new TSVector2(3, 1)
		},
		[3] = new List<TSVector2>
		{
			new TSVector2(1, 1)
		},
		[4] = new List<TSVector2>
		{
			new TSVector2(1, 3)
		},
		[11] = new List<TSVector2>
		{
			new TSVector2(1, 3),
			new TSVector2(3, 1)
		},
		[12] = new List<TSVector2>
		{
			new TSVector2(1, 1),
			new TSVector2(3, 3)
		}
	};

	public static FP General1AttackInterval = 0;

	public static FP General1AttackInterval_P3 = 2;

	public static Dictionary<int, List<TSVector2>> RedLv6BallPositionList = new Dictionary<int, List<TSVector2>>
	{
		[1] = new List<TSVector2>
		{
			new TSVector2(1, 1)
		},
		[2] = new List<TSVector2>
		{
			new TSVector2(1, 3)
		}
	};

	public static Dictionary<int, List<TSVector2>> GreenLv6BallPositionList = new Dictionary<int, List<TSVector2>>
	{
		[1] = new List<TSVector2>
		{
			new TSVector2(3, 1)
		},
		[2] = new List<TSVector2>
		{
			new TSVector2(3, 3)
		}
	};

	public static int soldierAtkEvt = CommonHelper.StringToHash("soldierAtkEvt");

	public static int generalAtkEvt = CommonHelper.StringToHash("generalAtkEvt");

	public static int artilleryAtkEvt = CommonHelper.StringToHash("artilleryAtkEvt");

	public static int carrierAtkEvt = CommonHelper.StringToHash("carrierAtkEvt");

	public static int artillery1AtkEvt = CommonHelper.StringToHash("artillery1AtkEvt");

	public static int artillery1ExtraAtkEvt = CommonHelper.StringToHash("artillery1ExtraAtkEvt");

	public static int artillery1BulletHitEvt = CommonHelper.StringToHash("artillery1BulletHitEvt");

	public static int general1AtkEvt = CommonHelper.StringToHash("general1AtkEvt");

	public static int soldierSpawnEvt = CommonHelper.StringToHash("soldierSpawnEvt");

	public static int bollSpawnEvt = CommonHelper.StringToHash("bollSpawnEvt");

	public static int ranseEvt = CommonHelper.StringToHash("ranseEvt");

	public static string Skill_Solider_Finish = "Skill_Solider_Finish";

	public static string Skill_General_Finish = "Skill_General_Finish";

	public static string Skill_Artillery_Finish = "Skill_Artillery_Finish";

	public static string Skill_Carrier_Finish = "Skill_Carrier_Finish";

	public static string Skill_RanSe_Finish = "Skill_RanSe_Finish";

	public static string Skill_GanRao_Finish = "Skill_GanRao_Finish";

	public static string Skill_Show_Finish = "Skill_Show_Finish";

	public static string Skill_Artillery2_Finish = "Skill_Artillery2_Finish";

	public static string Skill_General3_Finish = "Skill_General3_Finish";

	public static TSVector2 GetCurIndexByPos(TSVector2 playerPOS)
	{
		playerPOS.x = TSMath.Clamp(playerPOS.x - centerOffset.x, 0, mapSize);
		playerPOS.y = TSMath.Clamp(playerPOS.y - centerOffset.y, 0, mapSize);
		int value = TSMath.FloorToInt(playerPOS.x / cellSize);
		int value2 = TSMath.FloorToInt(playerPOS.y / cellSize);
		int num = Mathf.Clamp(value, 0, cellCount - 1);
		return new TSVector2(y: Mathf.Clamp(value2, 0, cellCount - 1), x: num);
	}

	public static TSVector2 GetCellPosByIndex(int index)
	{
		int x = index % cellSize;
		int y = index / cellSize;
		return GetCellPosByIndex(x, y);
	}

	public static TSVector2 GetCellPosByIndex(int x, int y)
	{
		int num = x * cellSize;
		return new TSVector2(y: y * cellSize, x: num) + centerOffset + cellOffset;
	}

	public static TSVector2 GetCellPosByIndex(TSVector2 index)
	{
		return GetCellPosByIndex(index.x.AsInt(), index.y.AsInt());
	}

	public static bool IsOutOfRange(int x, int y)
	{
		if (x >= 0 && x <= cellCount - 1)
		{
			if (y >= 0)
			{
				return y > cellCount - 1;
			}
			return true;
		}
		return true;
	}

	public static bool IsOutOfRange(TSVector2 index)
	{
		int num = index.x.AsInt();
		int num2 = index.y.AsInt();
		if (num >= 0 && num <= cellCount - 1)
		{
			if (num2 >= 0)
			{
				return num2 > cellCount - 1;
			}
			return true;
		}
		return true;
	}

	public static int GetCellIndexByPos(TSVector2 playerPOS)
	{
		TSVector2 curIndexByPos = GetCurIndexByPos(playerPOS);
		return GetCellIndexByIndex(curIndexByPos.x.AsInt(), curIndexByPos.y.AsInt());
	}

	public static int GetCellIndexByIndex(int x, int y)
	{
		return x + y * cellCount;
	}

	public static int GetCellIndexByIndex(TSVector2 index)
	{
		int num = index.x.AsInt();
		int num2 = index.y.AsInt();
		return num + num2 * cellCount;
	}
}
