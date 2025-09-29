-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_920001.lua

module("logic.config.leveleditor.t_level_config_920001", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "920001",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "LJL个人1",
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
			direction = 1,
			x = 5,
			y = 5
		},
		{
			direction = 1,
			x = 7,
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
					condition = 3,
					monsterIds = {
						92000101
					}
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
					y = 12,
					tag = "",
					monsterId = 92000101,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 92000102,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 92000102,
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
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 92000103,
					x = 4,
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
					monsterId = 92000103,
					x = 5,
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
					monsterId = 92000103,
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
					monsterId = 92000103,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 92000103,
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
		[92000101] = {
			normalSkill = 1720101,
			name = "精英",
			pre_magicAtk = 471.8,
			maxHp = 2527.4,
			aiName = "ai-嘉乐1-精英",
			battleCamp = 1,
			career = 6,
			magicAtk = 471.8,
			pre_meleeDef = 137.6,
			sanity = 0,
			remark = "",
			giftSkill = 1720103,
			weakPointHpRate = 0.3,
			meleeDef = 137.6,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 235.9,
			pre_meleeAtk = 235.9,
			pre_maxHp = 2527.4,
			colorType = 4,
			monsterType = 1,
			id = 92000101,
			mobility = 0,
			pre_magicDef = 168.8,
			aiStepOrder = 2,
			trumpSkill = 1720108,
			isFuzzy = false,
			inspire = 15.3,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 15.3,
			modelId = 120009,
			magicDef = 168.8,
			specialSkill = 1720102,
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
		[92000102] = {
			normalSkill = 1720104,
			name = "左右护法",
			pre_magicAtk = 139.7,
			maxHp = 1428,
			aiName = "ai-嘉乐1-左右护法",
			battleCamp = 1,
			career = 2,
			magicAtk = 139.7,
			pre_meleeDef = 122.4,
			sanity = 0,
			remark = "",
			giftSkill = 1720105,
			weakPointHpRate = 0,
			meleeDef = 122.4,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 279.4,
			pre_meleeAtk = 279.4,
			pre_maxHp = 1428,
			colorType = 2,
			monsterType = 0,
			id = 92000102,
			mobility = 2,
			pre_magicDef = 88,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 15.3,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 15.3,
			modelId = 120029,
			magicDef = 88,
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
		[92000103] = {
			normalSkill = 1720106,
			name = "杂兵",
			pre_magicAtk = 148.3,
			maxHp = 550.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 148.3,
			pre_meleeDef = 30.4,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 30.4,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 74.2,
			pre_meleeAtk = 74.2,
			pre_maxHp = 550.1,
			colorType = 1,
			monsterType = 0,
			id = 92000103,
			mobility = 4,
			pre_magicDef = 46.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 13.5,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 13.5,
			modelId = 120031,
			magicDef = 46.4,
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
