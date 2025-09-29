-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_999099.lua

module("logic.config.leveleditor.t_level_config_999099", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "999099",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "wlf特殊测试用",
	lossConditionDesc = "",
	sceneId = "931001",
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
			x = 4,
			y = 0
		},
		{
			direction = 1,
			x = 3,
			y = 0
		},
		{
			direction = 1,
			x = 5,
			y = 0
		},
		{
			direction = 1,
			x = 6,
			y = 0
		},
		{
			direction = 1,
			x = 2,
			y = 0
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
					y = 9,
					tag = "",
					monsterId = 99909901,
					x = 4,
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
		[99909901] = {
			normalSkill = 1213256,
			name = "烟火(黑化）",
			pre_magicAtk = 27.3,
			maxHp = 9472,
			aiName = "boss03_equipment_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 27.3,
			pre_meleeDef = 107,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 107,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 272.8,
			pre_meleeAtk = 272.8,
			pre_maxHp = 9472,
			colorType = 1,
			monsterType = 2,
			id = 99909901,
			mobility = 2,
			pre_magicDef = 54,
			aiStepOrder = 3,
			trumpSkill = 1213258,
			isFuzzy = false,
			inspire = 57,
			camp = 7,
			hasSanity = false,
			bodyEffect = "ma_common_body_40002_red",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 57,
			modelId = 100016,
			magicDef = 54,
			specialSkill = 1213257,
			extraSkills = {
				1213260
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
