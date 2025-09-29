-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110208.lua

module("logic.config.leveleditor.t_level_config_110208", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110208",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 15,
	levelName = "2-8",
	lossConditionDesc = "",
	sceneId = "10409",
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
			form = 1,
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
					y = 4,
					tag = "",
					monsterId = 11020801,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 7,
			y = 6
		}
	},
	lockHeroList = {},
	monsters = {
		[11020801] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 0,
			maxHp = 1,
			aiName = "ai-jishuqi-ceshi1",
			battleCamp = 1,
			career = 3,
			magicAtk = 0,
			pre_meleeDef = 45,
			sanity = 0,
			remark = "",
			giftSkill = 1201203,
			weakPointHpRate = 0,
			meleeDef = 45,
			level = 1,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 224.7,
			pre_meleeAtk = 224.7,
			pre_maxHp = 1,
			colorType = 3,
			monsterType = 0,
			id = 11020801,
			mobility = 2,
			pre_magicDef = 0,
			aiStepOrder = 99,
			trumpSkill = 1201103,
			isFuzzy = false,
			inspire = 0,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 120012,
			magicDef = 0,
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
