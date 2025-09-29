-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110143.lua

module("logic.config.leveleditor.t_level_config_110143", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110143",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "新困难1-5",
	lossConditionDesc = "",
	sceneId = "115007",
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
			y = 4
		},
		{
			direction = 1,
			x = 4,
			y = 4
		},
		{
			direction = 1,
			x = 6,
			y = 4
		},
		{
			direction = 1,
			x = 5,
			y = 6
		},
		{
			direction = 1,
			x = 4,
			y = 6
		},
		{
			direction = 1,
			x = 3,
			y = 4
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
			groupName = "前排伞组",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 11014301,
					x = 3,
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
					monsterId = 11014301,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 11014302,
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "后排灯组",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 11014303,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 11014304,
					x = 1,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11014304,
					x = 8,
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
		[11014301] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 12.3,
			maxHp = 484.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 12.3,
			pre_meleeDef = 71.1,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 71.1,
			level = 13,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 122.6,
			pre_meleeAtk = 122.6,
			pre_maxHp = 484.6,
			colorType = 1,
			monsterType = 0,
			id = 11014301,
			mobility = 4,
			pre_magicDef = 33.45,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 39.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 39.2,
			modelId = 120089,
			magicDef = 33.45,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		},
		[11014302] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 14.3,
			maxHp = 2295.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 14.3,
			pre_meleeDef = 83.7,
			sanity = 0,
			remark = "幻影精英怪（主动攻击时追击；位移再动追击强化）",
			giftSkill = 1208905,
			weakPointHpRate = 0.3,
			meleeDef = 83.7,
			level = 13,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 143.2,
			pre_meleeAtk = 143.2,
			pre_maxHp = 2295.6,
			colorType = 1,
			monsterType = 1,
			id = 11014302,
			mobility = 4,
			pre_magicDef = 39.3,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 44.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 44.7,
			modelId = 120089,
			magicDef = 39.3,
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
		[11014303] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 15.6,
			maxHp = 2040.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 15.6,
			pre_meleeDef = 75,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 75,
			level = 13,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 156.4,
			pre_meleeAtk = 156.4,
			pre_maxHp = 2040.5,
			colorType = 3,
			monsterType = 1,
			id = 11014303,
			mobility = 2,
			pre_magicDef = 40.3,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 54.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 54.7,
			modelId = 120088,
			magicDef = 40.3,
			specialSkill = 1208802,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			}
		},
		[11014304] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 12.7,
			maxHp = 423.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 12.7,
			pre_meleeDef = 63.75,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 63.75,
			level = 13,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 126.9,
			pre_meleeAtk = 126.9,
			pre_maxHp = 423.2,
			colorType = 3,
			monsterType = 0,
			id = 11014304,
			mobility = 2,
			pre_magicDef = 34.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 49.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 49.2,
			modelId = 120088,
			magicDef = 34.3,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			}
		}
	}
}

return configData
