-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_920005.lua

module("logic.config.leveleditor.t_level_config_920005", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "920005",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "LJL个人5",
	lossConditionDesc = "",
	sceneId = "116003",
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
			direction = 3,
			x = 7,
			y = 10
		},
		{
			direction = 3,
			x = 9,
			y = 10
		},
		{
			direction = 1,
			x = 7,
			y = 2
		},
		{
			direction = 1,
			x = 9,
			y = 3
		},
		{
			direction = 1,
			x = 10,
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
			groupName = "boss",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 92000501,
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
		[92000501] = {
			normalSkill = 1720501,
			name = "伪装者",
			pre_magicAtk = 1569.7,
			maxHp = 145771.2,
			aiName = "ai-经验本-修格斯boss",
			battleCamp = 1,
			career = 4,
			magicAtk = 1569.7,
			pre_meleeDef = 392,
			sanity = 0,
			remark = "",
			giftSkill = 1720504,
			weakPointHpRate = 0.07,
			meleeDef = 392,
			level = 80,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 157,
			pre_meleeAtk = 157,
			pre_maxHp = 145771.2,
			colorType = 3,
			monsterType = 2,
			id = 92000501,
			mobility = 2,
			pre_magicDef = 567,
			aiStepOrder = 3,
			trumpSkill = 1720503,
			isFuzzy = false,
			inspire = 90,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 120078,
			magicDef = 567,
			specialSkill = 1720502,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			}
		}
	}
}

return configData
