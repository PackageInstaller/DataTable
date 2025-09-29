-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_940003.lua

module("logic.config.leveleditor.t_level_config_940003", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "940003",
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
			x = 5,
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
		},
		{
			direction = 2,
			x = 4,
			y = 8
		},
		{
			direction = 2,
			x = 6,
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
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 94000301,
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
		[94000301] = {
			normalSkill = 1741001,
			name = "猎食者",
			pre_magicAtk = 41.4,
			maxHp = 20984.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 41.4,
			pre_meleeDef = 198,
			sanity = 0,
			remark = "",
			giftSkill = 1741004,
			weakPointHpRate = 0.17,
			meleeDef = 198,
			level = 25,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 413.6,
			pre_meleeAtk = 413.6,
			pre_maxHp = 20984.5,
			colorType = 2,
			monsterType = 2,
			id = 94000301,
			mobility = 2,
			pre_magicDef = 89,
			aiStepOrder = 0,
			trumpSkill = 1741003,
			isFuzzy = false,
			inspire = 52,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 52,
			modelId = 120017,
			magicDef = 89,
			specialSkill = 1741002,
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
