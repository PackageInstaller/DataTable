-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_132308.lua

module("logic.config.leveleditor.t_level_config_132308", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "132308",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "装备本-狙击08",
	lossConditionDesc = "",
	sceneId = "113001",
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
			x = 8,
			y = 2
		},
		{
			direction = 1,
			x = 6,
			y = 2
		},
		{
			direction = 1,
			x = 7,
			y = 1
		},
		{
			direction = 1,
			x = 7,
			y = 2
		},
		{
			direction = 1,
			x = 7,
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
						13230801
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
					y = 8,
					tag = "",
					monsterId = 13230801,
					x = 7,
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
		[13230801] = {
			normalSkill = 1210701,
			name = "零号女仆",
			pre_magicAtk = 153.9,
			maxHp = 125648.2,
			aiName = "ai_零号女仆",
			battleCamp = 1,
			career = 3,
			magicAtk = 153.9,
			pre_meleeDef = 559,
			sanity = 0,
			remark = "狙击装备本boss",
			giftSkill = 1210709,
			weakPointHpRate = 0.3,
			meleeDef = 559,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1538.9,
			pre_meleeAtk = 1538.9,
			pre_maxHp = 125648.2,
			colorType = 3,
			monsterType = 2,
			id = 13230801,
			mobility = 2,
			pre_magicDef = 398,
			aiStepOrder = 3,
			trumpSkill = 1210704,
			isFuzzy = false,
			inspire = 85,
			camp = 5,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 85,
			modelId = 120107,
			magicDef = 398,
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
