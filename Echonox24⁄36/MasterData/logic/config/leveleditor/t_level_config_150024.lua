-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150024.lua

module("logic.config.leveleditor.t_level_config_150024", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150024",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面24",
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
			direction = 1,
			x = 6,
			y = 0
		},
		{
			direction = 1,
			x = 7,
			y = 0
		},
		{
			direction = 1,
			x = 8,
			y = 0
		},
		{
			direction = 1,
			x = 9,
			y = 0
		},
		{
			direction = 1,
			x = 5,
			y = 0
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 2,
					tag = "",
					monsterId = 15002401,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 2,
					tag = "",
					monsterId = 15002402,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 15002403,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 15002402,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 15002405,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 1,
					tag = "",
					monsterId = 15002405,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 1,
					tag = "",
					monsterId = 15002405,
					x = 10,
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
		[15002401] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 529.7,
			maxHp = 10612.6,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 529.7,
			pre_meleeDef = 151,
			sanity = 0,
			remark = "",
			giftSkill = 1203103,
			weakPointHpRate = 0.25,
			meleeDef = 151,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 53,
			pre_meleeAtk = 53,
			pre_maxHp = 10612.6,
			colorType = 4,
			monsterType = 1,
			id = 15002401,
			mobility = 2,
			pre_magicDef = 252,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 48,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 48,
			modelId = 120031,
			magicDef = 252,
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
		[15002402] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 40.3,
			maxHp = 3397.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 40.3,
			pre_meleeDef = 206.1,
			sanity = 0,
			remark = "",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 206.1,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 403.1,
			pre_meleeAtk = 403.1,
			pre_maxHp = 3397.5,
			colorType = 3,
			monsterType = 0,
			id = 15002402,
			mobility = 2,
			pre_magicDef = 122.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120030,
			magicDef = 122.4,
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
		[15002403] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 437.9,
			maxHp = 2854.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 437.9,
			pre_meleeDef = 122.4,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 122.4,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 43.8,
			pre_meleeAtk = 43.8,
			pre_maxHp = 2854.7,
			colorType = 3,
			monsterType = 0,
			id = 15002403,
			mobility = 2,
			pre_magicDef = 206.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120029,
			magicDef = 206.1,
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
		[15002404] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 437.9,
			maxHp = 2854.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 437.9,
			pre_meleeDef = 122.4,
			sanity = 0,
			remark = "",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 122.4,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 43.8,
			pre_meleeAtk = 43.8,
			pre_maxHp = 2854.7,
			colorType = 1,
			monsterType = 0,
			id = 15002404,
			mobility = 2,
			pre_magicDef = 206.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 0,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120068,
			magicDef = 206.1,
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
		[15002405] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 37.5,
			maxHp = 4771.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 37.5,
			pre_meleeDef = 244.8,
			sanity = 0,
			remark = "",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 244.8,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 375.4,
			pre_meleeAtk = 375.4,
			pre_maxHp = 4771.9,
			colorType = 2,
			monsterType = 0,
			id = 15002405,
			mobility = 2,
			pre_magicDef = 121.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45,
			modelId = 120028,
			magicDef = 121.5,
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
