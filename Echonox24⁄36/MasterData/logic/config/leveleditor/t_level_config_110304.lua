-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110304.lua

module("logic.config.leveleditor.t_level_config_110304", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110304",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "主线普通3-4",
	lossConditionDesc = "",
	sceneId = "111001",
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
			x = 13,
			y = 1
		},
		{
			direction = 1,
			x = 14,
			y = 2
		},
		{
			direction = 1,
			x = 12,
			y = 0
		},
		{
			direction = 1,
			x = 14,
			y = 0
		},
		{
			direction = 1,
			x = 12,
			y = 2
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
			groupName = "精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11030401,
					x = 13,
					initialStatus = {
						hpPercent = 100,
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
			groupName = "左侧雨伞怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 2,
					tag = "",
					monsterId = 11030403,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 0,
					tag = "",
					monsterId = 11030403,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 1,
					tag = "",
					monsterId = 11030403,
					x = 5,
					initialStatus = {
						hpPercent = 100,
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
			groupName = "第一回合接敌",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 11030402,
					x = 12,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 11030402,
					x = 14,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 11030402,
					x = 13,
					initialStatus = {
						hpPercent = 100,
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
			groupName = "精英伴生",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 11030403,
					x = 13,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 11030402,
					x = 14,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 5,
			y = 1
		},
		{
			x = 13,
			y = 8
		},
		{
			x = 13,
			y = 1
		}
	},
	lockHeroList = {},
	monsters = {
		[11030401] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 30.6,
			maxHp = 10910.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 30.6,
			pre_meleeDef = 201.8,
			sanity = 0,
			remark = "守卫精英（受到攻击后获得1层[坚韧]）",
			giftSkill = 1201402,
			weakPointHpRate = 0.3,
			meleeDef = 201.8,
			level = 26,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 305.9,
			pre_meleeAtk = 305.9,
			pre_maxHp = 10910.5,
			colorType = 2,
			monsterType = 1,
			id = 11030401,
			mobility = 2,
			pre_magicDef = 97.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 41.8,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 41.8,
			modelId = 120014,
			magicDef = 97.2,
			specialSkill = 1201404,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			}
		},
		[11030402] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 31.4,
			maxHp = 1646.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 31.4,
			pre_meleeDef = 181.6,
			sanity = 0,
			remark = "守卫小怪（主动攻击触发2次锥刺）",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 181.6,
			level = 26,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 313.9,
			pre_meleeAtk = 313.9,
			pre_maxHp = 1646.4,
			colorType = 2,
			monsterType = 0,
			id = 11030402,
			mobility = 2,
			pre_magicDef = 87.5,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 38.8,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.8,
			modelId = 120067,
			magicDef = 87.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			}
		},
		[11030403] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 32.7,
			maxHp = 1342.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 32.7,
			pre_meleeDef = 168.7,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 168.7,
			level = 26,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 326.9,
			pre_meleeAtk = 326.9,
			pre_maxHp = 1342.2,
			colorType = 1,
			monsterType = 0,
			id = 11030403,
			mobility = 4,
			pre_magicDef = 86.8,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 48.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 48.8,
			modelId = 120089,
			magicDef = 86.8,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		}
	}
}

return configData
