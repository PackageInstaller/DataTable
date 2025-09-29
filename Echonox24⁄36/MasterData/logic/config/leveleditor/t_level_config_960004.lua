-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_960004.lua

module("logic.config.leveleditor.t_level_config_960004", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "960004",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "CPJ-H1.4",
	lossConditionDesc = "",
	sceneId = "112001",
	winConditionDesc = "消灭所有敌方单位且撤离单位数不超过3个",
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
			x = 8,
			y = 9
		},
		{
			direction = 3,
			x = 10,
			y = 9
		},
		{
			direction = 1,
			x = 8,
			y = 5
		},
		{
			direction = 1,
			x = 9,
			y = 5
		},
		{
			direction = 1,
			x = 10,
			y = 5
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1004,
			times = 0,
			posList = {
				{
					x = 11,
					y = 8
				},
				{
					x = 11,
					y = 7
				},
				{
					x = 11,
					y = 6
				},
				{
					x = 12,
					y = 8
				},
				{
					x = 12,
					y = 7
				},
				{
					x = 12,
					y = 6
				}
			}
		}
	},
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
			condition = 6,
			maxDeadCount = 0,
			count = 3,
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
			groupName = "第一回合保镖",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 96000402,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 96000402,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 96000403,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 96000403,
					x = 4,
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "第一回合明星",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 96000401,
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
			refreshType = 2,
			form = 5,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "第二回合快速迫近",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 96000404,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 96000404,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 96000403,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 96000403,
					x = 2,
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
		[96000401] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 12.8,
			maxHp = 1944,
			aiName = "ai_Hard1.4_Run",
			battleCamp = 1,
			career = 1,
			magicAtk = 12.8,
			pre_meleeDef = 74.5,
			sanity = 0,
			remark = "幻影精英怪（主动攻击时追击；位移再动追击强化）",
			giftSkill = 1208905,
			weakPointHpRate = 0.3,
			meleeDef = 74.5,
			level = 11,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 128,
			pre_meleeAtk = 128,
			pre_maxHp = 1944,
			colorType = 1,
			monsterType = 1,
			id = 96000401,
			mobility = 4,
			pre_magicDef = 37,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 43.8,
			modelId = 120089,
			magicDef = 37,
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
		[96000402] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 10.6,
			maxHp = 505.85,
			aiName = "ai_Hard1.4_Run",
			battleCamp = 1,
			career = 2,
			magicAtk = 10.6,
			pre_meleeDef = 68.4,
			sanity = 0,
			remark = "守卫小怪（反击后触发振荡）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 68.4,
			level = 11,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 106.2,
			pre_meleeAtk = 106.2,
			pre_maxHp = 505.85,
			colorType = 2,
			monsterType = 0,
			id = 96000402,
			mobility = 2,
			pre_magicDef = 31.9,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 28.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 28.3,
			modelId = 120090,
			magicDef = 31.9,
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
		[96000403] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 11,
			maxHp = 409.3,
			aiName = "ai_Hard1.4_Run",
			battleCamp = 1,
			career = 1,
			magicAtk = 11,
			pre_meleeDef = 63.3,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 63.3,
			level = 11,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 109.4,
			pre_meleeAtk = 109.4,
			pre_maxHp = 409.3,
			colorType = 1,
			monsterType = 0,
			id = 96000403,
			mobility = 4,
			pre_magicDef = 31.45,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 38.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.3,
			modelId = 120089,
			magicDef = 31.45,
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
		[96000404] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 11.3,
			maxHp = 357.8,
			aiName = "ai_Hard1.4_Run",
			battleCamp = 1,
			career = 3,
			magicAtk = 11.3,
			pre_meleeDef = 56.5,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 56.5,
			level = 11,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 113.4,
			pre_meleeAtk = 113.4,
			pre_maxHp = 357.8,
			colorType = 3,
			monsterType = 0,
			id = 96000404,
			mobility = 2,
			pre_magicDef = 31.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 48.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 48.3,
			modelId = 120088,
			magicDef = 31.9,
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
