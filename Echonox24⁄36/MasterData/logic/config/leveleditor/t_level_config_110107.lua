-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110107.lua

module("logic.config.leveleditor.t_level_config_110107", package.seeall)

local configData = {
	battleMusicName = "music_battle_character_anna_block",
	remarks = "",
	levelId = "110107",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "主线普通1-7",
	lossConditionDesc = "",
	sceneId = "110002",
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
			x = 5,
			y = 9
		},
		{
			direction = 3,
			x = 7,
			y = 9
		},
		{
			direction = 3,
			x = 6,
			y = 10
		},
		{
			direction = 3,
			x = 8,
			y = 10
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
					round = 3,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "击破放映机的弱点",
					condition = 4,
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
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 11010701,
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
	trialHeroes = {},
	monsters = {
		[11010701] = {
			normalSkill = 1208701,
			name = "人生放映机",
			pre_magicAtk = 14.6,
			maxHp = 15125,
			aiName = "ai_蠕虫放映机_1.9",
			battleCamp = 1,
			career = 2,
			magicAtk = 14.6,
			pre_meleeDef = 73,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.25,
			meleeDef = 73,
			level = 8,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 126,
			pre_meleeAtk = 146.3,
			pre_maxHp = 8102.5,
			colorType = 2,
			monsterType = 2,
			id = 11010701,
			mobility = 0,
			pre_magicDef = 34,
			aiStepOrder = 0,
			trumpSkill = 1208704,
			isFuzzy = false,
			inspire = 34,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 34,
			modelId = 120087,
			magicDef = 36,
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
			},
			tags = {}
		}
	}
}

return configData
