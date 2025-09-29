-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150019.lua

module("logic.config.leveleditor.t_level_config_150019", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150019",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面19",
	lossConditionDesc = "",
	sceneId = "109003",
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
			x = 1,
			y = 2
		},
		{
			direction = 1,
			x = 2,
			y = 2
		},
		{
			direction = 2,
			x = 9,
			y = 2
		},
		{
			direction = 2,
			x = 9,
			y = 1
		},
		{
			direction = 1,
			x = 7,
			y = 5
		},
		{
			direction = 1,
			x = 8,
			y = 5
		},
		{
			direction = 1,
			x = 9,
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 15001901,
					x = 0,
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
					monsterId = 15001902,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 15001903,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 15001901,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 15001902,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 15001903,
					x = 13,
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
			groupName = "怪物组2",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 15001904,
					x = 7,
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
		[15001901] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 33.1,
			maxHp = 4267.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 33.1,
			pre_meleeDef = 213.3,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 213.3,
			level = 35,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 330.9,
			pre_meleeAtk = 330.9,
			pre_maxHp = 4267.2,
			colorType = 2,
			monsterType = 0,
			id = 15001901,
			mobility = 2,
			pre_magicDef = 112.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 42,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 42,
			modelId = 120090,
			magicDef = 112.5,
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
		[15001902] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 35.6,
			maxHp = 2986.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 35.6,
			pre_meleeDef = 180.9,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 180.9,
			level = 35,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 355.8,
			pre_meleeAtk = 355.8,
			pre_maxHp = 2986.8,
			colorType = 3,
			monsterType = 0,
			id = 15001902,
			mobility = 2,
			pre_magicDef = 113.4,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 62,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 62,
			modelId = 120088,
			magicDef = 113.4,
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
		[15001903] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 34.2,
			maxHp = 3453.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 34.2,
			pre_meleeDef = 198,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 198,
			level = 35,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 342.2,
			pre_meleeAtk = 342.2,
			pre_maxHp = 3453.1,
			colorType = 1,
			monsterType = 0,
			id = 15001903,
			mobility = 4,
			pre_magicDef = 111.6,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 52,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 52,
			modelId = 120089,
			magicDef = 111.6,
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
		[15001904] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 36.4,
			maxHp = 15498.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 36.4,
			pre_meleeDef = 237,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0.25,
			meleeDef = 237,
			level = 35,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 363.6,
			pre_meleeAtk = 363.6,
			pre_maxHp = 15498.6,
			colorType = 2,
			monsterType = 1,
			id = 15001904,
			mobility = 2,
			pre_magicDef = 125,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 45,
			modelId = 120090,
			magicDef = 125,
			specialSkill = 1209003,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			}
		}
	}
}

return configData
