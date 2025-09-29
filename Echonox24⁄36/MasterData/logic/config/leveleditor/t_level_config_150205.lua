-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150205.lua

module("logic.config.leveleditor.t_level_config_150205", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "国坤爬塔暗面5",
	levelId = "150205",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔暗面2-5",
	lossConditionDesc = "",
	sceneId = "115002",
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
			x = 2,
			y = 9
		},
		{
			direction = 3,
			x = 3,
			y = 9
		},
		{
			direction = 3,
			x = 4,
			y = 9
		},
		{
			direction = 3,
			x = 10,
			y = 9
		},
		{
			direction = 3,
			x = 9,
			y = 8
		},
		{
			direction = 3,
			x = 10,
			y = 8
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
			groupName = "可恶的精英怪",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15020501,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 15020502,
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
			groupName = "很菜的雨伞",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 15020503,
					x = 11,
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
					monsterId = 15020503,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15020503,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15020503,
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
			groupName = "气人的治疗",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15020504,
					x = 11,
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
					monsterId = 15020504,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15020504,
					x = 6,
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
	monsters = {
		[15020501] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 143.7,
			maxHp = 48167,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 143.7,
			pre_meleeDef = 559,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 559,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1437,
			pre_meleeAtk = 1437,
			pre_maxHp = 48167,
			colorType = 3,
			monsterType = 1,
			id = 15020501,
			mobility = 2,
			pre_magicDef = 398,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 83,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 83,
			modelId = 120088,
			magicDef = 398,
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
		},
		[15020502] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 143.7,
			maxHp = 48167,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 143.7,
			pre_meleeDef = 559,
			sanity = 0,
			remark = "狙击精英（弧光额外弹射3次）",
			giftSkill = 1203002,
			weakPointHpRate = 0.3,
			meleeDef = 559,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1437,
			pre_meleeAtk = 1437,
			pre_maxHp = 48167,
			colorType = 3,
			monsterType = 1,
			id = 15020502,
			mobility = 2,
			pre_magicDef = 398,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 83,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 83,
			modelId = 120030,
			magicDef = 398,
			specialSkill = 1203003,
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
		[15020503] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 121.9,
			maxHp = 9020.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 121.9,
			pre_meleeDef = 540.9,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 540.9,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1219.1,
			pre_meleeAtk = 1219.1,
			pre_maxHp = 9020.1,
			colorType = 1,
			monsterType = 0,
			id = 15020503,
			mobility = 4,
			pre_magicDef = 355.5,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120089,
			magicDef = 355.5,
			specialSkill = 1208902,
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
		[15020504] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 1377,
			maxHp = 6760.4,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 1377,
			pre_meleeDef = 386.1,
			sanity = 0,
			remark = "支援小怪（行动结束时援护,援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 386.1,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 137.7,
			pre_meleeAtk = 137.7,
			pre_maxHp = 6760.4,
			colorType = 4,
			monsterType = 0,
			id = 15020504,
			mobility = 2,
			pre_magicDef = 540.9,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 60,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120031,
			magicDef = 540.9,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		}
	}
}

return configData
