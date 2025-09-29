-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110436.lua

module("logic.config.leveleditor.t_level_config_110436", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "主线困难5-6",
	levelId = "110436",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "困难4-6",
	lossConditionDesc = "",
	sceneId = "116003",
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
			x = 9,
			y = 8
		},
		{
			direction = 4,
			x = 9,
			y = 7
		},
		{
			direction = 4,
			x = 9,
			y = 6
		},
		{
			direction = 3,
			x = 9,
			y = 5
		},
		{
			direction = 3,
			x = 9,
			y = 4
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 1,
			posList = {
				{
					x = 5,
					y = 3
				}
			}
		},
		{
			terrainId = 1005,
			times = 1,
			posList = {
				{
					x = 4,
					y = 3
				}
			}
		},
		{
			terrainId = 1005,
			times = 1,
			posList = {
				{
					x = 7,
					y = 12
				}
			}
		},
		{
			terrainId = 1005,
			times = 1,
			posList = {
				{
					x = 8,
					y = 12
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
					count = 3,
					monsterTag = "",
					DIYName = "",
					condition = 7,
					monsterIds = {}
				}
			}
		},
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
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 11043604,
					x = 9,
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
					monsterId = 11043606,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11043604,
					x = 7,
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
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 11043603,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 11043603,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 2,
					tag = "",
					monsterId = 11043603,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 0,
					tag = "",
					monsterId = 11043603,
					x = 3,
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
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 11043602,
					x = 10,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 11043602,
					x = 9,
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
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 11043601,
					x = 9,
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
		[11043601] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 83.3,
			maxHp = 35789.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 83.3,
			pre_meleeDef = 411,
			sanity = 0,
			remark = "幻影精英怪（主动攻击时追击；位移再动追击强化）",
			giftSkill = 1208905,
			weakPointHpRate = 0.3,
			meleeDef = 411,
			level = 59,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 833.4,
			pre_meleeAtk = 833.4,
			pre_maxHp = 35789.6,
			colorType = 1,
			monsterType = 1,
			id = 11043601,
			mobility = 4,
			pre_magicDef = 252.8,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 67.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 67.6,
			modelId = 120089,
			magicDef = 252.8,
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
		[11043602] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 79.3,
			maxHp = 5703.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 79.3,
			pre_meleeDef = 369.9,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 369.9,
			level = 59,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 792.7,
			pre_meleeAtk = 792.7,
			pre_maxHp = 5703.5,
			colorType = 1,
			monsterType = 0,
			id = 11043602,
			mobility = 4,
			pre_magicDef = 227.5,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 64.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 64.6,
			modelId = 120089,
			magicDef = 227.5,
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
		[11043603] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 83.5,
			maxHp = 4906.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 83.5,
			pre_meleeDef = 341.5,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 341.5,
			level = 59,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 835.1,
			pre_meleeAtk = 835.1,
			pre_maxHp = 4906.3,
			colorType = 3,
			monsterType = 0,
			id = 11043603,
			mobility = 2,
			pre_magicDef = 230,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 74.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 74.6,
			modelId = 120088,
			magicDef = 230,
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
		[11043604] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 75.7,
			maxHp = 7092.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 75.7,
			pre_meleeDef = 394.9,
			sanity = 0,
			remark = "守卫小怪（反击后触发振荡）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 394.9,
			level = 59,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 757.3,
			pre_meleeAtk = 757.3,
			pre_maxHp = 7092.6,
			colorType = 2,
			monsterType = 0,
			id = 11043604,
			mobility = 2,
			pre_magicDef = 228.4,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 54.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 54.6,
			modelId = 120090,
			magicDef = 228.4,
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
		[11043605] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 92.7,
			maxHp = 31088.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 92.7,
			pre_meleeDef = 379.4,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 379.4,
			level = 59,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 927.3,
			pre_meleeAtk = 927.3,
			pre_maxHp = 31088.3,
			colorType = 3,
			monsterType = 1,
			id = 11043605,
			mobility = 2,
			pre_magicDef = 255.6,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 77.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 77.6,
			modelId = 120088,
			magicDef = 255.6,
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
		[11043606] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 73.6,
			maxHp = 44084.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 73.6,
			pre_meleeDef = 438.8,
			sanity = 0,
			remark = "守卫精英（振荡2次；范围变大）",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 438.8,
			level = 59,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 735.3,
			pre_meleeAtk = 735.3,
			pre_maxHp = 44084.6,
			colorType = 2,
			monsterType = 1,
			id = 11043606,
			mobility = 2,
			pre_magicDef = 253.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 57.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 57.6,
			modelId = 120090,
			magicDef = 253.8,
			specialSkill = 1209003,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
