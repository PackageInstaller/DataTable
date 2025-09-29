-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110507.lua

module("logic.config.leveleditor.t_level_config_110507", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "",
	levelId = "110507",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通5-7",
	lossConditionDesc = "",
	sceneId = "109003",
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
			y = 13
		},
		{
			direction = 3,
			x = 7,
			y = 13
		},
		{
			direction = 3,
			x = 8,
			y = 13
		},
		{
			direction = 3,
			x = 9,
			y = 13
		},
		{
			direction = 3,
			x = 10,
			y = 13
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 7,
					y = 5
				}
			}
		},
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 8,
					y = 5
				}
			}
		},
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 9,
					y = 5
				}
			}
		},
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 8,
					y = 4
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
					count = 2,
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
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 11050701,
					x = 8,
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
					monsterId = 11050702,
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
			groupName = "怪物组2",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 11050702,
					x = 13,
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
					monsterId = 11050702,
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
					monsterId = 11050702,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 11050702,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 11050702,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 12,
					tag = "",
					monsterId = 11050702,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 13,
					tag = "",
					monsterId = 11050702,
					x = 14,
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
		[11050701] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 71.3,
			maxHp = 30554.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 71.3,
			pre_meleeDef = 371.2,
			sanity = 0,
			remark = "幻影精英怪（主动攻击时追击；位移再动追击强化）",
			giftSkill = 1208905,
			weakPointHpRate = 0.3,
			meleeDef = 371.2,
			level = 56,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 713.1,
			pre_meleeAtk = 713.1,
			pre_maxHp = 30554.6,
			colorType = 1,
			monsterType = 1,
			id = 11050701,
			mobility = 4,
			pre_magicDef = 218.4,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 66.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 66.4,
			modelId = 120089,
			magicDef = 218.4,
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
		[11050702] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 59.5,
			maxHp = 8317.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 59.5,
			pre_meleeDef = 334.1,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 334.1,
			level = 56,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 594.5,
			pre_meleeAtk = 594.5,
			pre_maxHp = 8317.5,
			colorType = 1,
			monsterType = 0,
			id = 11050702,
			mobility = 4,
			pre_magicDef = 196.6,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 63.4,
			modelId = 120089,
			magicDef = 196.6,
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
		[11050703] = {
			normalSkill = 1201501,
			name = "虫态补光灯",
			pre_magicAtk = 59.5,
			maxHp = 8317.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 59.5,
			pre_meleeDef = 334.1,
			sanity = 0,
			remark = "幻影小怪（普攻破甲+追击）",
			giftSkill = 1201502,
			weakPointHpRate = 0,
			meleeDef = 334.1,
			level = 56,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 594.5,
			pre_meleeAtk = 594.5,
			pre_maxHp = 8317.5,
			colorType = 1,
			monsterType = 0,
			id = 11050703,
			mobility = 4,
			pre_magicDef = 196.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 63.4,
			modelId = 120015,
			magicDef = 196.6,
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
		[11050704] = {
			normalSkill = 1201503,
			name = "虫态补光灯",
			pre_magicAtk = 71.3,
			maxHp = 30554.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 71.3,
			pre_meleeDef = 371.2,
			sanity = 0,
			remark = "幻影精英（普攻破甲+追击强化）",
			giftSkill = 1201504,
			weakPointHpRate = 0.3,
			meleeDef = 371.2,
			level = 56,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 713.1,
			pre_meleeAtk = 713.1,
			pre_maxHp = 30554.6,
			colorType = 1,
			monsterType = 1,
			id = 11050704,
			mobility = 4,
			pre_magicDef = 218.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 66.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 66.4,
			modelId = 120015,
			magicDef = 218.4,
			specialSkill = 1201505,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
