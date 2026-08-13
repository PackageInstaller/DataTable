local var_0_0 = {
	map_id = 10001,
	id = 11404110
}
local var_0_1 = {}
local var_0_2 = {
	stageIndex = 1,
	failCondition = 1,
	timeCount = 180,
	backGroundStageID = 1,
	passCondition = 1,
	totalArea = {
		-70,
		20,
		90,
		70
	},
	playerArea = {
		-70,
		20,
		37,
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
			timeout = 10
		}
	},
	{
		triggerType = 1,
		waveIndex = 203,
		preWaves = {},
		triggerParams = {
			timeout = 22
		}
	},
	{
		triggerType = 1,
		waveIndex = 204,
		preWaves = {},
		triggerParams = {
			timeout = 36
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
				monsterTemplateID = 114001,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 114025,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					55
				},
				buffList = {
					9651
				}
			},
			{
				monsterTemplateID = 114002,
				delay = 0,
				moveCast = true,
				corrdinate = {
					20,
					0,
					65
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 114002,
				delay = 0,
				moveCast = true,
				corrdinate = {
					20,
					0,
					45
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 114001,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					30
				},
				buffList = {
					8001,
					8007
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 114019,
				delay = 3,
				moveCast = true,
				corrdinate = {
					30,
					0,
					28
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 114019,
				delay = 3,
				moveCast = true,
				corrdinate = {
					30,
					0,
					73
				},
				buffList = {
					8001,
					8002
				}
			}
		}
	},
	{
		triggerType = 1,
		waveIndex = 301,
		conditionType = 1,
		preWaves = {
			101,
			202
		},
		triggerParams = {
			timeout = 0.5
		}
	},
	{
		key = true,
		triggerType = 0,
		waveIndex = 102,
		conditionType = 1,
		preWaves = {
			301
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 114029,
				reinforceDelay = 6,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-5,
					0,
					55
				},
				buffList = {
					9651
				}
			},
			{
				monsterTemplateID = 114005,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					55
				},
				buffList = {
					9674
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 114001,
				delay = 2,
				moveCast = true,
				corrdinate = {
					10,
					0,
					75
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 114001,
				delay = 2,
				moveCast = true,
				corrdinate = {
					10,
					0,
					35
				},
				buffList = {
					8001,
					8007
				}
			}
		},
		airFighter = {
			{
				interval = 10,
				onceNumber = 3,
				formation = 10005,
				templateID = 350010,
				delay = 0,
				totalNumber = 3,
				weaponID = {
					350008
				},
				attr = {
					airPower = 40,
					maxHP = 1200,
					attackRating = 23
				}
			}
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 2001,
		conditionType = 1,
		preWaves = {
			301
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 114020,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					55
				},
				buffList = {
					8001
				},
				phase = {
					{
						switchType = 1,
						dive = "STATE_RAID",
						switchTo = 1,
						index = 0,
						switchParam = 20,
						setAI = 20009
					},
					{
						index = 1,
						switchType = 1,
						switchTo = 1,
						switchParam = 180
					}
				}
			}
		}
	},
	{
		triggerType = 1,
		waveIndex = 302,
		conditionType = 1,
		preWaves = {
			102,
			203
		},
		triggerParams = {
			timeout = 0.5
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 103,
		conditionType = 1,
		preWaves = {
			302
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 114027,
				reinforceDelay = 5,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					55
				},
				buffList = {
					9651
				}
			},
			{
				monsterTemplateID = 114003,
				delay = 0,
				moveCast = true,
				corrdinate = {
					15,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 114024,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					65
				},
				buffList = {
					8001,
					8007,
					8625,
					8630,
					9700
				}
			},
			{
				monsterTemplateID = 114024,
				delay = 0,
				moveCast = true,
				corrdinate = {
					8,
					0,
					45
				},
				buffList = {
					8001,
					8007,
					8625,
					8630,
					9700
				}
			},
			{
				monsterTemplateID = 114019,
				delay = 3,
				moveCast = true,
				corrdinate = {
					30,
					0,
					32
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 114019,
				delay = 2,
				moveCast = true,
				corrdinate = {
					30,
					0,
					53
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 114019,
				delay = 3,
				moveCast = true,
				corrdinate = {
					30,
					0,
					78
				},
				buffList = {
					8001,
					8002
				}
			}
		}
	},
	{
		triggerType = 1,
		waveIndex = 303,
		conditionType = 0,
		preWaves = {
			103,
			102,
			101
		},
		triggerParams = {
			timeout = 0.5
		}
	},
	{
		key = true,
		triggerType = 0,
		waveIndex = 104,
		conditionType = 0,
		preWaves = {
			303
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 114032,
				reinforceDelay = 6,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					70
				},
				buffList = {
					8050,
					8051
				}
			},
			{
				monsterTemplateID = 114028,
				reinforceDelay = 6,
				delay = 0,
				moveCast = true,
				corrdinate = {
					-15,
					0,
					40
				},
				buffList = {
					8050,
					8051,
					9651
				}
			}
		},
		reinforcement = {
			{
				monsterTemplateID = 114001,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					80
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 114001,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					30
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 114002,
				delay = 0,
				moveCast = true,
				corrdinate = {
					0,
					0,
					55
				},
				buffList = {
					8001,
					8007
				}
			},
			{
				monsterTemplateID = 114019,
				delay = 2,
				moveCast = true,
				corrdinate = {
					30,
					0,
					28
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 114019,
				delay = 2,
				moveCast = true,
				corrdinate = {
					30,
					0,
					53
				},
				buffList = {
					8001,
					8002
				}
			},
			{
				monsterTemplateID = 114019,
				delay = 2,
				moveCast = true,
				corrdinate = {
					30,
					0,
					78
				},
				buffList = {
					8001,
					8002
				}
			}
		},
		airFighter = {
			{
				interval = 10,
				onceNumber = 3,
				formation = 10005,
				templateID = 350010,
				delay = 0,
				totalNumber = 3,
				weaponID = {
					350008
				},
				attr = {
					airPower = 40,
					maxHP = 1200,
					attackRating = 23
				}
			}
		}
	},
	{
		triggerType = 0,
		key = true,
		waveIndex = 2002,
		conditionType = 1,
		preWaves = {
			303
		},
		triggerParam = {},
		spawn = {
			{
				monsterTemplateID = 114020,
				score = 0,
				delay = 0,
				moveCast = true,
				corrdinate = {
					10,
					0,
					55
				},
				buffList = {
					8001
				},
				phase = {
					{
						switchType = 1,
						dive = "STATE_RAID",
						switchTo = 1,
						index = 0,
						switchParam = 20,
						setAI = 20009
					},
					{
						index = 1,
						switchType = 1,
						switchTo = 1,
						switchParam = 180
					}
				}
			}
		}
	},
	{
		triggerType = 8,
		waveIndex = 900,
		conditionType = 0,
		preWaves = {
			104,
			2002
		},
		triggerParams = {}
	},
	{
		triggerType = 10,
		waveIndex = 1000,
		conditionType = 0,
		preWaves = {
			100
		},
		triggerParam = {},
		blockFlags = {
			9600
		},
		spawn = {
			{
				delay = 8,
				prefab = "suligao_dengta_stg",
				life_time = 5,
				behaviours = 10024,
				IFF = 1,
				coordinate = {
					-15,
					0,
					55
				},
				cld_data = {
					30,
					60
				}
			},
			{
				delay = 20,
				prefab = "suligao_dengta_stg",
				life_time = 5,
				behaviours = 10024,
				IFF = 1,
				coordinate = {
					-15,
					0,
					55
				},
				cld_data = {
					30,
					60
				}
			},
			{
				delay = 34,
				prefab = "suligao_dengta_stg",
				life_time = 5,
				behaviours = 10024,
				IFF = 1,
				coordinate = {
					-15,
					0,
					55
				},
				cld_data = {
					30,
					60
				}
			}
		}
	}
}
var_0_1[1] = var_0_2
var_0_0.stages = var_0_1
var_0_0.fleet_prefab = {}

return var_0_0
