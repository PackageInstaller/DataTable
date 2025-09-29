-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150060.lua

module("logic.config.leveleditor.t_level_config_150060", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150060",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "爬塔明面60",
	lossConditionDesc = "",
	sceneId = "115002",
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
			y = 7
		},
		{
			direction = 2,
			x = 3,
			y = 6
		},
		{
			direction = 2,
			x = 3,
			y = 5
		},
		{
			direction = 4,
			x = 9,
			y = 6
		},
		{
			direction = 4,
			x = 9,
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
			groupName = "放映机BOSS",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15006001,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[15006001] = {
			normalSkill = 1208701,
			name = "人生放映机",
			pre_magicAtk = 135.8,
			maxHp = 183340.4,
			aiName = "ai_蠕虫放映机",
			battleCamp = 1,
			career = 2,
			magicAtk = 135.8,
			pre_meleeDef = 638,
			sanity = 0,
			remark = "boss模板",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 638,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1358.5,
			pre_meleeAtk = 1358.5,
			pre_maxHp = 183340.4,
			colorType = 2,
			monsterType = 2,
			id = 15006001,
			mobility = 0,
			pre_magicDef = 396,
			aiStepOrder = 1,
			trumpSkill = 1208704,
			isFuzzy = false,
			inspire = 65,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120087,
			magicDef = 396,
			specialSkill = 1208702,
			extraSkills = {
				1208705
			},
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
