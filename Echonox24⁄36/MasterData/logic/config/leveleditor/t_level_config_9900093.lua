-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_9900093.lua

module("logic.config.leveleditor.t_level_config_9900093", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "9900093",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 99,
	levelName = "自裁气球",
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
			y = 5
		},
		{
			direction = 1,
			x = 11,
			y = 6
		},
		{
			direction = 1,
			x = 8,
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
			groupName = "小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 990009301,
					x = 5,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 990009302,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "精英-高难度",
			color = 9,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 990009303,
					x = 11,
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
		[990009301] = {
			normalSkill = 1209301,
			name = "自裁气球",
			pre_magicAtk = 407.9,
			maxHp = 1252.7,
			aiName = "ai_120093_自裁气球",
			battleCamp = 1,
			career = 4,
			magicAtk = 407.9,
			pre_meleeDef = 115.2,
			sanity = 0,
			remark = "红特异小怪（禁疗）",
			giftSkill = 1209302,
			weakPointHpRate = 0,
			meleeDef = 115.2,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 40.8,
			pre_meleeAtk = 40.8,
			pre_maxHp = 1252.7,
			colorType = 1,
			monsterType = 0,
			id = 990009301,
			mobility = 2,
			pre_magicDef = 180.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 40,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 40,
			modelId = 120093,
			magicDef = 180.9,
			specialSkill = 0,
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
		[990009302] = {
			normalSkill = 1209301,
			name = "自裁气球",
			pre_magicAtk = 444.3,
			maxHp = 6954.1,
			aiName = "ai_120093_自裁气球",
			battleCamp = 1,
			career = 4,
			magicAtk = 444.3,
			pre_meleeDef = 128,
			sanity = 0,
			remark = "蓝特异精英（禁疗）",
			giftSkill = 1209302,
			weakPointHpRate = 0.3,
			meleeDef = 128,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 44.4,
			pre_meleeAtk = 44.4,
			pre_maxHp = 6954.1,
			colorType = 2,
			monsterType = 1,
			id = 990009302,
			mobility = 2,
			pre_magicDef = 201,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 43,
			modelId = 120093,
			magicDef = 201,
			specialSkill = 0,
			extraSkills = {
				1209303
			},
			attributeGrade = {
				"A",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[990009303] = {
			normalSkill = 1209301,
			name = "自裁气球",
			pre_magicAtk = 444.3,
			maxHp = 6954.1,
			aiName = "ai_120093_自裁气球",
			battleCamp = 1,
			career = 4,
			magicAtk = 444.3,
			pre_meleeDef = 128,
			sanity = 0,
			remark = "绿特异精英-高难度（禁疗）",
			giftSkill = 1209302,
			weakPointHpRate = 0.3,
			meleeDef = 128,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 44.4,
			pre_meleeAtk = 44.4,
			pre_maxHp = 6954.1,
			colorType = 3,
			monsterType = 1,
			id = 990009303,
			mobility = 2,
			pre_magicDef = 201,
			aiStepOrder = 2,
			trumpSkill = 1209304,
			isFuzzy = false,
			inspire = 43,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 43,
			modelId = 120093,
			magicDef = 201,
			specialSkill = 0,
			extraSkills = {
				1209303
			},
			attributeGrade = {
				"A",
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
