-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150066.lua

module("logic.config.leveleditor.t_level_config_150066", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150066",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面66",
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
			direction = 3,
			x = 7,
			y = 10
		},
		{
			direction = 2,
			x = 9,
			y = 10
		},
		{
			direction = 3,
			x = 8,
			y = 10
		},
		{
			direction = 3,
			x = 6,
			y = 10
		},
		{
			direction = 3,
			x = 10,
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
			form = 5,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "幻影精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15006601,
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
			groupName = "陨灭小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15006602,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 11,
					tag = "",
					monsterId = 15006602,
					x = 3,
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
			groupName = "特异小怪1",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15006603,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15006603,
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
			groupName = "特异小怪2",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 15006604,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 15006604,
					x = 8,
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
		[15006601] = {
			normalSkill = 1201601,
			name = "巡逻道闸",
			pre_magicAtk = 139.7,
			maxHp = 66985,
			aiName = "ai_120016_巡逻道闸",
			battleCamp = 1,
			career = 1,
			magicAtk = 139.7,
			pre_meleeDef = 654,
			sanity = 0,
			remark = "幻影精英-高难度",
			giftSkill = 1201602,
			weakPointHpRate = 0.3,
			meleeDef = 654,
			level = 75,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1396.9,
			pre_meleeAtk = 1396.9,
			pre_maxHp = 66985,
			colorType = 1,
			monsterType = 1,
			id = 15006601,
			mobility = 4,
			pre_magicDef = 428,
			aiStepOrder = 0,
			trumpSkill = 1201604,
			isFuzzy = false,
			inspire = 78,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 78,
			modelId = 120016,
			magicDef = 428,
			specialSkill = 0,
			extraSkills = {
				1201603
			},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[15006602] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 136.3,
			maxHp = 9615,
			aiName = "ai_120069_疯狂车轴",
			battleCamp = 1,
			career = 5,
			magicAtk = 136.3,
			pre_meleeDef = 566.1,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 566.1,
			level = 75,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1362.6,
			pre_meleeAtk = 1362.6,
			pre_maxHp = 9615,
			colorType = 4,
			monsterType = 0,
			id = 15006602,
			mobility = 1,
			pre_magicDef = 435.6,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 75,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 75,
			modelId = 120069,
			magicDef = 435.6,
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
		},
		[15006603] = {
			normalSkill = 1208201,
			name = "拟态/蚺",
			pre_magicAtk = 1571.4,
			maxHp = 7835.8,
			aiName = "ai_120082_假死",
			battleCamp = 1,
			career = 4,
			magicAtk = 1571.4,
			pre_meleeDef = 387.9,
			sanity = 0,
			remark = "特异小怪",
			giftSkill = 1208202,
			weakPointHpRate = 0,
			meleeDef = 387.9,
			level = 75,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 157.1,
			pre_meleeAtk = 157.1,
			pre_maxHp = 7835.8,
			colorType = 2,
			monsterType = 0,
			id = 15006603,
			mobility = 2,
			pre_magicDef = 547.2,
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
			magicDef = 547.2,
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
		[15006604] = {
			normalSkill = 1209301,
			name = "自裁气球",
			pre_magicAtk = 1571.4,
			maxHp = 7835.8,
			aiName = "ai_120093_自裁气球",
			battleCamp = 1,
			career = 4,
			magicAtk = 1571.4,
			pre_meleeDef = 387.9,
			sanity = 0,
			remark = "红特异小怪（禁疗）",
			giftSkill = 1209302,
			weakPointHpRate = 0,
			meleeDef = 387.9,
			level = 75,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 157.1,
			pre_meleeAtk = 157.1,
			pre_maxHp = 7835.8,
			colorType = 1,
			monsterType = 0,
			id = 15006604,
			mobility = 2,
			pre_magicDef = 547.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 85,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 85,
			modelId = 120093,
			magicDef = 547.2,
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
		}
	}
}

return configData
