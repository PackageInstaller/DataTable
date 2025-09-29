-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150014.lua

module("logic.config.leveleditor.t_level_config_150014", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150014",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面14",
	lossConditionDesc = "",
	sceneId = "110001",
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
			x = 4,
			y = 8
		},
		{
			direction = 3,
			x = 3,
			y = 8
		},
		{
			direction = 3,
			x = 5,
			y = 8
		},
		{
			direction = 3,
			x = 13,
			y = 8
		},
		{
			direction = 3,
			x = 12,
			y = 8
		},
		{
			direction = 3,
			x = 11,
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 15001402,
					x = 8,
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
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15001404,
					x = 13,
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
					monsterId = 15001403,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15001404,
					x = 5,
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
					monsterId = 15001403,
					x = 4,
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
					monsterId = 15001404,
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
	monsters = {
		[15001401] = {
			normalSkill = 1201501,
			name = "虫态补光灯",
			pre_magicAtk = 36.6,
			maxHp = 9525.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 36.6,
			pre_meleeDef = 201,
			sanity = 0,
			remark = "",
			giftSkill = 1201502,
			weakPointHpRate = 0.25,
			meleeDef = 201,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 365.8,
			pre_meleeAtk = 365.8,
			pre_maxHp = 9525.4,
			colorType = 1,
			monsterType = 1,
			id = 15001401,
			mobility = 4,
			pre_magicDef = 114,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 53,
			modelId = 120015,
			magicDef = 114,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[15001402] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 29.9,
			maxHp = 3206,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 29.9,
			pre_meleeDef = 195.3,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 195.3,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 298.7,
			pre_meleeAtk = 298.7,
			pre_maxHp = 3206,
			colorType = 2,
			monsterType = 0,
			id = 15001402,
			mobility = 2,
			pre_magicDef = 102.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 40,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 40,
			modelId = 120067,
			magicDef = 102.6,
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
		[15001403] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 32.1,
			maxHp = 2269,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 32.1,
			pre_meleeDef = 164.7,
			sanity = 0,
			remark = "",
			giftSkill = 1201203,
			weakPointHpRate = 0,
			meleeDef = 164.7,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 320.6,
			pre_meleeAtk = 320.6,
			pre_maxHp = 2269,
			colorType = 3,
			monsterType = 0,
			id = 15001403,
			mobility = 2,
			pre_magicDef = 103.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120012,
			magicDef = 103.5,
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
		[15001404] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 348.1,
			maxHp = 1906.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 348.1,
			pre_meleeDef = 103.5,
			sanity = 0,
			remark = "",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 103.5,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 34.8,
			pre_meleeAtk = 34.8,
			pre_maxHp = 1906.5,
			colorType = 1,
			monsterType = 0,
			id = 15001404,
			mobility = 2,
			pre_magicDef = 164.7,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120068,
			magicDef = 164.7,
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
		}
	}
}

return configData
