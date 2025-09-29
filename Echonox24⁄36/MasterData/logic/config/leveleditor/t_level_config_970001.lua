-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_970001.lua

module("logic.config.leveleditor.t_level_config_970001", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "970001",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "执行者",
	lossConditionDesc = "",
	sceneId = "110002",
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
			y = 7
		},
		{
			direction = 1,
			x = 6,
			y = 6
		},
		{
			direction = 1,
			x = 7,
			y = 6
		},
		{
			direction = 1,
			x = 8,
			y = 6
		},
		{
			direction = 1,
			x = 9,
			y = 7
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
					monsterId = 97000101,
					x = 6,
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
	monsters = {
		[97000101] = {
			normalSkill = 1770109,
			name = "囚魂石碑",
			pre_magicAtk = 2161.5,
			maxHp = 177681.7,
			aiName = "ai_国坤暗面安妮薇",
			battleCamp = 1,
			career = 4,
			magicAtk = 2161.5,
			pre_meleeDef = 550,
			sanity = 0,
			remark = "执行者",
			giftSkill = 1770108,
			weakPointHpRate = 0.3,
			meleeDef = 550,
			level = 90,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 216.2,
			pre_meleeAtk = 216.2,
			pre_maxHp = 177681.7,
			colorType = 2,
			monsterType = 2,
			id = 97000101,
			mobility = 2,
			pre_magicDef = 783,
			aiStepOrder = 0,
			trumpSkill = 1770111,
			isFuzzy = false,
			inspire = 90,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 120032,
			magicDef = 783,
			specialSkill = 1770110,
			extraSkills = {
				1770112,
				1770113,
				1770114
			},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		}
	}
}

return configData
