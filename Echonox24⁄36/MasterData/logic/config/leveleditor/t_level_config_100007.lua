-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_100007.lua

module("logic.config.leveleditor.t_level_config_100007", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "100007",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "修格斯boss战",
	lossConditionDesc = "",
	sceneId = "190020",
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
			x = 4,
			y = 5
		},
		{
			direction = 2,
			x = 4,
			y = 4
		},
		{
			direction = 2,
			x = 4,
			y = 6
		},
		{
			direction = 2,
			x = 3,
			y = 6
		},
		{
			direction = 2,
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
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 10000701,
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
		[10000701] = {
			normalSkill = 1202706,
			name = "惑形/根源",
			pre_magicAtk = 279,
			maxHp = 8874,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 279,
			pre_meleeDef = 70.5,
			sanity = 0,
			remark = "",
			giftSkill = 1202709,
			weakPointHpRate = 0.3,
			meleeDef = 70.5,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 111.6,
			pre_meleeAtk = 111.6,
			pre_maxHp = 8874,
			colorType = 2,
			monsterType = 2,
			id = 10000701,
			mobility = 2,
			pre_magicDef = 111.6,
			aiStepOrder = 0,
			trumpSkill = 1202708,
			isFuzzy = false,
			inspire = 36.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 36.9,
			modelId = 120027,
			magicDef = 111.6,
			specialSkill = 1202707,
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
