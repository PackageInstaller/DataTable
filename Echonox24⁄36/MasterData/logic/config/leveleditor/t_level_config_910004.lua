-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_910004.lua

module("logic.config.leveleditor.t_level_config_910004", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "910004",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "全局技能特效测试",
	lossConditionDesc = "",
	sceneId = "109001",
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
			direction = 4,
			x = 8,
			y = 8
		},
		{
			direction = 4,
			x = 9,
			y = 7
		},
		{
			direction = 4,
			x = 8,
			y = 6
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
	globalSkillCodeList = {
		1290631,
		1290632,
		1290633,
		1290634,
		1290635
	},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 91000401,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 91000401,
					x = 4,
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
					monsterId = 91000402,
					x = 4,
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
			heroId = -1,
			direction = 4,
			heroType = 2,
			monsterId = 91000403,
			pos = {
				x = 8,
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
			direction = 4,
			heroType = 2,
			monsterId = 91000403,
			pos = {
				x = 9,
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
			direction = 4,
			heroType = 2,
			monsterId = 91000404,
			pos = {
				x = 8,
				y = 6
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[91000401] = {
			normalSkill = 1101601,
			name = "烟火",
			pre_magicAtk = 206.4,
			maxHp = 112.8,
			aiName = "auto_yanhuo_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 206.4,
			pre_meleeDef = 32.5,
			sanity = 0,
			remark = "",
			giftSkill = 1101604,
			weakPointHpRate = 0,
			meleeDef = 32.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.6,
			pre_meleeAtk = 82.6,
			pre_maxHp = 112.8,
			colorType = 1,
			monsterType = 0,
			id = 91000401,
			mobility = 3,
			pre_magicDef = 49.5,
			aiStepOrder = 20,
			trumpSkill = 1101603,
			isFuzzy = false,
			inspire = 26.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 100016,
			magicDef = 49.5,
			specialSkill = 1101602,
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
		[91000402] = {
			normalSkill = 1101201,
			name = "芬里尔",
			pre_magicAtk = 206.4,
			maxHp = 112.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 206.4,
			pre_meleeDef = 32.5,
			sanity = 0,
			remark = "",
			giftSkill = 1101204,
			weakPointHpRate = 0,
			meleeDef = 32.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.6,
			pre_meleeAtk = 82.6,
			pre_maxHp = 112.8,
			colorType = 3,
			monsterType = 0,
			id = 91000402,
			mobility = 2,
			pre_magicDef = 49.5,
			aiStepOrder = 20,
			trumpSkill = 1101203,
			isFuzzy = false,
			inspire = 26.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 100012,
			magicDef = 49.5,
			specialSkill = 1101202,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		},
		[91000403] = {
			normalSkill = 1102001,
			name = "安布蕾拉",
			pre_magicAtk = 206.4,
			maxHp = 112.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 206.4,
			pre_meleeDef = 32.5,
			sanity = 0,
			remark = "",
			giftSkill = 1102004,
			weakPointHpRate = 0,
			meleeDef = 32.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.6,
			pre_meleeAtk = 82.6,
			pre_maxHp = 112.8,
			colorType = 2,
			monsterType = 0,
			id = 91000403,
			mobility = 2,
			pre_magicDef = 49.5,
			aiStepOrder = 20,
			trumpSkill = 1102003,
			isFuzzy = false,
			inspire = 26.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 100020,
			magicDef = 49.5,
			specialSkill = 1102002,
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
		[91000404] = {
			normalSkill = 1102201,
			name = "飞鸟",
			pre_magicAtk = 206.4,
			maxHp = 112.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 206.4,
			pre_meleeDef = 32.5,
			sanity = 0,
			remark = "",
			giftSkill = 1102204,
			weakPointHpRate = 0,
			meleeDef = 32.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.6,
			pre_meleeAtk = 82.6,
			pre_maxHp = 112.8,
			colorType = 3,
			monsterType = 0,
			id = 91000404,
			mobility = 2,
			pre_magicDef = 49.5,
			aiStepOrder = 20,
			trumpSkill = 1102203,
			isFuzzy = false,
			inspire = 26.9,
			camp = 4,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 100022,
			magicDef = 49.5,
			specialSkill = 1102202,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
