-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_990007.lua

module("logic.config.leveleditor.t_level_config_990007", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "990007",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 99,
	levelName = "测试-弱点UI",
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
			y = 3
		},
		{
			direction = 2,
			x = 2,
			y = 3
		},
		{
			direction = 2,
			x = 2,
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
					round = 99,
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
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 99000701,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 99000702,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 99000701,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 99000701,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 99000701,
					x = 2,
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
		[99000701] = {
			normalSkill = 1204601,
			name = "水滴执行者",
			pre_magicAtk = 19,
			maxHp = 1482.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 19,
			pre_meleeDef = 134.1,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 134.1,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 190.3,
			pre_meleeAtk = 190.3,
			pre_maxHp = 1482.3,
			colorType = 2,
			monsterType = 0,
			id = 99000701,
			mobility = 2,
			pre_magicDef = 70.2,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35,
			modelId = 120046,
			magicDef = 70.2,
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
		[99000702] = {
			normalSkill = 1202601,
			name = "永恒/枝桠",
			pre_magicAtk = 451,
			maxHp = 15789.3,
			aiName = "ai-不朽-序章",
			battleCamp = 1,
			career = 4,
			magicAtk = 451,
			pre_meleeDef = 90,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 90,
			level = 25,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 45.1,
			pre_meleeAtk = 45.1,
			pre_maxHp = 15789.3,
			colorType = 3,
			monsterType = 2,
			id = 99000702,
			mobility = 0,
			pre_magicDef = 180,
			aiStepOrder = 1,
			trumpSkill = 1202603,
			isFuzzy = false,
			inspire = 62,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 62,
			modelId = 120026,
			magicDef = 180,
			specialSkill = 1202602,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		}
	}
}

return configData
