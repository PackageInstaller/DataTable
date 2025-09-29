-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_132307.lua

module("logic.config.leveleditor.t_level_config_132307", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "132307",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "装备本-狙击07",
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
			direction = 1,
			x = 11,
			y = 3
		},
		{
			direction = 1,
			x = 9,
			y = 4
		},
		{
			direction = 1,
			x = 10,
			y = 4
		},
		{
			direction = 1,
			x = 9,
			y = 5
		},
		{
			direction = 1,
			x = 9,
			y = 3
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
					condition = 3,
					monsterIds = {
						13230701
					}
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
					y = 12,
					tag = "",
					monsterId = 13230701,
					x = 8,
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
	trialHeroes = {},
	monsters = {
		[13230701] = {
			normalSkill = 1210701,
			name = "零号女仆",
			pre_magicAtk = 111,
			maxHp = 83499.7,
			aiName = "ai_零号女仆",
			battleCamp = 1,
			career = 3,
			magicAtk = 111,
			pre_meleeDef = 385,
			sanity = 0,
			remark = "狙击装备本boss",
			giftSkill = 1210710,
			weakPointHpRate = 0.3,
			meleeDef = 385,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1109.9,
			pre_meleeAtk = 1109.9,
			pre_maxHp = 83499.7,
			colorType = 3,
			monsterType = 2,
			id = 13230701,
			mobility = 2,
			pre_magicDef = 260,
			aiStepOrder = 3,
			trumpSkill = 1210704,
			isFuzzy = false,
			inspire = 80,
			camp = 5,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 80,
			modelId = 120107,
			magicDef = 260,
			specialSkill = 1210702,
			extraSkills = {
				1210703
			},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
