-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_132306.lua

module("logic.config.leveleditor.t_level_config_132306", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "132306",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "装备本-狙击06",
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
			x = 8,
			y = 1
		},
		{
			direction = 1,
			x = 9,
			y = 1
		},
		{
			direction = 1,
			x = 7,
			y = 1
		},
		{
			direction = 1,
			x = 8,
			y = 0
		},
		{
			direction = 1,
			x = 8,
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
						13230601
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
					y = 7,
					tag = "",
					monsterId = 13230601,
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
		[13230601] = {
			normalSkill = 1210701,
			name = "零号女仆",
			pre_magicAtk = 82,
			maxHp = 48157.6,
			aiName = "ai_零号女仆",
			battleCamp = 1,
			career = 3,
			magicAtk = 82,
			pre_meleeDef = 289,
			sanity = 0,
			remark = "狙击装备本boss",
			giftSkill = 1210711,
			weakPointHpRate = 0.3,
			meleeDef = 289,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 819.5,
			pre_meleeAtk = 819.5,
			pre_maxHp = 48157.6,
			colorType = 3,
			monsterType = 2,
			id = 13230601,
			mobility = 2,
			pre_magicDef = 184,
			aiStepOrder = 3,
			trumpSkill = 1210704,
			isFuzzy = false,
			inspire = 75,
			camp = 5,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 75,
			modelId = 120107,
			magicDef = 184,
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
