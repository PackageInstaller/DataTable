-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_960008.lua

module("logic.config.leveleditor.t_level_config_960008", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "960008",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "CPJ-H1.8",
	lossConditionDesc = "",
	sceneId = "117001",
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
			x = 5,
			y = 8
		},
		{
			direction = 1,
			x = 5,
			y = 7
		},
		{
			direction = 1,
			x = 6,
			y = 7
		},
		{
			direction = 1,
			x = 7,
			y = 7
		},
		{
			direction = 1,
			x = 7,
			y = 8
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
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 96000801,
					x = 6,
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
		[96000801] = {
			normalSkill = 1208701,
			name = "人生放映机",
			pre_magicAtk = 20.4,
			maxHp = 12288.7,
			aiName = "ai_蠕虫放映机",
			battleCamp = 1,
			career = 2,
			magicAtk = 20.4,
			pre_meleeDef = 106,
			sanity = 0,
			remark = "boss模板",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 106,
			level = 15,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 203.5,
			pre_meleeAtk = 203.5,
			pre_maxHp = 12288.7,
			colorType = 2,
			monsterType = 2,
			id = 96000801,
			mobility = 0,
			pre_magicDef = 42,
			aiStepOrder = 1,
			trumpSkill = 1208704,
			isFuzzy = false,
			inspire = 38,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 38,
			modelId = 120087,
			magicDef = 42,
			specialSkill = 1208702,
			extraSkills = {
				1208705,
				1208707
			},
			attributeGrade = {
				"A",
				"A",
				"S",
				"C",
				"C"
			}
		}
	}
}

return configData
