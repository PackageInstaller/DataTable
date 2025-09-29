-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150004.lua

module("logic.config.leveleditor.t_level_config_150004", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150004",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "爬塔明面4",
	lossConditionDesc = "",
	sceneId = "111003",
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
			x = 8,
			y = 3
		},
		{
			direction = 4,
			x = 6,
			y = 3
		},
		{
			direction = 2,
			x = 10,
			y = 3
		},
		{
			direction = 1,
			x = 7,
			y = 4
		},
		{
			direction = 1,
			x = 9,
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
			groupName = "顶部",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 15000402,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 15000402,
					x = 10,
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
			groupName = "左侧",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 15000401,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 2,
					tag = "",
					monsterId = 15000401,
					x = 3,
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
			groupName = "右侧",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 15000401,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 15000401,
					x = 11,
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
		[15000401] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 20.3,
			maxHp = 1722.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 20.3,
			pre_meleeDef = 134.1,
			sanity = 0,
			remark = "",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 134.1,
			level = 22,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 202.6,
			pre_meleeAtk = 202.6,
			pre_maxHp = 1722.8,
			colorType = 2,
			monsterType = 0,
			id = 15000401,
			mobility = 2,
			pre_magicDef = 72,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 37,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 37,
			modelId = 120028,
			magicDef = 72,
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
		[15000402] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 235.3,
			maxHp = 1016.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 235.3,
			pre_meleeDef = 72.9,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 72.9,
			level = 22,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 23.5,
			pre_meleeAtk = 23.5,
			pre_maxHp = 1016.4,
			colorType = 1,
			monsterType = 0,
			id = 15000402,
			mobility = 2,
			pre_magicDef = 113.4,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 57,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 57,
			modelId = 120029,
			magicDef = 113.4,
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
