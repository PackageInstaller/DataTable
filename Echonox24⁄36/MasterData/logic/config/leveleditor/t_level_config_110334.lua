-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110334.lua

module("logic.config.leveleditor.t_level_config_110334", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "困难3-4",
	levelId = "110334",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "困难3-4",
	lossConditionDesc = "",
	sceneId = "116002",
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
			x = 5,
			y = 2
		},
		{
			direction = 4,
			x = 5,
			y = 1
		},
		{
			direction = 4,
			x = 5,
			y = 0
		},
		{
			direction = 1,
			x = 6,
			y = 2
		},
		{
			direction = 1,
			x = 7,
			y = 2
		},
		{
			direction = 1,
			x = 8,
			y = 2
		},
		{
			direction = 2,
			x = 9,
			y = 2
		},
		{
			direction = 2,
			x = 9,
			y = 1
		},
		{
			direction = 2,
			x = 9,
			y = 0
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
			groupName = "狙击精英",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11033401,
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
			groupName = "特异小怪",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 11033402,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 0,
					tag = "",
					monsterId = 11033402,
					x = 3,
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
			groupName = "守卫小怪",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 11033403,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 11033403,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 11033403,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 1,
					tag = "",
					monsterId = 11033403,
					x = 3,
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
			groupName = "支援小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 11033404,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 2,
					tag = "",
					monsterId = 11033404,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "怪物组5",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11033404,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11033402,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11033402,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11033402,
					x = 8,
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
		[11033401] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 51.7,
			maxHp = 13106.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 51.7,
			pre_meleeDef = 235.4,
			sanity = 0,
			remark = "狙击精英（弧光额外弹射3次）",
			giftSkill = 1203002,
			weakPointHpRate = 0.3,
			meleeDef = 235.4,
			level = 41,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 517.4,
			pre_meleeAtk = 517.4,
			pre_maxHp = 13106.2,
			colorType = 3,
			monsterType = 1,
			id = 11033401,
			mobility = 2,
			pre_magicDef = 138.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 68.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 68.4,
			modelId = 120030,
			magicDef = 138.4,
			specialSkill = 1203003,
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
		[11033402] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 447.8,
			maxHp = 2987.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 447.8,
			pre_meleeDef = 124.6,
			sanity = 0,
			remark = "绿特异小怪",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 124.6,
			level = 41,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 44.8,
			pre_meleeAtk = 44.8,
			pre_maxHp = 2987.9,
			colorType = 3,
			monsterType = 0,
			id = 11033402,
			mobility = 2,
			pre_magicDef = 211.9,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65.4,
			modelId = 120068,
			magicDef = 211.9,
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
		[11033403] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 38.4,
			maxHp = 4990.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 38.4,
			pre_meleeDef = 251.6,
			sanity = 0,
			remark = "守卫小怪（反击后触发振荡）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 251.6,
			level = 41,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 384.3,
			pre_meleeAtk = 384.3,
			pre_maxHp = 4990.9,
			colorType = 2,
			monsterType = 0,
			id = 11033403,
			mobility = 2,
			pre_magicDef = 123.7,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.4,
			modelId = 120090,
			magicDef = 123.7,
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
		[11033404] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 432.4,
			maxHp = 3051.7,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 432.4,
			pre_meleeDef = 138.4,
			sanity = 0,
			remark = "支援小怪(主动攻击后援护)",
			giftSkill = 1201203,
			weakPointHpRate = 0,
			meleeDef = 138.4,
			level = 41,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 43.3,
			pre_meleeAtk = 43.3,
			pre_maxHp = 3051.7,
			colorType = 4,
			monsterType = 0,
			id = 11033404,
			mobility = 2,
			pre_magicDef = 233.1,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.4,
			modelId = 120012,
			magicDef = 233.1,
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
