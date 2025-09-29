-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150035.lua

module("logic.config.leveleditor.t_level_config_150035", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150035",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 6,
	levelName = "爬塔明面35",
	lossConditionDesc = "",
	sceneId = "116002",
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
			x = 7,
			y = 5
		},
		{
			direction = 1,
			x = 9,
			y = 6
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
					y = 8,
					tag = "",
					monsterId = 15003501,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[15003501] = {
			normalSkill = 1202701,
			name = "惑形/根源",
			pre_magicAtk = 82,
			maxHp = 50186.6,
			aiName = "ai-经验本-修格斯boss",
			battleCamp = 1,
			career = 5,
			magicAtk = 82,
			pre_meleeDef = 301,
			sanity = 0,
			remark = "经验本boss",
			giftSkill = 1202705,
			weakPointHpRate = 0.25,
			meleeDef = 301,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 819.5,
			pre_meleeAtk = 819.5,
			pre_maxHp = 50186.6,
			colorType = 4,
			monsterType = 2,
			id = 15003501,
			mobility = 0,
			pre_magicDef = 215,
			aiStepOrder = 0,
			trumpSkill = 1202702,
			isFuzzy = false,
			inspire = 65,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120027,
			magicDef = 215,
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
