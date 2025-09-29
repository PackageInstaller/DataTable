-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130208.lua

module("logic.config.leveleditor.t_level_config_130208", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130208",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 4,
	levelName = "经验本难度8",
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
						13020801
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
					monsterId = 13020801,
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
		[13020801] = {
			normalSkill = 1202701,
			name = "惑形/根源",
			pre_magicAtk = 978.6,
			maxHp = 107868.8,
			aiName = "ai-经验本-修格斯boss",
			battleCamp = 1,
			career = 5,
			magicAtk = 978.6,
			pre_meleeDef = 446,
			sanity = 0,
			remark = "",
			giftSkill = 1202705,
			weakPointHpRate = 0.12,
			meleeDef = 446,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 97.9,
			pre_meleeAtk = 97.9,
			pre_maxHp = 107868.8,
			colorType = 4,
			monsterType = 2,
			id = 13020801,
			mobility = 0,
			pre_magicDef = 579,
			aiStepOrder = 3,
			trumpSkill = 1202702,
			isFuzzy = false,
			inspire = 75,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 75,
			modelId = 120027,
			magicDef = 579,
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
