-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_920003.lua

module("logic.config.leveleditor.t_level_config_920003", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "920003",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "LJL个人3",
	lossConditionDesc = "",
	sceneId = "114001",
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
			direction = 4,
			x = 6,
			y = 6
		},
		{
			direction = 4,
			x = 8,
			y = 6
		},
		{
			direction = 4,
			x = 7,
			y = 7
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1016,
			times = 1,
			posList = {
				{
					x = 2,
					y = 7
				}
			}
		}
	},
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
						92000301
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
			groupName = "boss",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 92000301,
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
			groupName = "怪物组2",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 2,
					tag = "",
					monsterId = 92000302,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 92000302,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 92000302,
					x = 12,
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
					monsterId = 92000302,
					x = 14,
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
		[92000301] = {
			normalSkill = 1720205,
			name = "伴生以太水晶",
			pre_magicAtk = 133,
			maxHp = 12320,
			aiName = "ai-嘉乐3-召唤",
			battleCamp = 1,
			career = 4,
			magicAtk = 133,
			pre_meleeDef = 106,
			sanity = 0,
			remark = "",
			giftSkill = 1720207,
			weakPointHpRate = 0,
			meleeDef = 106,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 133,
			pre_meleeAtk = 133,
			pre_maxHp = 12320,
			colorType = 2,
			monsterType = 2,
			id = 92000301,
			mobility = 0,
			pre_magicDef = 132,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 19,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 19,
			modelId = 120084,
			magicDef = 132,
			specialSkill = 1720206,
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
		[92000302] = {
			normalSkill = 1720104,
			name = "追兵",
			pre_magicAtk = 84.1,
			maxHp = 882,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 84.1,
			pre_meleeDef = 61.6,
			sanity = 0,
			remark = "",
			giftSkill = 1720105,
			weakPointHpRate = 0,
			meleeDef = 61.6,
			level = 12,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 168.1,
			pre_meleeAtk = 168.1,
			pre_maxHp = 882,
			colorType = 1,
			monsterType = 0,
			id = 92000302,
			mobility = 4,
			pre_magicDef = 44,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 17.1,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 17.1,
			modelId = 120029,
			magicDef = 44,
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
