-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150052.lua

module("logic.config.leveleditor.t_level_config_150052", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150052",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面52",
	lossConditionDesc = "",
	sceneId = "112001",
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
			x = 8,
			y = 6
		},
		{
			direction = 2,
			x = 9,
			y = 8
		},
		{
			direction = 2,
			x = 7,
			y = 8
		},
		{
			direction = 2,
			x = 8,
			y = 8
		},
		{
			direction = 2,
			x = 8,
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
			form = 5,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "支援精英",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 15005201,
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
			groupName = "守卫小怪",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 15005202,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 15005202,
					x = 9,
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
			groupName = "狙击小怪",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15005203,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15005203,
					x = 11,
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
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15005204,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15005204,
					x = 7,
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
		[15005201] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 1299,
			maxHp = 28793.7,
			aiName = "ai_120012_修补师轮胎",
			battleCamp = 1,
			career = 6,
			magicAtk = 1299,
			pre_meleeDef = 379,
			sanity = 0,
			remark = "支援精英",
			giftSkill = 1201204,
			weakPointHpRate = 0.3,
			meleeDef = 379,
			level = 66,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 129.9,
			pre_meleeAtk = 129.9,
			pre_maxHp = 28793.7,
			colorType = 4,
			monsterType = 1,
			id = 15005201,
			mobility = 2,
			pre_magicDef = 552,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 61.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 4,
			monsterGroupEnum = 1,
			pre_inspire = 61.3,
			modelId = 120012,
			magicDef = 552,
			specialSkill = 1201202,
			extraSkills = {},
			attributeGrade = {
				"A",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[15005202] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 101.1,
			maxHp = 9292.7,
			aiName = "ai_120090_路障角兽",
			battleCamp = 1,
			career = 2,
			magicAtk = 101.1,
			pre_meleeDef = 528,
			sanity = 0,
			remark = "守卫小怪（反击后触发振荡）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 528,
			level = 66,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1011,
			pre_meleeAtk = 1011,
			pre_maxHp = 9292.7,
			colorType = 2,
			monsterType = 0,
			id = 15005202,
			mobility = 2,
			pre_magicDef = 313.8,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 58.3,
			modelId = 120090,
			magicDef = 313.8,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[15005203] = {
			normalSkill = 1207001,
			name = "彩绘积木",
			pre_magicAtk = 111.4,
			maxHp = 6451.3,
			aiName = "ai_120070_涂鸦积木",
			battleCamp = 1,
			career = 3,
			magicAtk = 111.4,
			pre_meleeDef = 461.1,
			sanity = 0,
			remark = "狙击小怪",
			giftSkill = 1207003,
			weakPointHpRate = 0,
			meleeDef = 461.1,
			level = 66,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1114.1,
			pre_meleeAtk = 1114.1,
			pre_maxHp = 6451.3,
			colorType = 3,
			monsterType = 0,
			id = 15005203,
			mobility = 2,
			pre_magicDef = 315.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 78.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 78.3,
			modelId = 120070,
			magicDef = 315.6,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[15005204] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 108.6,
			maxHp = 6634.5,
			aiName = "ai_120069_疯狂车轴",
			battleCamp = 1,
			career = 5,
			magicAtk = 108.6,
			pre_meleeDef = 477.3,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 477.3,
			level = 66,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1086,
			pre_meleeAtk = 1086,
			pre_maxHp = 6634.5,
			colorType = 4,
			monsterType = 0,
			id = 15005204,
			mobility = 1,
			pre_magicDef = 354.9,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 68.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 68.3,
			modelId = 120069,
			magicDef = 354.9,
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
