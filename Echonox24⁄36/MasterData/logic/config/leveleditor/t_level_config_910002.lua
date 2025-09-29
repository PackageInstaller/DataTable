-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_910002.lua

module("logic.config.leveleditor.t_level_config_910002", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "910002",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "时机录制5",
	lossConditionDesc = "",
	sceneId = "114001",
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
			y = 5
		},
		{
			direction = 1,
			x = 8,
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
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 91000201,
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
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 1,
			heroType = 2,
			monsterId = 91000202,
			pos = {
				x = 6,
				y = 5
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 1,
			heroType = 2,
			monsterId = 91000203,
			pos = {
				x = 8,
				y = 5
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[91000201] = {
			normalSkill = 1105601,
			name = "提亚",
			pre_magicAtk = 446.4,
			maxHp = 1243.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 446.4,
			pre_meleeDef = 70.5,
			sanity = 0,
			remark = "",
			giftSkill = 1105604,
			weakPointHpRate = 0,
			meleeDef = 70.5,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 178.6,
			pre_meleeAtk = 178.6,
			pre_maxHp = 1243.6,
			colorType = 4,
			monsterType = 0,
			id = 91000201,
			mobility = 2,
			pre_magicDef = 107,
			aiStepOrder = 20,
			trumpSkill = 1105603,
			isFuzzy = false,
			inspire = 36.9,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36.9,
			modelId = 100056,
			magicDef = 107,
			specialSkill = 1105602,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		},
		[91000202] = {
			normalSkill = 1101301,
			name = "安妮薇",
			pre_magicAtk = 446.4,
			maxHp = 1243.8,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 446.4,
			pre_meleeDef = 70.5,
			sanity = 0,
			remark = "",
			giftSkill = 1101304,
			weakPointHpRate = 0,
			meleeDef = 70.5,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 178.6,
			pre_meleeAtk = 178.6,
			pre_maxHp = 1243.8,
			colorType = 3,
			monsterType = 0,
			id = 91000202,
			mobility = 2,
			pre_magicDef = 107,
			aiStepOrder = 20,
			trumpSkill = 1101303,
			isFuzzy = false,
			inspire = 36.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36.9,
			modelId = 100013,
			magicDef = 107,
			specialSkill = 1101302,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		},
		[91000203] = {
			normalSkill = 1101101,
			name = "一云",
			pre_magicAtk = 446.4,
			maxHp = 1243.8,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 446.4,
			pre_meleeDef = 70.5,
			sanity = 0,
			remark = "",
			giftSkill = 1101104,
			weakPointHpRate = 0,
			meleeDef = 70.5,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 178.6,
			pre_meleeAtk = 178.6,
			pre_maxHp = 1243.8,
			colorType = 1,
			monsterType = 0,
			id = 91000203,
			mobility = 3,
			pre_magicDef = 107,
			aiStepOrder = 20,
			trumpSkill = 1101103,
			isFuzzy = false,
			inspire = 36.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36.9,
			modelId = 100011,
			magicDef = 107,
			specialSkill = 1101102,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
