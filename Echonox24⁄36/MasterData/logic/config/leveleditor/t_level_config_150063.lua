-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150063.lua

module("logic.config.leveleditor.t_level_config_150063", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150063",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面63",
	lossConditionDesc = "",
	sceneId = "116004",
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
			direction = 3,
			x = 6,
			y = 11
		},
		{
			direction = 3,
			x = 7,
			y = 11
		},
		{
			direction = 3,
			x = 8,
			y = 11
		},
		{
			direction = 3,
			x = 9,
			y = 7
		},
		{
			direction = 3,
			x = 10,
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "特异精英",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15006301,
					x = 6,
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
			groupName = "特异小怪",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 15006302,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15006302,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15006302,
					x = 10,
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
			groupName = "支援小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15006303,
					x = 7,
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
			groupName = "怪物组4",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 15006304,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 15006304,
					x = 12,
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
		[15006301] = {
			normalSkill = 1208201,
			name = "拟态/蚺",
			pre_magicAtk = 1651.4,
			maxHp = 43743.9,
			aiName = "ai_120082_假死",
			battleCamp = 1,
			career = 4,
			magicAtk = 1651.4,
			pre_meleeDef = 411.2,
			sanity = 0,
			remark = "特异精英",
			giftSkill = 1208202,
			weakPointHpRate = 0.3,
			meleeDef = 411.2,
			level = 72,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 165.2,
			pre_meleeAtk = 165.2,
			pre_maxHp = 43743.9,
			colorType = 2,
			monsterType = 1,
			id = 15006301,
			mobility = 2,
			pre_magicDef = 578.6,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 85,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 85,
			modelId = 120082,
			magicDef = 578.6,
			specialSkill = 0,
			extraSkills = {
				1208203
			},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[15006302] = {
			normalSkill = 1208201,
			name = "拟态/蚺",
			pre_magicAtk = 1496,
			maxHp = 7037.8,
			aiName = "ai_120082_假死",
			battleCamp = 1,
			career = 4,
			magicAtk = 1496,
			pre_meleeDef = 370.1,
			sanity = 0,
			remark = "特异小怪",
			giftSkill = 1208202,
			weakPointHpRate = 0,
			meleeDef = 370.1,
			level = 72,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 149.6,
			pre_meleeAtk = 149.6,
			pre_maxHp = 7037.8,
			colorType = 2,
			monsterType = 0,
			id = 15006302,
			mobility = 2,
			pre_magicDef = 520.7,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 82,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 82,
			modelId = 120082,
			magicDef = 520.7,
			specialSkill = 0,
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
		[15006303] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 1424.9,
			maxHp = 7319.6,
			aiName = "ai_120012_修补师轮胎",
			battleCamp = 1,
			career = 6,
			magicAtk = 1424.9,
			pre_meleeDef = 399.1,
			sanity = 0,
			remark = "支援小怪(主动攻击后援护)",
			giftSkill = 1201203,
			weakPointHpRate = 0,
			meleeDef = 399.1,
			level = 72,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 142.5,
			pre_meleeAtk = 142.5,
			pre_maxHp = 7319.6,
			colorType = 4,
			monsterType = 0,
			id = 15006303,
			mobility = 2,
			pre_magicDef = 560,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 62,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 62,
			modelId = 120012,
			magicDef = 560,
			specialSkill = 1201202,
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
		[15006304] = {
			normalSkill = 1201601,
			name = "巡逻道闸",
			pre_magicAtk = 126.1,
			maxHp = 9766.3,
			aiName = "ai_120016_巡逻道闸",
			battleCamp = 1,
			career = 1,
			magicAtk = 126.1,
			pre_meleeDef = 560,
			sanity = 0,
			remark = "幻影小怪",
			giftSkill = 1201602,
			weakPointHpRate = 0,
			meleeDef = 560,
			level = 72,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1261.6,
			pre_meleeAtk = 1261.6,
			pre_maxHp = 9766.3,
			colorType = 1,
			monsterType = 0,
			id = 15006304,
			mobility = 4,
			pre_magicDef = 367.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 72,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 72,
			modelId = 120016,
			magicDef = 367.4,
			specialSkill = 0,
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
