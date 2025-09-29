-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150005.lua

module("logic.config.leveleditor.t_level_config_150005", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150005",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "爬塔明面5",
	lossConditionDesc = "",
	sceneId = "111002",
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
			direction = 4,
			x = 9,
			y = 12
		},
		{
			direction = 4,
			x = 9,
			y = 13
		},
		{
			direction = 4,
			x = 10,
			y = 11
		},
		{
			direction = 4,
			x = 10,
			y = 12
		},
		{
			direction = 4,
			x = 8,
			y = 14
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
						15000501
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
			groupName = "boss",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 11,
					tag = "",
					monsterId = 15000501,
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
		[15000501] = {
			normalSkill = 1202601,
			name = "永恒/枝桠",
			pre_magicAtk = 454.3,
			maxHp = 18393.2,
			aiName = "ai-不朽-序章",
			battleCamp = 1,
			career = 4,
			magicAtk = 454.3,
			pre_meleeDef = 93,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 93,
			level = 25,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 45.4,
			pre_meleeAtk = 45.4,
			pre_maxHp = 18393.2,
			colorType = 3,
			monsterType = 2,
			id = 15000501,
			mobility = 0,
			pre_magicDef = 168,
			aiStepOrder = 1,
			trumpSkill = 1202603,
			isFuzzy = false,
			inspire = 63.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 63.5,
			modelId = 120026,
			magicDef = 168,
			specialSkill = 1202602,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			}
		}
	}
}

return configData
