-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_1000.lua

module("logic.config.leveleditor.t_level_config_1000", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "1000",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "测试",
	lossConditionDesc = "",
	sceneId = "110001",
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
			x = 3,
			y = 6
		},
		{
			direction = 2,
			x = 2,
			y = 6
		},
		{
			direction = 2,
			x = 3,
			y = 5
		},
		{
			direction = 2,
			x = 2,
			y = 5
		},
		{
			direction = 2,
			x = 4,
			y = 5
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
					y = 6,
					tag = "",
					monsterId = 100001,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 100002,
					x = 3,
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
		[100001] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 60,
			maxHp = 150,
			aiName = "gold_attack_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 60,
			pre_meleeDef = 37.8,
			sanity = 0,
			remark = "",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 37.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 60,
			pre_meleeAtk = 60,
			pre_maxHp = 150,
			colorType = 1,
			monsterType = 0,
			id = 100001,
			mobility = 4,
			pre_magicDef = 49.5,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 17.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 17.9,
			modelId = 120089,
			magicDef = 49.5,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[100002] = {
			normalSkill = 1101115,
			name = "失控一云",
			pre_magicAtk = 118.1,
			maxHp = 7134.6,
			aiName = "boss_atzero_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 118.1,
			pre_meleeDef = 64.8,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.23,
			meleeDef = 64.8,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 284.2,
			pre_meleeAtk = 284.2,
			pre_maxHp = 7134.6,
			colorType = 1,
			monsterType = 2,
			id = 100002,
			mobility = 2,
			pre_magicDef = 59.8,
			aiStepOrder = 0,
			trumpSkill = 1101117,
			isFuzzy = false,
			inspire = 26.4,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 26.4,
			modelId = 120099,
			magicDef = 59.8,
			specialSkill = 1101116,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"A",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
