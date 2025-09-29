-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150056.lua

module("logic.config.leveleditor.t_level_config_150056", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150056",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面56",
	lossConditionDesc = "",
	sceneId = "113002",
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
			direction = 3,
			x = 8,
			y = 13
		},
		{
			direction = 3,
			x = 9,
			y = 13
		},
		{
			direction = 3,
			x = 10,
			y = 13
		},
		{
			direction = 3,
			x = 11,
			y = 13
		},
		{
			direction = 3,
			x = 13,
			y = 13
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
			form = 5,
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
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 15005601,
					x = 12,
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
			groupName = "特异小怪",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 14,
					tag = "",
					monsterId = 15005602,
					x = 4,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 13,
					tag = "",
					monsterId = 15005602,
					x = 4,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 12,
					tag = "",
					monsterId = 15005602,
					x = 4,
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
			groupName = "陨灭小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 15005603,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 15005603,
					x = 11,
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
					y = 11,
					tag = "",
					monsterId = 15005604,
					x = 11,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 11,
					tag = "",
					monsterId = 15005604,
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
		[15005601] = {
			normalSkill = 1208201,
			name = "拟态/蚺",
			pre_magicAtk = 1491.3,
			maxHp = 37052,
			aiName = "ai_120082_假死",
			battleCamp = 1,
			career = 4,
			magicAtk = 1491.3,
			pre_meleeDef = 384,
			sanity = 0,
			remark = "特异精英",
			giftSkill = 1208202,
			weakPointHpRate = 0.3,
			meleeDef = 384,
			level = 68,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 149.1,
			pre_meleeAtk = 149.1,
			pre_maxHp = 37052,
			colorType = 2,
			monsterType = 1,
			id = 15005601,
			mobility = 2,
			pre_magicDef = 541,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 82.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 82.3,
			modelId = 120082,
			magicDef = 541,
			specialSkill = 0,
			extraSkills = {
				1208203
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
		[15005602] = {
			normalSkill = 1208201,
			name = "拟态/蚺",
			pre_magicAtk = 1354,
			maxHp = 5957.8,
			aiName = "ai_120082_假死",
			battleCamp = 1,
			career = 4,
			magicAtk = 1354,
			pre_meleeDef = 345.6,
			sanity = 0,
			remark = "特异小怪",
			giftSkill = 1208202,
			weakPointHpRate = 0,
			meleeDef = 345.6,
			level = 68,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 135.4,
			pre_meleeAtk = 135.4,
			pre_maxHp = 5957.8,
			colorType = 2,
			monsterType = 0,
			id = 15005602,
			mobility = 2,
			pre_magicDef = 486.9,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 79.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 79.3,
			modelId = 120082,
			magicDef = 486.9,
			specialSkill = 0,
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
		[15005603] = {
			normalSkill = 1208101,
			name = "拟态/葵",
			pre_magicAtk = 1178.1,
			maxHp = 7297.7,
			aiName = "ai_120081_尖刺",
			battleCamp = 1,
			career = 5,
			magicAtk = 1178.1,
			pre_meleeDef = 387.6,
			sanity = 0,
			remark = "陨灭小怪",
			giftSkill = 1208103,
			weakPointHpRate = 0,
			meleeDef = 387.6,
			level = 68,
			monsterGroup = "法术陨灭小怪",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 117.8,
			pre_meleeAtk = 117.8,
			pre_maxHp = 7297.7,
			colorType = 4,
			monsterType = 0,
			id = 15005603,
			mobility = 1,
			pre_magicDef = 503.7,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 69.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 6,
			pre_inspire = 69.3,
			modelId = 120081,
			magicDef = 503.7,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"C",
				"C",
				"B",
				"B"
			},
			tags = {}
		},
		[15005604] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 109.5,
			maxHp = 10260.6,
			aiName = "ai_120014_禁行隔离墩",
			battleCamp = 1,
			career = 2,
			magicAtk = 109.5,
			pre_meleeDef = 555.6,
			sanity = 0,
			remark = "守卫小怪（受到攻击后锥刺）",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 555.6,
			level = 68,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1094.4,
			pre_meleeAtk = 1094.4,
			pre_maxHp = 10260.6,
			colorType = 2,
			monsterType = 0,
			id = 15005604,
			mobility = 2,
			pre_magicDef = 343.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.3,
			modelId = 120014,
			magicDef = 343.8,
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
