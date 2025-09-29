-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150054.lua

module("logic.config.leveleditor.t_level_config_150054", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150054",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面54",
	lossConditionDesc = "",
	sceneId = "112003",
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
			x = 6,
			y = 13
		},
		{
			direction = 3,
			x = 5,
			y = 13
		},
		{
			direction = 3,
			x = 4,
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
			groupName = "幻影小怪",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 11,
					tag = "",
					monsterId = 15005404,
					x = 1,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 15005404,
					x = 5,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 15005404,
					x = 6,
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
					y = 10,
					tag = "",
					monsterId = 15005403,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 10,
					tag = "",
					monsterId = 15005403,
					x = 9,
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
			groupName = "狙击小怪",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 11,
					tag = "",
					monsterId = 15005402,
					x = 4,
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
					monsterId = 15005402,
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
			groupName = "陨灭精英",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 15005401,
					x = 8,
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
		[15005401] = {
			normalSkill = 1208101,
			name = "拟态/葵",
			pre_magicAtk = 130.8,
			maxHp = 37651.6,
			aiName = "ai_120081_尖刺",
			battleCamp = 1,
			career = 5,
			magicAtk = 1307.8,
			pre_meleeDef = 559.7,
			sanity = 0,
			remark = "陨灭精英",
			giftSkill = 1208103,
			weakPointHpRate = 0.3,
			meleeDef = 430,
			level = 68,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 130.8,
			pre_meleeAtk = 1307.8,
			pre_maxHp = 37651.6,
			colorType = 4,
			monsterType = 1,
			id = 15005401,
			mobility = 1,
			pre_magicDef = 430.7,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 72.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 72.3,
			modelId = 120081,
			magicDef = 559.7,
			specialSkill = 1208104,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"B",
				"A",
				"A"
			},
			tags = {}
		},
		[15005402] = {
			normalSkill = 1207001,
			name = "彩绘积木",
			pre_magicAtk = 120.9,
			maxHp = 7090.6,
			aiName = "ai_120070_涂鸦积木",
			battleCamp = 1,
			career = 3,
			magicAtk = 120.9,
			pre_meleeDef = 486.9,
			sanity = 0,
			remark = "狙击小怪",
			giftSkill = 1207003,
			weakPointHpRate = 0,
			meleeDef = 486.9,
			level = 68,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1209.5,
			pre_meleeAtk = 1209.5,
			pre_maxHp = 7090.6,
			colorType = 3,
			monsterType = 0,
			id = 15005402,
			mobility = 2,
			pre_magicDef = 345.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 79.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 79.3,
			modelId = 120070,
			magicDef = 345.6,
			specialSkill = 0,
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
		[15005403] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 109.5,
			maxHp = 10260.6,
			aiName = "ai_120067_冲锋路桩",
			battleCamp = 1,
			career = 2,
			magicAtk = 109.5,
			pre_meleeDef = 555.6,
			sanity = 0,
			remark = "守卫小怪（主动攻击触发2次锥刺）",
			giftSkill = 1206702,
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
			id = 15005403,
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
			modelId = 120067,
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
		},
		[15005404] = {
			normalSkill = 1201601,
			name = "巡逻道闸",
			pre_magicAtk = 114.7,
			maxHp = 8246.4,
			aiName = "ai_120016_巡逻道闸",
			battleCamp = 1,
			career = 1,
			magicAtk = 114.7,
			pre_meleeDef = 523.5,
			sanity = 0,
			remark = "幻影小怪",
			giftSkill = 1201602,
			weakPointHpRate = 0,
			meleeDef = 523.5,
			level = 68,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1146.8,
			pre_meleeAtk = 1146.8,
			pre_maxHp = 8246.4,
			colorType = 1,
			monsterType = 0,
			id = 15005404,
			mobility = 4,
			pre_magicDef = 342.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 69.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 69.3,
			modelId = 120016,
			magicDef = 342.9,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
