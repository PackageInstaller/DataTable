-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_151018.lua

module("logic.config.leveleditor.t_level_config_151018", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "151018",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "样板爬塔18",
	lossConditionDesc = "",
	sceneId = "9000006",
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
			x = 6,
			y = 10
		},
		{
			direction = 2,
			x = 5,
			y = 9
		},
		{
			direction = 2,
			x = 4,
			y = 10
		},
		{
			direction = 2,
			x = 2,
			y = 10
		},
		{
			direction = 2,
			x = 3,
			y = 12
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
			groupName = "中心组",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15101802,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 15101801,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 15101802,
					x = 8,
					initialStatus = {
						hpPercent = 0,
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
			groupName = "外围组",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 14,
					tag = "",
					monsterId = 15101804,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 14,
					tag = "",
					monsterId = 15101804,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 13,
					tag = "",
					monsterId = 15101804,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 15101803,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 15101803,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 15101803,
					x = 1,
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
		[15101801] = {
			normalSkill = 1283101,
			name = "迷雾使徒",
			pre_magicAtk = 277.4,
			maxHp = 509.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 277.4,
			pre_meleeDef = 51.5,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 51.5,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 111,
			pre_meleeAtk = 111,
			pre_maxHp = 509.4,
			colorType = 1,
			monsterType = 1,
			id = 15101801,
			mobility = 2,
			pre_magicDef = 78.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 31.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 31.9,
			modelId = 120035,
			magicDef = 78.2,
			specialSkill = 1283102,
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
		[15101802] = {
			normalSkill = 1281501,
			name = "迷雾使徒",
			pre_magicAtk = 277.4,
			maxHp = 178.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 277.4,
			pre_meleeDef = 51.5,
			sanity = 0,
			remark = "",
			giftSkill = 1281502,
			weakPointHpRate = 0,
			meleeDef = 51.5,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 111,
			pre_meleeAtk = 111,
			pre_maxHp = 178.3,
			colorType = 1,
			monsterType = 0,
			id = 15101802,
			mobility = 2,
			pre_magicDef = 78.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 31.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 31.9,
			modelId = 120035,
			magicDef = 78.2,
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
		[15101803] = {
			normalSkill = 1281201,
			name = "迷雾使徒",
			pre_magicAtk = 100.4,
			maxHp = 235.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 100.4,
			pre_meleeDef = 64.8,
			sanity = 0,
			remark = "",
			giftSkill = 1281202,
			weakPointHpRate = 0,
			meleeDef = 64.8,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 255,
			pre_meleeAtk = 255,
			pre_maxHp = 235.4,
			colorType = 1,
			monsterType = 0,
			id = 15101803,
			mobility = 3,
			pre_magicDef = 59.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.4,
			modelId = 120006,
			magicDef = 59.8,
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
		[15101804] = {
			normalSkill = 1281401,
			name = "迷雾使徒",
			pre_magicAtk = 111,
			maxHp = 178.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 111,
			pre_meleeDef = 68,
			sanity = 0,
			remark = "",
			giftSkill = 1281402,
			weakPointHpRate = 0,
			meleeDef = 68,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 277.4,
			pre_meleeAtk = 277.4,
			pre_maxHp = 178.3,
			colorType = 3,
			monsterType = 0,
			id = 15101804,
			mobility = 2,
			pre_magicDef = 51.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 31.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 31.9,
			modelId = 120008,
			magicDef = 51.5,
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
		}
	}
}

return configData
