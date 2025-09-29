-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_950001.lua

module("logic.config.leveleditor.t_level_config_950001", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "哈哈哈",
	levelId = "950001",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "猎食者体验本",
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
			direction = 2,
			x = 4,
			y = 8
		},
		{
			direction = 2,
			x = 5,
			y = 7
		},
		{
			direction = 2,
			x = 6,
			y = 7
		},
		{
			direction = 2,
			x = 7,
			y = 7
		},
		{
			direction = 2,
			x = 8,
			y = 8
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
					y = 9,
					tag = "",
					monsterId = 95000101,
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
		[95000101] = {
			normalSkill = 1750001,
			name = "猎食者",
			pre_magicAtk = 38.2,
			maxHp = 25034.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 38.2,
			pre_meleeDef = 214,
			sanity = 0,
			remark = "",
			giftSkill = 1750004,
			weakPointHpRate = 0.33,
			meleeDef = 214,
			level = 25,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 381.7,
			pre_meleeAtk = 381.7,
			pre_maxHp = 25034.8,
			colorType = 2,
			monsterType = 2,
			id = 95000101,
			mobility = 2,
			pre_magicDef = 90,
			aiStepOrder = 0,
			trumpSkill = 1750003,
			isFuzzy = false,
			inspire = 42,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 42,
			modelId = 120017,
			magicDef = 90,
			specialSkill = 1750002,
			extraSkills = {},
			attributeGrade = {
				"A",
				"A",
				"S",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
