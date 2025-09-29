-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150204.lua

module("logic.config.leveleditor.t_level_config_150204", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150204",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔暗面2-4",
	lossConditionDesc = "",
	sceneId = "110002",
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
			direction = 2,
			x = 3,
			y = 8
		},
		{
			direction = 2,
			x = 3,
			y = 7
		},
		{
			direction = 2,
			x = 3,
			y = 6
		},
		{
			direction = 2,
			x = 3,
			y = 5
		},
		{
			direction = 2,
			x = 3,
			y = 9
		},
		{
			direction = 1,
			x = 10,
			y = 7
		},
		{
			direction = 1,
			x = 11,
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
			groupName = "路障角兽精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15020402,
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
			groupName = "花剑雨伞",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 15020401,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 15020401,
					x = 8,
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
					monsterId = 15020401,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 15020401,
					x = 7,
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
					monsterId = 15020401,
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
			groupName = "狂欢路灯",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15020403,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 15020401,
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
			groupName = "奶妈",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 15020404,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 15020404,
					x = 9,
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
		[15020401] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 100.6,
			maxHp = 7109.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 100.6,
			pre_meleeDef = 478.8,
			sanity = 0,
			remark = "",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 478.8,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1005.2,
			pre_meleeAtk = 1005.2,
			pre_maxHp = 7109.9,
			colorType = 1,
			monsterType = 0,
			id = 15020401,
			mobility = 4,
			pre_magicDef = 289.2,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 67.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 0,
			monsterGroupEnum = 1,
			pre_inspire = 67.7,
			modelId = 120089,
			magicDef = 289.2,
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
		[15020402] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 93.4,
			maxHp = 53761.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 93.4,
			pre_meleeDef = 566.3,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 566.3,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 934.1,
			pre_meleeAtk = 934.1,
			pre_maxHp = 53761.9,
			colorType = 2,
			monsterType = 1,
			id = 15020402,
			mobility = 2,
			pre_magicDef = 322.3,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 60.7,
			modelId = 120090,
			magicDef = 322.3,
			specialSkill = 1209003,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		},
		[15020403] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 105.7,
			maxHp = 6138.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 105.7,
			pre_meleeDef = 443.4,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 443.4,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1057.8,
			pre_meleeAtk = 1057.8,
			pre_maxHp = 6138.2,
			colorType = 3,
			monsterType = 0,
			id = 15020403,
			mobility = 2,
			pre_magicDef = 291.9,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 77.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 0,
			monsterGroupEnum = 1,
			pre_inspire = 77.7,
			modelId = 120088,
			magicDef = 291.9,
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
		[15020404] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 1126.1,
			maxHp = 5328.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 1126.1,
			pre_meleeDef = 315.9,
			sanity = 0,
			remark = "",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 315.9,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 112.6,
			pre_meleeAtk = 112.6,
			pre_maxHp = 5328.8,
			colorType = 4,
			monsterType = 0,
			id = 15020404,
			mobility = 2,
			pre_magicDef = 478.8,
			aiStepOrder = 3,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 57.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 57.7,
			modelId = 120031,
			magicDef = 478.8,
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
