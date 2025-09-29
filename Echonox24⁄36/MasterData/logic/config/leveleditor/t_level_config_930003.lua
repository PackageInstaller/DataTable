-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_930003.lua

module("logic.config.leveleditor.t_level_config_930003", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "新版断章2-2",
	levelId = "930003",
	plotEventGroup = 200103,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "备份断章1.4-3",
	lossConditionDesc = "",
	sceneId = "110001",
	winConditionDesc = "",
	forbidAction = {
		auto = false,
		move = false,
		strengthenSkill = false,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 1,
			x = 5,
			y = 2
		},
		{
			direction = 1,
			x = 5,
			y = 1
		},
		{
			direction = 1,
			x = 3,
			y = 2
		},
		{
			direction = 1,
			x = 2,
			y = 2
		},
		{
			direction = 1,
			x = 2,
			y = 1
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 4,
					y = 14
				},
				{
					x = 5,
					y = 14
				},
				{
					x = 6,
					y = 14
				},
				{
					x = 7,
					y = 14
				}
			}
		}
	},
	winConditionGroupList = {
		{
			tag = "101",
			isBackup = false,
			hasTag = true,
			winConditionList = {
				{
					round = 10,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "芭芭拉到达大空洞边缘",
					condition = 2,
					monsterIds = {}
				}
			}
		},
		{
			tag = "102",
			isBackup = true,
			hasTag = true,
			winConditionList = {
				{
					round = 10,
					heroId = 0,
					count = 3,
					monsterTag = "",
					DIYName = "",
					condition = 7,
					monsterIds = {}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 2,
			maxDeadCount = 0,
			count = 0,
			hasTag = false,
			DIYName = "",
			isBackup = false,
			tag = "",
			targetId = 2000053,
			monsterIds = {}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "1001",
			round = 1,
			hasSymbol = false,
			groupName = "OAD友军杂兵",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 12010211,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 12010212,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 12010213,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "2001",
			refreshType = 4,
			form = 2,
			plotStr = "1001",
			round = 2,
			hasSymbol = false,
			groupName = "第一批幻影",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "2001",
					monsterId = 93000301,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "2001",
					monsterId = 93000301,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "2001",
					monsterId = 93000301,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 93000301,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "2002",
			refreshType = 4,
			form = 4,
			plotStr = "1002",
			round = 6,
			hasSymbol = false,
			groupName = "第2批特异",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "2002",
					monsterId = 93000302,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "2002",
					monsterId = 93000302,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "2002",
					monsterId = 93000302,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "2003",
			refreshType = 4,
			form = 1,
			plotStr = "1003",
			round = 4,
			hasSymbol = false,
			groupName = "第3批坚甲",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "2003",
					monsterId = 12010205,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 13,
					tag = "2003",
					monsterId = 12010205,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 4,
			form = 1,
			plotStr = "1003",
			round = 1,
			hasSymbol = false,
			groupName = "坚甲精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "2003",
					monsterId = 12010206,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 7,
			hasSymbol = false,
			groupName = "吓唬人6",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 93000301,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 93000301,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 93000301,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 93000301,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 3,
			plotStr = "",
			round = 8,
			hasSymbol = false,
			groupName = "吓唬人5",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 93000303,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 93000303,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 93000303,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 93000303,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 9,
			hasSymbol = false,
			groupName = "吓唬人8",
			color = 6,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 93000301,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 93000301,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 4,
					tag = "",
					monsterId = 93000301,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 93000301,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 4,
			plotStr = "",
			round = 10,
			hasSymbol = false,
			groupName = "吓唬人7",
			color = 7,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 93000302,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 93000302,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 93000302,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 2000053,
			direction = 1,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 3,
				y = 2
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[93000301] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 9.1,
			maxHp = 388.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 9.1,
			pre_meleeDef = 66.6,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 66.6,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 91.5,
			pre_meleeAtk = 91.5,
			pre_maxHp = 388.9,
			colorType = 2,
			monsterType = 0,
			id = 93000301,
			mobility = 2,
			pre_magicDef = 30.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 30,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 30,
			modelId = 120090,
			magicDef = 30.6,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[93000302] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 9.7,
			maxHp = 286.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 9.7,
			pre_meleeDef = 54.9,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 54.9,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 96.7,
			pre_meleeAtk = 96.7,
			pre_maxHp = 286.1,
			colorType = 3,
			monsterType = 0,
			id = 93000302,
			mobility = 2,
			pre_magicDef = 30.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 120088,
			magicDef = 30.6,
			specialSkill = 1208802,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[93000303] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 14.5,
			maxHp = 849.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 14.5,
			pre_meleeDef = 71,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0.05,
			meleeDef = 71,
			level = 12,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 145.3,
			pre_meleeAtk = 145.3,
			pre_maxHp = 849.8,
			colorType = 3,
			monsterType = 1,
			id = 93000303,
			mobility = 2,
			pre_magicDef = 40,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 54,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 54,
			modelId = 120088,
			magicDef = 40,
			specialSkill = 1208802,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
