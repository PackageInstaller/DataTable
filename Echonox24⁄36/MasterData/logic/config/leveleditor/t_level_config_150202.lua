-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150202.lua

module("logic.config.leveleditor.t_level_config_150202", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150202",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔暗面2-2",
	lossConditionDesc = "",
	sceneId = "115001",
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
			x = 6,
			y = 1
		},
		{
			direction = 1,
			x = 7,
			y = 1
		},
		{
			direction = 1,
			x = 8,
			y = 1
		},
		{
			direction = 1,
			x = 9,
			y = 1
		},
		{
			direction = 1,
			x = 5,
			y = 1
		},
		{
			direction = 3,
			x = 6,
			y = 7
		},
		{
			direction = 3,
			x = 8,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "精英超感怪",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 15020202,
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
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "拦路幻影",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 15020203,
					x = 3,
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
					monsterId = 15020203,
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
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "装甲军",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 15020201,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 15020201,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 15020201,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	trialHeroes = {},
	monsters = {
		[15020201] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 76.9,
			maxHp = 4539.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 76.9,
			pre_meleeDef = 333.9,
			sanity = 0,
			remark = "",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 333.9,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 768.7,
			pre_meleeAtk = 768.7,
			pre_maxHp = 4539.7,
			colorType = 4,
			monsterType = 0,
			id = 15020201,
			mobility = 1,
			pre_magicDef = 246.6,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 0,
			monsterGroupEnum = 1,
			pre_inspire = 63,
			modelId = 120069,
			magicDef = 246.6,
			specialSkill = 1206902,
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
		[15020202] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 969.1,
			maxHp = 23655.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 969.1,
			pre_meleeDef = 238,
			sanity = 0,
			remark = "",
			giftSkill = 1206802,
			weakPointHpRate = 0.3,
			meleeDef = 238,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 96.9,
			pre_meleeAtk = 96.9,
			pre_maxHp = 23655.6,
			colorType = 1,
			monsterType = 1,
			id = 15020202,
			mobility = 2,
			pre_magicDef = 357,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 76,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 76,
			modelId = 120068,
			magicDef = 357,
			specialSkill = 1206803,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[15020203] = {
			normalSkill = 1201501,
			name = "虫态补光灯",
			pre_magicAtk = 74.9,
			maxHp = 5130.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 74.9,
			pre_meleeDef = 348.3,
			sanity = 0,
			remark = "",
			giftSkill = 1201502,
			weakPointHpRate = 0,
			meleeDef = 348.3,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 748.6,
			pre_meleeAtk = 748.6,
			pre_maxHp = 5130.3,
			colorType = 1,
			monsterType = 0,
			id = 15020203,
			mobility = 4,
			pre_magicDef = 212.4,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 63,
			modelId = 120015,
			magicDef = 212.4,
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
