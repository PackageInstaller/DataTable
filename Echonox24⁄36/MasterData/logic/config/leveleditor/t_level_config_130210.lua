-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130210.lua

module("logic.config.leveleditor.t_level_config_130210", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130210",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 4,
	levelName = "经验本难度10",
	lossConditionDesc = "",
	sceneId = "111002",
	winConditionDesc = "4回合内尽可能造成更多伤害",
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
			y = 13
		},
		{
			direction = 2,
			x = 3,
			y = 11
		},
		{
			direction = 2,
			x = 4,
			y = 10
		},
		{
			direction = 4,
			x = 9,
			y = 11
		},
		{
			direction = 4,
			x = 8,
			y = 10
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
					round = 4,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 2,
					monsterIds = {}
				}
			}
		},
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
						13021001
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
			groupName = "BOSS",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 13021001,
					x = 6,
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
			x = 6,
			y = 12
		},
		{
			x = 4,
			y = 13
		}
	},
	lockHeroList = {},
	monsters = {
		[13021001] = {
			normalSkill = 1202701,
			name = "惑形/根源",
			pre_magicAtk = 1373.4,
			maxHp = 181564.2,
			aiName = "ai-经验本-修格斯boss",
			battleCamp = 1,
			career = 5,
			magicAtk = 1373.4,
			pre_meleeDef = 619,
			sanity = 0,
			remark = "",
			giftSkill = 1202705,
			weakPointHpRate = 0.12,
			meleeDef = 619,
			level = 90,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 137.3,
			pre_meleeAtk = 137.3,
			pre_maxHp = 181564.2,
			colorType = 4,
			monsterType = 2,
			id = 13021001,
			mobility = 0,
			pre_magicDef = 811,
			aiStepOrder = 3,
			trumpSkill = 1202702,
			isFuzzy = false,
			inspire = 82,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 82,
			modelId = 120027,
			magicDef = 811,
			specialSkill = 1202704,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"A",
				"C",
				"B"
			},
			tags = {}
		}
	}
}

return configData
