-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150053.lua

module("logic.config.leveleditor.t_level_config_150053", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150053",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "爬塔明面53",
	lossConditionDesc = "",
	sceneId = "112002",
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
			y = 4
		},
		{
			direction = 1,
			x = 6,
			y = 4
		},
		{
			direction = 1,
			x = 7,
			y = 4
		},
		{
			direction = 3,
			x = 5,
			y = 3
		},
		{
			direction = 3,
			x = 7,
			y = 3
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "精英幻影",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 15005301,
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
			groupName = "幻影普通1",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 15005302,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 15005302,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 15005302,
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "幻影普通2",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 15005303,
					x = 5,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 15005303,
					x = 1,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 3,
					tag = "",
					monsterId = 15005303,
					x = 1,
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
			groupName = "绿色小特异",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 15005304,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 15005304,
					x = 5,
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
		[15005301] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 111.2,
			maxHp = 46102,
			aiName = "ai_120089_花剑雨伞",
			battleCamp = 1,
			career = 1,
			magicAtk = 111.2,
			pre_meleeDef = 552,
			sanity = 0,
			remark = "幻影精英怪（主动攻击时追击；位移再动追击强化）",
			giftSkill = 1208905,
			weakPointHpRate = 0.3,
			meleeDef = 552,
			level = 66,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1111.8,
			pre_meleeAtk = 1111.8,
			pre_maxHp = 46102,
			colorType = 1,
			monsterType = 1,
			id = 15005301,
			mobility = 4,
			pre_magicDef = 347.7,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 71.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 71.3,
			modelId = 120089,
			magicDef = 347.7,
			specialSkill = 1208904,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[15005302] = {
			normalSkill = 1201601,
			name = "巡逻道闸",
			pre_magicAtk = 105.8,
			maxHp = 7484.7,
			aiName = "ai_120016_巡逻道闸",
			battleCamp = 1,
			career = 1,
			magicAtk = 105.8,
			pre_meleeDef = 496.8,
			sanity = 0,
			remark = "幻影小怪",
			giftSkill = 1201602,
			weakPointHpRate = 0,
			meleeDef = 496.8,
			level = 66,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1057.9,
			pre_meleeAtk = 1057.9,
			pre_maxHp = 7484.7,
			colorType = 1,
			monsterType = 0,
			id = 15005302,
			mobility = 4,
			pre_magicDef = 312.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 68.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 68.3,
			modelId = 120016,
			magicDef = 312.9,
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
		[15005303] = {
			normalSkill = 1201501,
			name = "虫态补光灯",
			pre_magicAtk = 105.8,
			maxHp = 7484.7,
			aiName = "ai_120015_矿工探灯",
			battleCamp = 1,
			career = 1,
			magicAtk = 105.8,
			pre_meleeDef = 496.8,
			sanity = 0,
			remark = "幻影小怪（普攻破甲+追击）",
			giftSkill = 1201502,
			weakPointHpRate = 0,
			meleeDef = 496.8,
			level = 66,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1057.9,
			pre_meleeAtk = 1057.9,
			pre_maxHp = 7484.7,
			colorType = 1,
			monsterType = 0,
			id = 15005303,
			mobility = 4,
			pre_magicDef = 312.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 68.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 68.3,
			modelId = 120015,
			magicDef = 312.9,
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
		[15005304] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 1243.4,
			maxHp = 5420.7,
			aiName = "ai_120068_噩梦圆规",
			battleCamp = 1,
			career = 4,
			magicAtk = 1243.4,
			pre_meleeDef = 315.6,
			sanity = 0,
			remark = "绿特异小怪",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 315.6,
			level = 66,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 124.3,
			pre_meleeAtk = 124.3,
			pre_maxHp = 5420.7,
			colorType = 3,
			monsterType = 0,
			id = 15005304,
			mobility = 2,
			pre_magicDef = 461.1,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 78.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 78.3,
			modelId = 120068,
			magicDef = 461.1,
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
