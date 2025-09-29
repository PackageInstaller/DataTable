-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_940005.lua

module("logic.config.leveleditor.t_level_config_940005", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "国坤80级精英关卡配置",
	levelId = "940005",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "修狗也能打过",
	lossConditionDesc = "",
	sceneId = "111001",
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
			x = 3,
			y = 8
		},
		{
			direction = 3,
			x = 4,
			y = 8
		},
		{
			direction = 3,
			x = 5,
			y = 8
		},
		{
			direction = 2,
			x = 6,
			y = 11
		},
		{
			direction = 2,
			x = 6,
			y = 10
		},
		{
			direction = 2,
			x = 6,
			y = 9
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
			groupName = "倒霉蛋守卫",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 94000502,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 94000502,
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "狂轰乱炸",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 94000501,
					x = 3,
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
					monsterId = 94000501,
					x = 12,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 94000501,
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
			groupName = "追着你打",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 94000503,
					x = 1,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 14,
					tag = "",
					monsterId = 94000503,
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
					monsterId = 94000503,
					x = 0,
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
					monsterId = 94000503,
					x = 2,
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
			groupName = "奶妈",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 94000504,
					x = 11,
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
		[94000501] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 106.3,
			maxHp = 14827.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 106.3,
			pre_meleeDef = 529.2,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 529.2,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1063.1,
			pre_meleeAtk = 1063.1,
			pre_maxHp = 14827.2,
			colorType = 4,
			monsterType = 0,
			id = 94000501,
			mobility = 1,
			pre_magicDef = 399.6,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 75,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 75,
			modelId = 120069,
			magicDef = 399.6,
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
		},
		[94000502] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 111.4,
			maxHp = 75217.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 111.4,
			pre_meleeDef = 652,
			sanity = 0,
			remark = "守卫精英（主动攻击触发2次锥刺并回血坚韧）",
			giftSkill = 1206702,
			weakPointHpRate = 0.3,
			meleeDef = 652,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1114.3,
			pre_meleeAtk = 1114.3,
			pre_maxHp = 75217.9,
			colorType = 2,
			monsterType = 1,
			id = 94000502,
			mobility = 2,
			pre_magicDef = 390,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 68,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 68,
			modelId = 120067,
			magicDef = 390,
			specialSkill = 1206703,
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
		[94000503] = {
			normalSkill = 1201501,
			name = "虫态补光灯",
			pre_magicAtk = 103.9,
			maxHp = 16751.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 103.9,
			pre_meleeDef = 550.8,
			sanity = 0,
			remark = "幻影小怪（普攻破甲+追击）",
			giftSkill = 1201502,
			weakPointHpRate = 0,
			meleeDef = 550.8,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1039.4,
			pre_meleeAtk = 1039.4,
			pre_maxHp = 16751.1,
			colorType = 1,
			monsterType = 0,
			id = 94000503,
			mobility = 4,
			pre_magicDef = 350.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 75,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 75,
			modelId = 120015,
			magicDef = 350.1,
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
		[94000504] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 1148.6,
			maxHp = 12554.6,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 1148.6,
			pre_meleeDef = 383.4,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 383.4,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 114.9,
			pre_meleeAtk = 114.9,
			pre_maxHp = 12554.6,
			colorType = 4,
			monsterType = 0,
			id = 94000504,
			mobility = 2,
			pre_magicDef = 550.8,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 65,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120031,
			magicDef = 550.8,
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
		}
	}
}

return configData
