-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110332.lua

module("logic.config.leveleditor.t_level_config_110332", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "主线困难3-2",
	levelId = "110332",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "困难3-2",
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
			direction = 1,
			x = 7,
			y = 9
		},
		{
			direction = 1,
			x = 8,
			y = 9
		},
		{
			direction = 1,
			x = 9,
			y = 9
		},
		{
			direction = 2,
			x = 10,
			y = 9
		},
		{
			direction = 4,
			x = 6,
			y = 9
		},
		{
			direction = 3,
			x = 7,
			y = 8
		},
		{
			direction = 3,
			x = 8,
			y = 8
		},
		{
			direction = 3,
			x = 9,
			y = 8
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
					round = 3,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 2,
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
			form = 5,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "精英路灯",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 11033201,
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
			groupName = "普通路灯",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 11033202,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 11033202,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 11033202,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 11033202,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 11033202,
					x = 9,
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
			groupName = "雨伞",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 4,
					tag = "",
					monsterId = 11033203,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 11033203,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 11033203,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 11033203,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 11033203,
					x = 3,
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
					monsterId = 11033203,
					x = 13,
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
					monsterId = 11033203,
					x = 13,
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
			groupName = "陨灭车轴",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 11033204,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 11033204,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 11033204,
					x = 10,
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
		[11033201] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 50.6,
			maxHp = 12527,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 50.6,
			pre_meleeDef = 229,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 229,
			level = 40,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 506.4,
			pre_meleeAtk = 506.4,
			pre_maxHp = 12527,
			colorType = 3,
			monsterType = 1,
			id = 11033201,
			mobility = 2,
			pre_magicDef = 136,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 68,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 68,
			modelId = 120088,
			magicDef = 136,
			specialSkill = 1208802,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			}
		},
		[11033202] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 40.3,
			maxHp = 3397.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 40.3,
			pre_meleeDef = 206.1,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 206.1,
			level = 40,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 403.1,
			pre_meleeAtk = 403.1,
			pre_maxHp = 3397.5,
			colorType = 3,
			monsterType = 0,
			id = 11033202,
			mobility = 2,
			pre_magicDef = 122.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120088,
			magicDef = 122.4,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			}
		},
		[11033203] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 38.8,
			maxHp = 3891.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 38.8,
			pre_meleeDef = 226.8,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 226.8,
			level = 40,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 388,
			pre_meleeAtk = 388,
			pre_maxHp = 3891.1,
			colorType = 1,
			monsterType = 0,
			id = 11033203,
			mobility = 4,
			pre_magicDef = 120.6,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120089,
			magicDef = 120.6,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		},
		[11033204] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 39.6,
			maxHp = 3468.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 39.6,
			pre_meleeDef = 216,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时,主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 216,
			level = 40,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 395.5,
			pre_meleeAtk = 395.5,
			pre_maxHp = 3468.6,
			colorType = 4,
			monsterType = 0,
			id = 11033204,
			mobility = 1,
			pre_magicDef = 144,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120069,
			magicDef = 144,
			specialSkill = 1206902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		}
	}
}

return configData
