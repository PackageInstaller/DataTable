-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_171032.lua

module("logic.config.leveleditor.t_level_config_171032", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_01",
	remarks = "",
	levelId = "171032",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 20,
	levelName = "电话亭02",
	lossConditionDesc = "",
	sceneId = "930011",
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
			x = 0,
			y = 4
		},
		{
			direction = 1,
			x = 0,
			y = 3
		},
		{
			direction = 1,
			x = 1,
			y = 3
		},
		{
			direction = 1,
			x = 2,
			y = 3
		},
		{
			direction = 1,
			x = 3,
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
					monsterId = 17103201,
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
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 12010511,
					x = 7,
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
					monsterId = 12010511,
					x = 10,
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
					monsterId = 12010511,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 11,
					tag = "",
					monsterId = 12010511,
					x = 9,
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
					monsterId = 12010511,
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
		[17103201] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 19,
			maxHp = 1178.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 19,
			pre_meleeDef = 134.1,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 134.1,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 190.3,
			pre_meleeAtk = 190.3,
			pre_maxHp = 1178.3,
			colorType = 2,
			monsterType = 0,
			id = 17103201,
			mobility = 2,
			pre_magicDef = 70.2,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 0,
			monsterGroupEnum = 1,
			pre_inspire = 35,
			modelId = 120067,
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
		}
	}
}

return configData
