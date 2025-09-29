-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_151007.lua

module("logic.config.leveleditor.t_level_config_151007", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "151007",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "样板爬塔7",
	lossConditionDesc = "",
	sceneId = "108003",
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
			x = 5,
			y = 3
		},
		{
			direction = 2,
			x = 6,
			y = 3
		},
		{
			direction = 2,
			x = 4,
			y = 3
		},
		{
			direction = 2,
			x = 5,
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
					count = 1,
					monsterTag = "",
					DIYName = "",
					condition = 7,
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
			groupName = "核心守卫",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15100701,
					x = 5,
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
			groupName = "两侧陨灭",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15100702,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15100702,
					x = 1,
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "后排单位",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 15100703,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 15100703,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 15100704,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 15100704,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 5,
			y = 12
		},
		{
			x = 5,
			y = 6
		}
	},
	lockHeroList = {},
	monsters = {
		[15100701] = {
			normalSkill = 1282101,
			name = "禁行隔离墩",
			pre_magicAtk = 92.5,
			maxHp = 813.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 92.5,
			pre_meleeDef = 118.3,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 118.3,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 229.8,
			pre_meleeAtk = 229.8,
			pre_maxHp = 813.6,
			colorType = 2,
			monsterType = 1,
			id = 15100701,
			mobility = 2,
			pre_magicDef = 50.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 20.9,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 20.9,
			modelId = 120014,
			magicDef = 50.8,
			specialSkill = 1282102,
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
		[15100702] = {
			normalSkill = 1281001,
			name = "斑驳轮胎",
			pre_magicAtk = 111,
			maxHp = 195.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 111,
			pre_meleeDef = 76.2,
			sanity = 0,
			remark = "",
			giftSkill = 1281002,
			weakPointHpRate = 0,
			meleeDef = 76.2,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 277.4,
			pre_meleeAtk = 277.4,
			pre_maxHp = 195.6,
			colorType = 4,
			monsterType = 0,
			id = 15100702,
			mobility = 1,
			pre_magicDef = 76.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.4,
			modelId = 120012,
			magicDef = 76.2,
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
		},
		[15100703] = {
			normalSkill = 1280601,
			name = "斑驳轮胎",
			pre_magicAtk = 111,
			maxHp = 178.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 111,
			pre_meleeDef = 68,
			sanity = 0,
			remark = "",
			giftSkill = 1280602,
			weakPointHpRate = 0,
			meleeDef = 68,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 277.4,
			pre_meleeAtk = 277.4,
			pre_maxHp = 178.3,
			colorType = 3,
			monsterType = 0,
			id = 15100703,
			mobility = 2,
			pre_magicDef = 51.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 31.9,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 31.9,
			modelId = 120012,
			magicDef = 51.5,
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
		[15100704] = {
			normalSkill = 1280101,
			name = "虫态补光灯",
			pre_magicAtk = 100.4,
			maxHp = 235.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 100.4,
			pre_meleeDef = 64.8,
			sanity = 0,
			remark = "",
			giftSkill = 1280102,
			weakPointHpRate = 0,
			meleeDef = 64.8,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 255,
			pre_meleeAtk = 255,
			pre_maxHp = 235.4,
			colorType = 1,
			monsterType = 0,
			id = 15100704,
			mobility = 3,
			pre_magicDef = 59.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.4,
			modelId = 120015,
			magicDef = 59.8,
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
