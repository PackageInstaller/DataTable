-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150021.lua

module("logic.config.leveleditor.t_level_config_150021", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150021",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面21",
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
			direction = 2,
			x = 5,
			y = 2
		},
		{
			direction = 2,
			x = 5,
			y = 1
		},
		{
			direction = 4,
			x = 12,
			y = 1
		},
		{
			direction = 2,
			x = 4,
			y = 1
		},
		{
			direction = 4,
			x = 12,
			y = 2
		},
		{
			direction = 2,
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
					y = 9,
					tag = "",
					monsterId = 15002101,
					x = 7,
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
					monsterId = 15002101,
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
					y = 8,
					tag = "",
					monsterId = 15002102,
					x = 6,
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
					monsterId = 15002102,
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
			groupName = "怪物组3",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 15002103,
					x = 8,
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
					monsterId = 15002103,
					x = 8,
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
		[15002101] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 422.7,
			maxHp = 2916.3,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 422.7,
			pre_meleeDef = 135.9,
			sanity = 0,
			remark = "",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 135.9,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 42.3,
			pre_meleeAtk = 42.3,
			pre_maxHp = 2916.3,
			colorType = 4,
			monsterType = 0,
			id = 15002101,
			mobility = 2,
			pre_magicDef = 226.8,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 45,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45,
			modelId = 120031,
			magicDef = 226.8,
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
		},
		[15002102] = {
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
			id = 15002102,
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
		[15002103] = {
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
			id = 15002103,
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
		}
	}
}

return configData
