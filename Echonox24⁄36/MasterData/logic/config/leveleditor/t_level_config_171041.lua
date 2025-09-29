-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_171041.lua

module("logic.config.leveleditor.t_level_config_171041", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "171041",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "钢琴01",
	lossConditionDesc = "",
	sceneId = "109005",
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
			y = 1
		},
		{
			direction = 1,
			x = 3,
			y = 1
		},
		{
			direction = 1,
			x = 6,
			y = 2
		},
		{
			direction = 1,
			x = 6,
			y = 1
		},
		{
			direction = 1,
			x = 3,
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
					condition = 3,
					monsterIds = {
						17104101
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 17104101,
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
		[17104101] = {
			normalSkill = 1217141,
			name = "容易害羞的钢琴",
			pre_magicAtk = 272.8,
			maxHp = 7958.8,
			aiName = "mob_stand_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 272.8,
			pre_meleeDef = 54,
			sanity = 0,
			remark = "",
			giftSkill = 1217142,
			weakPointHpRate = 0,
			meleeDef = 54,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 27.3,
			pre_meleeAtk = 27.3,
			pre_maxHp = 7958.8,
			colorType = 1,
			monsterType = 2,
			id = 17104101,
			mobility = 0,
			pre_magicDef = 107,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 57,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 57,
			modelId = 120100,
			magicDef = 107,
			specialSkill = 0,
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
