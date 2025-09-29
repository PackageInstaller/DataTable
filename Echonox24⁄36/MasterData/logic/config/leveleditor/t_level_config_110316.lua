-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110316.lua

module("logic.config.leveleditor.t_level_config_110316", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110316",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通3-16",
	lossConditionDesc = "",
	sceneId = "114001",
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
			y = 5
		},
		{
			direction = 1,
			x = 9,
			y = 5
		},
		{
			direction = 1,
			x = 6,
			y = 4
		},
		{
			direction = 1,
			x = 8,
			y = 4
		},
		{
			direction = 1,
			x = 7,
			y = 5
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1020,
			times = 0,
			posList = {
				{
					x = 5,
					y = 12
				},
				{
					x = 6,
					y = 12
				},
				{
					x = 7,
					y = 12
				},
				{
					x = 8,
					y = 12
				},
				{
					x = 9,
					y = 12
				},
				{
					x = 5,
					y = 11
				},
				{
					x = 6,
					y = 11
				},
				{
					x = 7,
					y = 11
				},
				{
					x = 8,
					y = 11
				},
				{
					x = 9,
					y = 11
				}
			}
		}
	},
	winConditionGroupList = {
		{
			tag = "",
			isBackup = false,
			hasTag = false,
			winConditionList = {
				{
					round = 4,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "前往黑碑下，坚守到第4回合",
					condition = 2,
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
			groupName = "爱丽丝",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11031601,
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
		[11031601] = {
			normalSkill = 1203701,
			name = "无名的怪物",
			pre_magicAtk = 522.5,
			maxHp = 23966.8,
			aiName = "ai-爱丽丝-3-11",
			battleCamp = 1,
			career = 4,
			magicAtk = 522.5,
			pre_meleeDef = 115,
			sanity = 0,
			remark = "",
			giftSkill = 1203704,
			weakPointHpRate = 0.3,
			meleeDef = 115,
			level = 30,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 52.2,
			pre_meleeAtk = 52.2,
			pre_maxHp = 23966.8,
			colorType = 3,
			monsterType = 2,
			id = 11031601,
			mobility = 0,
			pre_magicDef = 183,
			aiStepOrder = 0,
			trumpSkill = 1203703,
			isFuzzy = false,
			inspire = 65,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120037,
			magicDef = 183,
			specialSkill = 1203702,
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
