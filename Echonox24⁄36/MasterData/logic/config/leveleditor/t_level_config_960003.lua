-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_960003.lua

module("logic.config.leveleditor.t_level_config_960003", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "新困难1.3",
	levelId = "960003",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "CPJ-H1.3",
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
			x = 4,
			y = 6
		},
		{
			direction = 2,
			x = 6,
			y = 6
		},
		{
			direction = 2,
			x = 6,
			y = 5
		},
		{
			direction = 4,
			x = 4,
			y = 5
		},
		{
			direction = 1,
			x = 5,
			y = 4
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
			condition = 2,
			maxDeadCount = 0,
			count = 0,
			hasTag = false,
			DIYName = "",
			isBackup = false,
			tag = "",
			targetId = 96000301,
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
			groupName = "保护怪物",
			color = 8,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 96000301,
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "高台怪",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 96000302,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 3,
					tag = "",
					monsterId = 96000302,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 96000302,
					x = 8,
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
					monsterId = 96000302,
					x = 8,
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
			groupName = "第一回合地面迫近怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 96000304,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 96000304,
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
			refreshType = 2,
			form = 3,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "第二回合精英",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 96000303,
					x = 4,
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
		[96000301] = {
			normalSkill = 1200601,
			name = "迷雾使徒",
			pre_magicAtk = 11.4,
			maxHp = 440.95,
			aiName = "",
			battleCamp = 3,
			career = 1,
			magicAtk = 11.4,
			pre_meleeDef = 65.45,
			sanity = 0,
			remark = "幻影小怪保护用",
			giftSkill = 1200602,
			weakPointHpRate = 0,
			meleeDef = 65.45,
			level = 12,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 114.1,
			pre_meleeAtk = 114.1,
			pre_maxHp = 440.95,
			colorType = 1,
			monsterType = 0,
			id = 96000301,
			mobility = 4,
			pre_magicDef = 32.3,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 38.5,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.5,
			modelId = 120006,
			magicDef = 32.3,
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
		[96000302] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 14,
			maxHp = 1729.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 14,
			pre_meleeDef = 66.5,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 66.5,
			level = 11,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 139.9,
			pre_meleeAtk = 139.9,
			pre_maxHp = 1729.6,
			colorType = 3,
			monsterType = 1,
			id = 96000302,
			mobility = 2,
			pre_magicDef = 37.5,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 53.8,
			modelId = 120088,
			magicDef = 37.5,
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
		[96000303] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 12.8,
			maxHp = 1944,
			aiName = "mob_active_ai",
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
			id = 96000303,
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
		[96000304] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 10.6,
			maxHp = 505.85,
			aiName = "mob_active_ai",
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
			id = 96000304,
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
		}
	}
}

return configData
