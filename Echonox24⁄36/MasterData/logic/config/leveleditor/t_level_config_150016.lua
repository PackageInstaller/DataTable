-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150016.lua

module("logic.config.leveleditor.t_level_config_150016", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150016",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面16",
	lossConditionDesc = "",
	sceneId = "109001",
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
			y = 4
		},
		{
			direction = 1,
			x = 2,
			y = 4
		},
		{
			direction = 1,
			x = 9,
			y = 5
		},
		{
			direction = 1,
			x = 8,
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
					y = 7,
					tag = "",
					monsterId = 15001601,
					x = 2,
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
					monsterId = 15001601,
					x = 1,
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
					monsterId = 15001601,
					x = 10,
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
					monsterId = 15001601,
					x = 9,
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
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 15001602,
					x = 6,
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
		[15001601] = {
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
			id = 15001601,
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
		[15001602] = {
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
			id = 15001602,
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
