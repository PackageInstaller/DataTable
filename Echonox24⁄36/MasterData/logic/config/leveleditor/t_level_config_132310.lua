-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_132310.lua

module("logic.config.leveleditor.t_level_config_132310", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "132310",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "装备本-狙击10",
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
			direction = 1,
			x = 6,
			y = 2
		},
		{
			direction = 1,
			x = 8,
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
			y = 3
		},
		{
			direction = 1,
			x = 7,
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 13231001,
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
		[13231001] = {
			normalSkill = 1210701,
			name = "零号女仆",
			pre_magicAtk = 216.2,
			maxHp = 211466.2,
			aiName = "ai_零号女仆",
			battleCamp = 1,
			career = 3,
			magicAtk = 216.2,
			pre_meleeDef = 783,
			sanity = 0,
			remark = "狙击装备本boss",
			giftSkill = 1210707,
			weakPointHpRate = 0.3,
			meleeDef = 783,
			level = 90,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 2161.5,
			pre_meleeAtk = 2161.5,
			pre_maxHp = 211466.2,
			colorType = 3,
			monsterType = 2,
			id = 13231001,
			mobility = 2,
			pre_magicDef = 550,
			aiStepOrder = 3,
			trumpSkill = 1210704,
			isFuzzy = false,
			inspire = 90,
			camp = 5,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 120107,
			magicDef = 550,
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
