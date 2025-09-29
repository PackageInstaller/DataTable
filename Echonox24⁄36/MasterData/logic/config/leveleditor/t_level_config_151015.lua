-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_151015.lua

module("logic.config.leveleditor.t_level_config_151015", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "151015",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "样板爬塔15",
	lossConditionDesc = "",
	sceneId = "9000006",
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
			x = 6,
			y = 10
		},
		{
			direction = 2,
			x = 5,
			y = 10
		},
		{
			direction = 2,
			x = 4,
			y = 10
		},
		{
			direction = 2,
			x = 5,
			y = 9
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
			groupName = "Boss",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15101501,
					x = 7,
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
		[15101501] = {
			normalSkill = 1283701,
			name = "惑形/根源",
			pre_magicAtk = 92.5,
			maxHp = 2440.8,
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
			pre_maxHp = 2440.8,
			colorType = 2,
			monsterType = 2,
			id = 15101501,
			mobility = 2,
			pre_magicDef = 50.8,
			aiStepOrder = 0,
			trumpSkill = 1283703,
			isFuzzy = false,
			inspire = 20.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 20.9,
			modelId = 120027,
			magicDef = 50.8,
			specialSkill = 1283702,
			extraSkills = {},
			attributeGrade = {
				"A",
				"A",
				"S",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
