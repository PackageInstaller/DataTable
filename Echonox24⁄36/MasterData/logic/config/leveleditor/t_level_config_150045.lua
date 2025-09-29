-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150045.lua

module("logic.config.leveleditor.t_level_config_150045", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150045",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面45",
	lossConditionDesc = "",
	sceneId = "109002",
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
			x = 5,
			y = 5
		},
		{
			direction = 4,
			x = 5,
			y = 6
		},
		{
			direction = 4,
			x = 5,
			y = 4
		},
		{
			direction = 3,
			x = 11,
			y = 5
		},
		{
			direction = 3,
			x = 10,
			y = 5
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "特异精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 15004501,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "狙击精英",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 15004502,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "支援小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 15004503,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 4,
					tag = "",
					monsterId = 15004503,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "守卫小怪",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 15004504,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[15004501] = {
			normalSkill = 1209301,
			name = "自裁气球",
			pre_magicAtk = 1039.6,
			maxHp = 26738,
			aiName = "ai_120093_自裁气球",
			battleCamp = 1,
			career = 4,
			magicAtk = 1039.6,
			pre_meleeDef = 260,
			sanity = 0,
			remark = "蓝特异精英（禁疗）",
			giftSkill = 1209302,
			weakPointHpRate = 0.3,
			meleeDef = 260,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 104,
			pre_meleeAtk = 104,
			pre_maxHp = 26738,
			colorType = 2,
			monsterType = 1,
			id = 15004501,
			mobility = 2,
			pre_magicDef = 385,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 78,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 78,
			modelId = 120093,
			magicDef = 385,
			specialSkill = 0,
			extraSkills = {
				1209303
			},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[15004502] = {
			normalSkill = 1207001,
			name = "彩绘积木",
			pre_magicAtk = 94,
			maxHp = 31822,
			aiName = "ai_120070_涂鸦积木",
			battleCamp = 1,
			career = 3,
			magicAtk = 94,
			pre_meleeDef = 385,
			sanity = 0,
			remark = "狙击精英",
			giftSkill = 1207003,
			weakPointHpRate = 0.3,
			meleeDef = 385,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 940.1,
			pre_meleeAtk = 940.1,
			pre_maxHp = 31822,
			colorType = 3,
			monsterType = 1,
			id = 15004502,
			mobility = 2,
			pre_magicDef = 260,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 78,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 78,
			modelId = 120070,
			magicDef = 260,
			specialSkill = 1207004,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[15004503] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 988.1,
			maxHp = 22880.8,
			aiName = "ai_120031_再生",
			battleCamp = 1,
			career = 6,
			magicAtk = 988.1,
			pre_meleeDef = 284,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 284,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 98.8,
			pre_meleeAtk = 98.8,
			pre_maxHp = 22880.8,
			colorType = 4,
			monsterType = 0,
			id = 15004503,
			mobility = 2,
			pre_magicDef = 417,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 58,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 58,
			modelId = 120031,
			magicDef = 417,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[15004504] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 76.8,
			maxHp = 7272.7,
			aiName = "ai_120067_冲锋路桩",
			battleCamp = 1,
			career = 2,
			magicAtk = 76.8,
			pre_meleeDef = 400.5,
			sanity = 0,
			remark = "守卫小怪（主动攻击触发2次锥刺）",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 400.5,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 767.9,
			pre_meleeAtk = 767.9,
			pre_maxHp = 7272.7,
			colorType = 2,
			monsterType = 0,
			id = 15004504,
			mobility = 2,
			pre_magicDef = 232.2,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120067,
			magicDef = 232.2,
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
		}
	}
}

return configData
