-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110431.lua

module("logic.config.leveleditor.t_level_config_110431", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "主线困难4-1",
	levelId = "110431",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "困难4-1",
	lossConditionDesc = "",
	sceneId = "116001",
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
			x = 10,
			y = 1
		},
		{
			direction = 1,
			x = 11,
			y = 1
		},
		{
			direction = 2,
			x = 3,
			y = 4
		},
		{
			direction = 2,
			x = 3,
			y = 3
		},
		{
			direction = 2,
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
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 11043104,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 11043104,
					x = 5,
					initialStatus = {
						hpPercent = 100,
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
			groupName = "怪物组2",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11043103,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 11043103,
					x = 10,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 11043103,
					x = 11,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 11043103,
					x = 6,
					initialStatus = {
						hpPercent = 100,
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
			groupName = "怪物组3",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 3,
					tag = "",
					monsterId = 11043102,
					x = 11,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 3,
					tag = "",
					monsterId = 11043102,
					x = 10,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 5,
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
					y = 3,
					tag = "",
					monsterId = 11043101,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[11043101] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 62.2,
			maxHp = 23293.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 62.2,
			pre_meleeDef = 316,
			sanity = 0,
			remark = "幻影精英怪（主动攻击时追击；位移再动追击强化）",
			giftSkill = 1208905,
			weakPointHpRate = 0.3,
			meleeDef = 316,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 622,
			pre_meleeAtk = 622,
			pre_maxHp = 23293.1,
			colorType = 1,
			monsterType = 1,
			id = 11043101,
			mobility = 4,
			pre_magicDef = 182,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 63,
			modelId = 120089,
			magicDef = 182,
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
		[11043102] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 59.2,
			maxHp = 3674.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 59.2,
			pre_meleeDef = 284.4,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 284.4,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 592.5,
			pre_meleeAtk = 592.5,
			pre_maxHp = 3674.6,
			colorType = 1,
			monsterType = 0,
			id = 11043102,
			mobility = 4,
			pre_magicDef = 163.8,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120089,
			magicDef = 163.8,
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
		[11043103] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 693.9,
			maxHp = 2678.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 693.9,
			pre_meleeDef = 165.6,
			sanity = 0,
			remark = "绿特异小怪（主动攻击时触发超感；超感范围+1）",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 165.6,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 69.4,
			pre_meleeAtk = 69.4,
			pre_maxHp = 2678.7,
			colorType = 3,
			monsterType = 0,
			id = 11043103,
			mobility = 2,
			pre_magicDef = 260.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120029,
			magicDef = 260.1,
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
		[11043104] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 62.3,
			maxHp = 3188,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 62.3,
			pre_meleeDef = 260.1,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 260.1,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 623.2,
			pre_meleeAtk = 623.2,
			pre_maxHp = 3188,
			colorType = 3,
			monsterType = 0,
			id = 11043104,
			mobility = 2,
			pre_magicDef = 165.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120088,
			magicDef = 165.6,
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
		[11043105] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 761.1,
			maxHp = 17178.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 761.1,
			pre_meleeDef = 184,
			sanity = 0,
			remark = "绿特异精英（主动攻击时触发强化超感；获得高昂）",
			giftSkill = 1202902,
			weakPointHpRate = 0.3,
			meleeDef = 184,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 76.1,
			pre_meleeAtk = 76.1,
			pre_maxHp = 17178.6,
			colorType = 3,
			monsterType = 1,
			id = 11043105,
			mobility = 2,
			pre_magicDef = 289,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 73,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 73,
			modelId = 120029,
			magicDef = 289,
			specialSkill = 1202904,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[11043106] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 69,
			maxHp = 20444.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 69,
			pre_meleeDef = 289,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 289,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 690,
			pre_meleeAtk = 690,
			pre_maxHp = 20444.9,
			colorType = 3,
			monsterType = 1,
			id = 11043106,
			mobility = 2,
			pre_magicDef = 184,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 73,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 73,
			modelId = 120088,
			magicDef = 184,
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
		}
	}
}

return configData
