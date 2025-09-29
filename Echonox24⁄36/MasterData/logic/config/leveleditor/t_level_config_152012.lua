-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_152012.lua

module("logic.config.leveleditor.t_level_config_152012", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "152012",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔暗面3-5",
	lossConditionDesc = "",
	sceneId = "108003",
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
			x = 4,
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
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 15201201,
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
		[15201201] = {
			normalSkill = 1200801,
			name = "迷雾使徒",
			pre_magicAtk = 9.7,
			maxHp = 385.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 9.7,
			pre_meleeDef = 54.9,
			sanity = 0,
			remark = "狙击小怪",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 54.9,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 96.7,
			pre_meleeAtk = 96.7,
			pre_maxHp = 385.5,
			colorType = 3,
			monsterType = 0,
			id = 15201201,
			mobility = 2,
			pre_magicDef = 30.6,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 120008,
			magicDef = 30.6,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
