-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150068.lua

module("logic.config.leveleditor.t_level_config_150068", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150068",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面68",
	lossConditionDesc = "",
	sceneId = "108003",
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
			direction = 4,
			x = 10,
			y = 9
		},
		{
			direction = 4,
			x = 10,
			y = 8
		},
		{
			direction = 4,
			x = 10,
			y = 7
		},
		{
			direction = 3,
			x = 6,
			y = 11
		},
		{
			direction = 3,
			x = 5,
			y = 11
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
			groupName = "超级路灯",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 15006801,
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
			groupName = "小路灯",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 15006802,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 15006802,
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
			groupName = "支援小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 15006803,
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
			groupName = "特异小怪",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 15006804,
					x = 4,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 15006804,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 15006804,
					x = 9,
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
		[15006801] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 160,
			maxHp = 60919.3,
			aiName = "ai_120088_狂欢路灯",
			battleCamp = 1,
			career = 3,
			magicAtk = 160,
			pre_meleeDef = 627.2,
			sanity = 0,
			remark = "狙击精英-高难度",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 627.2,
			level = 77,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1599.8,
			pre_meleeAtk = 1599.8,
			pre_maxHp = 60919.3,
			colorType = 3,
			monsterType = 1,
			id = 15006801,
			mobility = 2,
			pre_magicDef = 443.8,
			aiStepOrder = 1,
			trumpSkill = 1208805,
			isFuzzy = false,
			inspire = 88.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 88.8,
			modelId = 120088,
			magicDef = 443.8,
			specialSkill = 1208802,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[15006802] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 143.5,
			maxHp = 9832.1,
			aiName = "ai_120088_狂欢路灯",
			battleCamp = 1,
			career = 3,
			magicAtk = 143.5,
			pre_meleeDef = 564.5,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 564.5,
			level = 77,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1434.7,
			pre_meleeAtk = 1434.7,
			pre_maxHp = 9832.1,
			colorType = 3,
			monsterType = 0,
			id = 15006802,
			mobility = 2,
			pre_magicDef = 399.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 85.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 85.8,
			modelId = 120088,
			magicDef = 399.4,
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
		[15006803] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 1533.4,
			maxHp = 8600.2,
			aiName = "ai_120031_再生",
			battleCamp = 1,
			career = 6,
			magicAtk = 1533.4,
			pre_meleeDef = 431.1,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 431.1,
			level = 77,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 153.3,
			pre_meleeAtk = 153.3,
			pre_maxHp = 8600.2,
			colorType = 4,
			monsterType = 0,
			id = 15006803,
			mobility = 2,
			pre_magicDef = 607.3,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 65.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65.8,
			modelId = 120031,
			magicDef = 607.3,
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
		[15006804] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1609.4,
			maxHp = 8261.2,
			aiName = "ai_120029_蜉蝣",
			battleCamp = 1,
			career = 4,
			magicAtk = 1609.4,
			pre_meleeDef = 399.4,
			sanity = 0,
			remark = "蓝特异小怪（主动攻击时触发超感；超感范围+1）",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 399.4,
			level = 77,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 160.9,
			pre_meleeAtk = 160.9,
			pre_maxHp = 8261.2,
			colorType = 2,
			monsterType = 0,
			id = 15006804,
			mobility = 2,
			pre_magicDef = 564.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 85.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 85.8,
			modelId = 120029,
			magicDef = 564.5,
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
