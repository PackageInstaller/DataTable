-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_940004.lua

module("logic.config.leveleditor.t_level_config_940004", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "940004",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "猴子都能打过",
	lossConditionDesc = "",
	sceneId = "108001",
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
			x = 6,
			y = 3
		},
		{
			direction = 2,
			x = 2,
			y = 3
		},
		{
			direction = 2,
			x = 3,
			y = 2
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
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 94000401,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[94000401] = {
			normalSkill = 1741005,
			name = "惑形/根源",
			pre_magicAtk = 156.8,
			maxHp = 181189.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 1567.5,
			pre_meleeDef = 588,
			sanity = 0,
			remark = "经验本boss",
			giftSkill = 1741008,
			weakPointHpRate = 0.3,
			meleeDef = 588,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 156.8,
			pre_meleeAtk = 1567.5,
			pre_maxHp = 181189.8,
			colorType = 4,
			monsterType = 2,
			id = 94000401,
			mobility = 0,
			pre_magicDef = 444,
			aiStepOrder = 0,
			trumpSkill = 1741006,
			isFuzzy = false,
			inspire = 80,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 80,
			modelId = 120027,
			magicDef = 444,
			specialSkill = 1741007,
			extraSkills = {
				1741010,
				1741009
			},
			attributeGrade = {
				"S",
				"S",
				"A",
				"C",
				"B"
			},
			tags = {}
		}
	}
}

return configData
