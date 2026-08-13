local var_0_0 = {
	id = 1794013
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 180,
	backGroundStageID = 1,
	passCondition = 1,
	totalArea = {
		-75,
		20,
		90,
		70
	},
	playerArea = {
		-75,
		20,
		42,
		68
	},
	enemyArea = {}
}
local var_0_3 = {}
local var_0_4 = {}

Vector3 = var_0_10005
var_0_4[1] = var_0_10005(-105, 0, 58)
Vector3 = var_5
var_0_4[2] = var_5(-105, 0, 78)
Vector3 = var_5
var_0_4[3] = var_5(-105, 0, 38)
var_0_3[1] = var_0_4

local var_0_5 = {}

Vector3 = var_5
var_0_5[1] = var_5(15, 0, 58)
Vector3 = var_5
var_0_5[2] = var_5(15, 0, 78)
Vector3 = var_5
var_0_5[3] = var_5(15, 0, 38)
var_0_3[-1] = var_0_5
var_0_2.mainUnitPosition = var_0_3
var_0_2.fleetCorrdinate = {
	-80,
	0,
	75
}
var_0_2.waves = {
	{
		triggerType = 1,
		waveIndex = 100,
		preWaves = {},
		triggerParams = {
			timeout = 0.5
		}
	},
	{
		triggerType = 1,
		waveIndex = 202,
		preWaves = {},
		triggerParams = {
			timeout = 18
		}
	},
	{
		triggerType = 1,
		waveIndex = 203,
		preWaves = {},
		triggerParams = {
			timeout = 33
		}
	},
	{
		triggerType = 1,
		waveIndex = 204,
		preWaves = {},
		triggerParams = {
			timeout = 44
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 101,
		conditionType = 1,
		preWaves = {
			100
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 16594004,
				sickness = 0.3,
				delay = 0.5,
				reinforceDelay = 6,
				corrdinate = {
					-5,
					0,
					50
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 16594001,
				sickness = 0.3,
				delay = 0,
				corrdinate = {
					5,
					0,
					75
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				monsterTemplateID = 16594002,
				sickness = 0.3,
				delay = 0,
				corrdinate = {
					0,
					0,
					65
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				monsterTemplateID = 16594002,
				sickness = 0.3,
				delay = 0,
				corrdinate = {
					0,
					0,
					35
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				monsterTemplateID = 16594001,
				sickness = 0.3,
				delay = 0,
				corrdinate = {
					5,
					0,
					25
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			}
		}
	},
	{
		triggerType = 0,
		waveIndex = 102,
		conditionType = 1,
		preWaves = {
			101
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 16594005,
				sickness = 0.3,
				delay = 0.5,
				reinforceDelay = 6,
				corrdinate = {
					-5,
					0,
					50
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 16594001,
				sickness = 0.3,
				delay = 0,
				corrdinate = {
					5,
					0,
					75
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				monsterTemplateID = 16594002,
				sickness = 0.3,
				delay = 0,
				corrdinate = {
					0,
					0,
					65
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				monsterTemplateID = 16594002,
				sickness = 0.3,
				delay = 0,
				corrdinate = {
					0,
					0,
					35
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			},
			{
				monsterTemplateID = 16594001,
				sickness = 0.3,
				delay = 0,
				corrdinate = {
					5,
					0,
					25
				},
				buffList = {
					8001,
					8007,
					200720,
					200721
				}
			}
		}
	},
	{
		triggerType = 5,
		waveIndex = 400,
		preWaves = {
			102,
			101
		},
		triggerParams = {
			bgm = "theme-merkuriameta"
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 104,
		conditionType = 0,
		preWaves = {
			500,
			102,
			101
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 16594301,
				delay = 0.1,
				corrdinate = {
					-10,
					0,
					50
				},
				buffList = {},
				bossData = {
					hpBarNum = 80,
					icon = ""
				},
				phase = {
					{
						switchType = 1,
						switchTo = 1,
						index = 0,
						switchParam = 0.1,
						addWeapon = {}
					},
					{
						switchParam = 4.5,
						switchTo = 2,
						index = 1,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							3124001
						},
						removeWeapon = {
							3124002,
							3124003
						}
					},
					{
						switchParam = 5,
						switchTo = 3,
						index = 2,
						switchType = 1,
						addWeapon = {
							3124002,
							3124003
						},
						removeWeapon = {
							3124001
						}
					},
					{
						switchType = 1,
						switchTo = 1,
						index = 3,
						switchParam = 7,
						setAI = 70125
					}
				}
			}
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 105,
		conditionType = 0,
		preWaves = {
			104
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 16594302,
				delay = 1.5,
				corrdinate = {
					-10,
					0,
					50
				},
				buffList = {},
				bossData = {
					hpBarNum = 80,
					icon = ""
				},
				phase = {
					{
						switchType = 1,
						switchTo = 1,
						index = 0,
						switchParam = 0.1,
						addWeapon = {}
					},
					{
						switchParam = 4.5,
						switchTo = 2,
						index = 1,
						switchType = 1,
						setAI = 10001,
						addWeapon = {
							3124004
						},
						removeWeapon = {
							3124005,
							3124006,
							3124007
						}
					},
					{
						switchParam = 10.6,
						switchTo = 1,
						index = 2,
						switchType = 1,
						setAI = 75025,
						addWeapon = {
							3124005,
							3124006,
							3124007
						},
						removeWeapon = {
							3124004
						}
					}
				}
			}
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 106,
		conditionType = 0,
		preWaves = {
			105
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 16594303,
				delay = 1.5,
				corrdinate = {
					-10,
					0,
					50
				},
				buffList = {},
				bossData = {
					hpBarNum = 80,
					icon = ""
				},
				phase = {
					{
						switchType = 1,
						switchTo = 1,
						index = 0,
						switchParam = 0.1,
						addWeapon = {}
					},
					{
						switchParam = 4.5,
						switchTo = 2,
						index = 1,
						switchType = 1,
						setAI = 70125,
						addWeapon = {
							3124008
						}
					},
					{
						switchParam = 6,
						switchTo = 3,
						index = 2,
						switchType = 1,
						addWeapon = {
							3124009,
							3124010,
							3124011
						},
						removeWeapon = {
							3124008
						}
					},
					{
						switchType = 1,
						switchTo = 4,
						index = 3,
						switchParam = 1,
						addWeapon = {
							3124012
						}
					},
					{
						switchType = 1,
						switchTo = 5,
						index = 4,
						switchParam = 1,
						addWeapon = {
							3124013
						}
					},
					{
						switchType = 1,
						switchTo = 1,
						index = 5,
						switchParam = 300,
						addWeapon = {
							3124014
						}
					}
				}
			}
		}
	},
	{
		triggerType = 8,
		key = true,
		waveIndex = 900,
		preWaves = {
			106
		},
		triggerParams = {}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
