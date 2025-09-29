-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_132302.lua

module("logic.config.leveleditor.t_level_config_132302", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "132302",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "装备本-狙击02",
	lossConditionDesc = "",
	sceneId = "132301",
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
			x = 5,
			y = 13
		},
		{
			direction = 2,
			x = 6,
			y = 12
		},
		{
			direction = 2,
			x = 5,
			y = 11
		},
		{
			direction = 2,
			x = 6,
			y = 10
		},
		{
			direction = 2,
			x = 5,
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
					round = 10,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 3,
					monsterIds = {
						13230201
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
					y = 10,
					tag = "",
					monsterId = 13230201,
					x = 10,
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
		[13230201] = {
			normalSkill = 1210701,
			name = "零号女仆",
			pre_magicAtk = 21.3,
			maxHp = 6830.9,
			aiName = "ai_零号女仆",
			battleCamp = 1,
			career = 3,
			magicAtk = 21.3,
			pre_meleeDef = 69,
			sanity = 0,
			remark = "狙击装备本boss",
			giftSkill = 1210705,
			weakPointHpRate = 0.3,
			meleeDef = 69,
			level = 12,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 213.4,
			pre_meleeAtk = 213.4,
			pre_maxHp = 6830.9,
			colorType = 3,
			monsterType = 2,
			id = 13230201,
			mobility = 2,
			pre_magicDef = 39,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 5,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120107,
			magicDef = 39,
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
