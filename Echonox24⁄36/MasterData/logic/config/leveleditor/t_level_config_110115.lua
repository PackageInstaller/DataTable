-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110115.lua

module("logic.config.leveleditor.t_level_config_110115", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "整体推移，删除怪物，告诉玩家往前走的同时，保留移动甩进去的可能性",
	levelId = "110115",
	plotEventGroup = 110115,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通1-15",
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
			x = 5,
			y = 7
		},
		{
			direction = 2,
			x = 4,
			y = 8
		},
		{
			direction = 2,
			x = 4,
			y = 7
		},
		{
			direction = 2,
			x = 4,
			y = 6
		},
		{
			direction = 2,
			x = 3,
			y = 7
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 10,
					y = 8
				},
				{
					x = 11,
					y = 8
				},
				{
					x = 12,
					y = 8
				},
				{
					x = 10,
					y = 7
				},
				{
					x = 11,
					y = 7
				},
				{
					x = 12,
					y = 7
				},
				{
					x = 10,
					y = 6
				},
				{
					x = 11,
					y = 6
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
					heroId = 2000022,
					count = 0,
					monsterTag = "",
					DIYName = "飞鸟撤离",
					condition = 8,
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
			groupName = "第一阶梯",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11011502,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 11011502,
					x = 7,
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
			groupName = "第二阶梯",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 11011503,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 11011503,
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
			groupName = "门前",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11011501,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 2000022,
			direction = 2,
			heroType = 1,
			monsterId = 11011502,
			pos = {
				x = 5,
				y = 7
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[11011501] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 10.2,
			maxHp = 330.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 10.2,
			pre_meleeDef = 62.4,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 62.4,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 101.8,
			pre_meleeAtk = 101.8,
			pre_maxHp = 330.3,
			colorType = 2,
			monsterType = 0,
			id = 11011501,
			mobility = 2,
			pre_magicDef = 28.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 25.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 25.5,
			modelId = 120090,
			magicDef = 28.8,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			}
		},
		[11011502] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 10.8,
			maxHp = 232.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 10.8,
			pre_meleeDef = 51.2,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 51.2,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 108.5,
			pre_meleeAtk = 108.5,
			pre_maxHp = 232.3,
			colorType = 3,
			monsterType = 0,
			id = 11011502,
			mobility = 2,
			pre_magicDef = 28.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.5,
			modelId = 120088,
			magicDef = 28.8,
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
		[11011503] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 10.5,
			maxHp = 266.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 10.5,
			pre_meleeDef = 57.6,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 57.6,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 104.8,
			pre_meleeAtk = 104.8,
			pre_maxHp = 266.6,
			colorType = 1,
			monsterType = 0,
			id = 11011503,
			mobility = 4,
			pre_magicDef = 28.8,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35.5,
			modelId = 120089,
			magicDef = 28.8,
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
		[11011504] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 11.1,
			maxHp = 2158.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 11.1,
			pre_meleeDef = 78,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 78,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 110.6,
			pre_meleeAtk = 110.6,
			pre_maxHp = 2158.4,
			colorType = 2,
			monsterType = 1,
			id = 11011504,
			mobility = 2,
			pre_magicDef = 36,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 33.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 33.5,
			modelId = 120090,
			magicDef = 36,
			specialSkill = 1209003,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			}
		},
		[11011505] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 13.3,
			maxHp = 1599.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 13.3,
			pre_meleeDef = 64,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 64,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 133.4,
			pre_meleeAtk = 133.4,
			pre_maxHp = 1599.3,
			colorType = 3,
			monsterType = 1,
			id = 11011505,
			mobility = 2,
			pre_magicDef = 36,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 53.5,
			modelId = 120088,
			magicDef = 36,
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
		[11011506] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 12.2,
			maxHp = 1784.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 12.2,
			pre_meleeDef = 72,
			sanity = 0,
			remark = "",
			giftSkill = 1208903,
			weakPointHpRate = 0.3,
			meleeDef = 72,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 122.2,
			pre_meleeAtk = 122.2,
			pre_maxHp = 1784.7,
			colorType = 1,
			monsterType = 1,
			id = 11011506,
			mobility = 4,
			pre_magicDef = 36,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 43.5,
			modelId = 120089,
			magicDef = 36,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			}
		}
	}
}

return configData
