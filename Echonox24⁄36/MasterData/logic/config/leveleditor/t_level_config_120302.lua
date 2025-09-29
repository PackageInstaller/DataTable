-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120302.lua

module("logic.config.leveleditor.t_level_config_120302", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120302",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "3-断章A-2",
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
			direction = 1,
			x = 8,
			y = 4
		},
		{
			direction = 1,
			x = 7,
			y = 3
		},
		{
			direction = 1,
			x = 9,
			y = 3
		},
		{
			direction = 1,
			x = 7,
			y = 4
		},
		{
			direction = 1,
			x = 9,
			y = 4
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1007,
			times = 1,
			posList = {
				{
					x = 7,
					y = 9
				},
				{
					x = 8,
					y = 9
				}
			}
		},
		{
			terrainId = 1001,
			times = 0,
			posList = {
				{
					x = 3,
					y = 3
				},
				{
					x = 12,
					y = 3
				},
				{
					x = 2,
					y = 4
				},
				{
					x = 13,
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
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 3,
					monsterIds = {
						12030201
					}
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 12030201,
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "盾",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 12030203,
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
					monsterId = 12030203,
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
			refreshType = 2,
			form = 4,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "陨灭",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 12030204,
					x = 5,
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
					monsterId = 12030204,
					x = 10,
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
					monsterId = 12030204,
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
			groupName = "狙",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 12030202,
					x = 11,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 12030202,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 12030202,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 12030202,
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "陨灭2",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 12030204,
					x = 13,
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
					monsterId = 12030204,
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
		[12030201] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 30.3,
			maxHp = 9759.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 30.3,
			pre_meleeDef = 205.6,
			sanity = 0,
			remark = "守卫精英（受到攻击后获得1层[坚韧]）",
			giftSkill = 1201402,
			weakPointHpRate = 0.3,
			meleeDef = 205.6,
			level = 27,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 302.7,
			pre_meleeAtk = 302.7,
			pre_maxHp = 9759.6,
			colorType = 2,
			monsterType = 1,
			id = 12030201,
			mobility = 2,
			pre_magicDef = 101.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 42.1,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 42.1,
			modelId = 120014,
			magicDef = 101.4,
			specialSkill = 1201404,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		},
		[12030202] = {
			normalSkill = 1200801,
			name = "迷雾使徒",
			pre_magicAtk = 29.7,
			maxHp = 1930.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 29.7,
			pre_meleeDef = 156.6,
			sanity = 0,
			remark = "狙击小怪",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 156.6,
			level = 27,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 296.7,
			pre_meleeAtk = 296.7,
			pre_maxHp = 1930.6,
			colorType = 3,
			monsterType = 0,
			id = 12030202,
			mobility = 2,
			pre_magicDef = 91.6,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.1,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.1,
			modelId = 120008,
			magicDef = 91.6,
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
		[12030203] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 27.7,
			maxHp = 2718.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 27.7,
			pre_meleeDef = 185,
			sanity = 0,
			remark = "守卫小怪（受到攻击后锥刺）",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 185,
			level = 27,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 277.2,
			pre_meleeAtk = 277.2,
			pre_maxHp = 2718.7,
			colorType = 2,
			monsterType = 0,
			id = 12030203,
			mobility = 2,
			pre_magicDef = 91.3,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 39.1,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 39.1,
			modelId = 120014,
			magicDef = 91.3,
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
		[12030204] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 29.2,
			maxHp = 1974.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 29.2,
			pre_meleeDef = 163.6,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 163.6,
			level = 27,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 291.3,
			pre_meleeAtk = 291.3,
			pre_maxHp = 1974.1,
			colorType = 4,
			monsterType = 0,
			id = 12030204,
			mobility = 1,
			pre_magicDef = 107.5,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 49.1,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 49.1,
			modelId = 120069,
			magicDef = 107.5,
			specialSkill = 1206902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
