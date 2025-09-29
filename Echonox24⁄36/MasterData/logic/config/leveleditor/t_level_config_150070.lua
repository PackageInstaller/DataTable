-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150070.lua

module("logic.config.leveleditor.t_level_config_150070", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150070",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面70",
	lossConditionDesc = "",
	sceneId = "116010",
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
			y = 4
		},
		{
			direction = 1,
			x = 6,
			y = 4
		},
		{
			direction = 1,
			x = 7,
			y = 4
		},
		{
			direction = 1,
			x = 8,
			y = 4
		},
		{
			direction = 1,
			x = 9,
			y = 4
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
					y = 7,
					tag = "",
					monsterId = 15007001,
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
	monsters = {
		[15007001] = {
			normalSkill = 1202601,
			name = "永恒/枝桠",
			pre_magicAtk = 1809.9,
			maxHp = 136889.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 1809.9,
			pre_meleeDef = 450.2,
			sanity = 0,
			remark = "主线困难1-8",
			giftSkill = 1202608,
			weakPointHpRate = 0.3,
			meleeDef = 450.2,
			level = 78,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 181,
			pre_meleeAtk = 181,
			pre_maxHp = 136889.3,
			colorType = 3,
			monsterType = 2,
			id = 15007001,
			mobility = 0,
			pre_magicDef = 636.8,
			aiStepOrder = 0,
			trumpSkill = 1202611,
			isFuzzy = false,
			inspire = 90,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 120026,
			magicDef = 636.8,
			specialSkill = 1202610,
			extraSkills = {},
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
