-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_960006.lua

module("logic.config.leveleditor.t_level_config_960006", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "960006",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "CPJ-H2.6",
	lossConditionDesc = "",
	sceneId = "109006",
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
			x = 5,
			y = 3
		},
		{
			direction = 1,
			x = 6,
			y = 4
		},
		{
			direction = 3,
			x = 7,
			y = 3
		},
		{
			direction = 3,
			x = 8,
			y = 3
		},
		{
			direction = 1,
			x = 7,
			y = 4
		},
		{
			direction = 3,
			x = 6,
			y = 3
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
			groupName = "后排高压力怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 96000601,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 96000601,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 96000604,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 96000602,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 96000603,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[96000601] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 15.3,
			maxHp = 2487.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 15.3,
			pre_meleeDef = 90.3,
			sanity = 0,
			remark = "幻影精英怪（主动攻击时追击；位移再动追击强化）",
			giftSkill = 1208905,
			weakPointHpRate = 0.3,
			meleeDef = 90.3,
			level = 14,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 152.7,
			pre_meleeAtk = 152.7,
			pre_maxHp = 2487.8,
			colorType = 1,
			monsterType = 1,
			id = 96000601,
			mobility = 4,
			pre_magicDef = 40.7,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 45.3,
			modelId = 120089,
			magicDef = 40.7,
			specialSkill = 1208904,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			}
		},
		[96000602] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 13.8,
			maxHp = 2985.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 13.8,
			pre_meleeDef = 98.3,
			sanity = 0,
			remark = "守卫精英（振荡2次；范围变大）",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 98.3,
			level = 14,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 138.2,
			pre_meleeAtk = 138.2,
			pre_maxHp = 2985.3,
			colorType = 2,
			monsterType = 1,
			id = 96000602,
			mobility = 2,
			pre_magicDef = 41,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 35.3,
			modelId = 120090,
			magicDef = 41,
			specialSkill = 1209003,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			}
		},
		[96000603] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 13.5,
			maxHp = 462.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 13.5,
			pre_meleeDef = 68.85,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 68.85,
			level = 14,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 135.5,
			pre_meleeAtk = 135.5,
			pre_maxHp = 462.7,
			colorType = 3,
			monsterType = 0,
			id = 96000603,
			mobility = 2,
			pre_magicDef = 35.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 49.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 49.8,
			modelId = 120088,
			magicDef = 35.4,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			}
		},
		[96000604] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 13.1,
			maxHp = 528.15,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 13.1,
			pre_meleeDef = 76.8,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 76.8,
			level = 14,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 131,
			pre_meleeAtk = 131,
			pre_maxHp = 528.15,
			colorType = 1,
			monsterType = 0,
			id = 96000604,
			mobility = 4,
			pre_magicDef = 34.55,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 39.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 39.8,
			modelId = 120089,
			magicDef = 34.55,
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
