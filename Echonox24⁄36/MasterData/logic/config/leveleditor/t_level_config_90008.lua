-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_90008.lua

module("logic.config.leveleditor.t_level_config_90008", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "90008",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "迭代体验",
	lossConditionDesc = "",
	sceneId = "108001",
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
			y = 8
		},
		{
			direction = 1,
			x = 6,
			y = 8
		},
		{
			direction = 1,
			x = 5,
			y = 7
		},
		{
			direction = 1,
			x = 6,
			y = 7
		},
		{
			direction = 1,
			x = 7,
			y = 7
		}
	},
	additionalTerrainList = {},
	winConditionGroupList = {
		{
			tag = "",
			isBackup = false,
			hasTag = false,
			winConditionList = {
				{
					round = 10,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 1,
					monsterIds = {}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 1,
			maxDeadCount = 0,
			count = 0,
			hasTag = false,
			DIYName = "",
			isBackup = false,
			tag = "",
			targetId = 0,
			monsterIds = {}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "Boss",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 9000801,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 6,
			y = 10
		}
	},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 1,
			heroType = 2,
			monsterId = 9000802,
			pos = {
				x = 5,
				y = 8
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 1,
			heroType = 2,
			monsterId = 9000803,
			pos = {
				x = 5,
				y = 7
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 1,
			heroType = 2,
			monsterId = 9000804,
			pos = {
				x = 6,
				y = 7
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 1,
			heroType = 2,
			monsterId = 9000805,
			pos = {
				x = 6,
				y = 8
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 1,
			heroType = 2,
			monsterId = 9000806,
			pos = {
				x = 7,
				y = 7
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[9000801] = {
			normalSkill = 1101115,
			name = "失控一云",
			pre_magicAtk = 118.1,
			maxHp = 7134.6,
			aiName = "boss_atzero_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 118.1,
			pre_meleeDef = 64.8,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.23,
			meleeDef = 64.8,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 284.2,
			pre_meleeAtk = 284.2,
			pre_maxHp = 7134.6,
			colorType = 1,
			monsterType = 2,
			id = 9000801,
			mobility = 2,
			pre_magicDef = 59.8,
			aiStepOrder = 0,
			trumpSkill = 1101117,
			isFuzzy = false,
			inspire = 26.4,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 26.4,
			modelId = 120099,
			magicDef = 59.8,
			specialSkill = 1101116,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[9000802] = {
			normalSkill = 1101111,
			name = "一云",
			pre_magicAtk = 60.6,
			maxHp = 498.4,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 60.6,
			pre_meleeDef = 66.4,
			sanity = 0,
			remark = "",
			giftSkill = 1101114,
			weakPointHpRate = 0,
			meleeDef = 66.4,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 180.8,
			pre_meleeAtk = 180.8,
			pre_maxHp = 498.4,
			colorType = 1,
			monsterType = 0,
			id = 9000802,
			mobility = 3,
			pre_magicDef = 51.5,
			aiStepOrder = 0,
			trumpSkill = 1101113,
			isFuzzy = false,
			inspire = 21.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 21.5,
			modelId = 100011,
			magicDef = 51.5,
			specialSkill = 1101112,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[9000803] = {
			normalSkill = 1105605,
			name = "提亚",
			pre_magicAtk = 159.7,
			maxHp = 451.4,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 159.7,
			pre_meleeDef = 56.7,
			sanity = 0,
			remark = "",
			giftSkill = 1105608,
			weakPointHpRate = 0,
			meleeDef = 56.7,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 73,
			pre_meleeAtk = 73,
			pre_maxHp = 451.4,
			colorType = 4,
			monsterType = 0,
			id = 9000803,
			mobility = 2,
			pre_magicDef = 57.7,
			aiStepOrder = 0,
			trumpSkill = 1105607,
			isFuzzy = false,
			inspire = 19.2,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 19.2,
			modelId = 100056,
			magicDef = 57.7,
			specialSkill = 1105606,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		},
		[9000804] = {
			normalSkill = 1105307,
			name = "阿妮亚",
			pre_magicAtk = 130.2,
			maxHp = 405.4,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 130.2,
			pre_meleeDef = 48.5,
			sanity = 0,
			remark = "",
			giftSkill = 1105310,
			weakPointHpRate = 0,
			meleeDef = 48.5,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 68.5,
			pre_meleeAtk = 68.5,
			pre_maxHp = 405.4,
			colorType = 4,
			monsterType = 0,
			id = 9000804,
			mobility = 2,
			pre_magicDef = 60.7,
			aiStepOrder = 0,
			trumpSkill = 1105309,
			isFuzzy = false,
			inspire = 12.7,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 12.7,
			modelId = 100053,
			magicDef = 60.7,
			specialSkill = 1105308,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		},
		[9000805] = {
			normalSkill = 1102006,
			name = "安布蕾拉",
			pre_magicAtk = 57.2,
			maxHp = 576.5,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 2,
			magicAtk = 57.2,
			pre_meleeDef = 73,
			sanity = 0,
			remark = "",
			giftSkill = 1102009,
			weakPointHpRate = 0,
			meleeDef = 73,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 147.4,
			pre_meleeAtk = 147.4,
			pre_maxHp = 576.5,
			colorType = 2,
			monsterType = 0,
			id = 9000805,
			mobility = 2,
			pre_magicDef = 54.3,
			aiStepOrder = 0,
			trumpSkill = 1102008,
			isFuzzy = false,
			inspire = 15.3,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 15.3,
			modelId = 100020,
			magicDef = 54.3,
			specialSkill = 1102007,
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
		[9000806] = {
			normalSkill = 1101206,
			name = "芬里尔",
			pre_magicAtk = 214.8,
			maxHp = 406.6,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 214.8,
			pre_meleeDef = 52.3,
			sanity = 0,
			remark = "",
			giftSkill = 1101209,
			weakPointHpRate = 0,
			meleeDef = 52.3,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 77.2,
			pre_meleeAtk = 77.2,
			pre_maxHp = 406.6,
			colorType = 1,
			monsterType = 0,
			id = 9000806,
			mobility = 2,
			pre_magicDef = 66.5,
			aiStepOrder = 0,
			trumpSkill = 1101208,
			isFuzzy = false,
			inspire = 30.8,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 30.8,
			modelId = 100012,
			magicDef = 66.5,
			specialSkill = 1101207,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		}
	}
}

return configData
