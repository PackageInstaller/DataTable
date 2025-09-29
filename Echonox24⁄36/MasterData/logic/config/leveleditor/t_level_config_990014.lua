-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_990014.lua

module("logic.config.leveleditor.t_level_config_990014", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "单boss，不攻击不反击",
	levelId = "990014",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 99,
	levelName = "测试-木桩本",
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
			y = 9
		},
		{
			direction = 1,
			x = 6,
			y = 8
		},
		{
			direction = 1,
			x = 7,
			y = 7
		},
		{
			direction = 1,
			x = 8,
			y = 8
		},
		{
			direction = 1,
			x = 9,
			y = 9
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
					round = 99,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 2,
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
			groupName = "多格单位",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 99001401,
					x = 7,
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
		[99001401] = {
			normalSkill = 0,
			name = "BOSS",
			pre_magicAtk = 125.3,
			maxHp = 9999999,
			aiName = "",
			battleCamp = 1,
			career = 5,
			magicAtk = 0,
			pre_meleeDef = 596,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 1,
			meleeDef = 0,
			level = 90,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 1252.9,
			pre_maxHp = 208817.3,
			colorType = 4,
			monsterType = 2,
			id = 99001401,
			mobility = 0,
			pre_magicDef = 354,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 80,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120032,
			magicDef = 0,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"A",
				"C",
				"B"
			}
		}
	}
}

return configData
