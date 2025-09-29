-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110116.lua

module("logic.config.leveleditor.t_level_config_110116", package.seeall)

local configData = {
	battleMusicName = "music_battle_character_anna_block",
	remarks = "",
	levelId = "110116",
	plotEventGroup = 110116,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通1-16",
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
			x = 7,
			y = 8
		},
		{
			direction = 1,
			x = 5,
			y = 8
		},
		{
			direction = 1,
			x = 7,
			y = 7
		},
		{
			direction = 1,
			x = 6,
			y = 7
		},
		{
			direction = 1,
			x = 5,
			y = 7
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
					y = 10,
					tag = "",
					monsterId = 11011601,
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
		[11011601] = {
			normalSkill = 1208701,
			name = "人生放映机",
			pre_magicAtk = 16.7,
			maxHp = 12561,
			aiName = "ai_蠕虫放映机_1-17",
			battleCamp = 1,
			career = 2,
			magicAtk = 16.7,
			pre_meleeDef = 80.5,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.25,
			meleeDef = 80.5,
			level = 11,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 167.2,
			pre_meleeAtk = 167.2,
			pre_maxHp = 9561.2,
			colorType = 2,
			monsterType = 2,
			id = 11011601,
			mobility = 0,
			pre_magicDef = 37.5,
			aiStepOrder = 0,
			trumpSkill = 1208704,
			isFuzzy = false,
			inspire = 35.8,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 35.8,
			modelId = 120087,
			magicDef = 37.5,
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
			}
		}
	}
}

return configData
