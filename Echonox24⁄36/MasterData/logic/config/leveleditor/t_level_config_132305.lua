-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_132305.lua

module("logic.config.leveleditor.t_level_config_132305", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "132305",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "装备本-狙击05",
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
			direction = 2,
			x = 3,
			y = 3
		},
		{
			direction = 2,
			x = 2,
			y = 2
		},
		{
			direction = 2,
			x = 2,
			y = 4
		},
		{
			direction = 2,
			x = 4,
			y = 4
		},
		{
			direction = 2,
			x = 4,
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
					condition = 3,
					monsterIds = {
						13230501
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
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 13230501,
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
		[13230501] = {
			normalSkill = 1210701,
			name = "零号女仆",
			pre_magicAtk = 64,
			maxHp = 32505,
			aiName = "ai_零号女仆",
			battleCamp = 1,
			career = 3,
			magicAtk = 64,
			pre_meleeDef = 229,
			sanity = 0,
			remark = "狙击装备本boss",
			giftSkill = 1210712,
			weakPointHpRate = 0.3,
			meleeDef = 229,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 640.2,
			pre_meleeAtk = 640.2,
			pre_maxHp = 32505,
			colorType = 3,
			monsterType = 2,
			id = 13230501,
			mobility = 2,
			pre_magicDef = 136,
			aiStepOrder = 3,
			trumpSkill = 1210704,
			isFuzzy = false,
			inspire = 70,
			camp = 5,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120107,
			magicDef = 136,
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
