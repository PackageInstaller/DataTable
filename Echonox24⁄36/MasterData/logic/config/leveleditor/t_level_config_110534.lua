-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110534.lua

module("logic.config.leveleditor.t_level_config_110534", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110534",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "困难5-4",
	lossConditionDesc = "",
	sceneId = "111002",
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
			x = 5,
			y = 10
		},
		{
			direction = 3,
			x = 4,
			y = 10
		},
		{
			direction = 3,
			x = 4,
			y = 9
		},
		{
			direction = 3,
			x = 9,
			y = 10
		},
		{
			direction = 3,
			x = 8,
			y = 10
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 5,
			posList = {
				{
					x = 6,
					y = 1
				},
				{
					x = 7,
					y = 1
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
			groupName = "拦路组",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 11053404,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 11053404,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 11053404,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 11053404,
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "追杀组",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 11053402,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 11053402,
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
			refreshType = 2,
			form = 1,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "中途追杀组",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 11053403,
					x = 9,
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
					monsterId = 11053403,
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
			refreshType = 2,
			form = 4,
			plotStr = "",
			round = 6,
			hasSymbol = false,
			groupName = "磨磨唧唧没有好果汁组",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 11053403,
					x = 9,
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
					monsterId = 11053403,
					x = 4,
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
					monsterId = 11053404,
					x = 7,
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
					monsterId = 11053404,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 6,
			y = 1
		}
	},
	lockHeroList = {},
	monsters = {
		[11053401] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 994.1,
			maxHp = 4601.9,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 994.1,
			pre_meleeDef = 272.7,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 272.7,
			level = 62,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 99.4,
			pre_meleeAtk = 99.4,
			pre_maxHp = 4601.9,
			colorType = 4,
			monsterType = 0,
			id = 11053401,
			mobility = 2,
			pre_magicDef = 418.5,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 56,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120031,
			magicDef = 418.5,
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
		},
		[11053402] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 1041,
			maxHp = 4459.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 1041,
			pre_meleeDef = 250.2,
			sanity = 0,
			remark = "蓝特异小怪",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 250.2,
			level = 62,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 104.1,
			pre_meleeAtk = 104.1,
			pre_maxHp = 4459.2,
			colorType = 2,
			monsterType = 0,
			id = 11053402,
			mobility = 2,
			pre_magicDef = 386.1,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 76,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 76,
			modelId = 120068,
			magicDef = 386.1,
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
		[11053403] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1041,
			maxHp = 4459.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 1041,
			pre_meleeDef = 250.2,
			sanity = 0,
			remark = "绿特异小怪（主动攻击时触发超感,超感范围+1）",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 250.2,
			level = 62,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 104.1,
			pre_meleeAtk = 104.1,
			pre_maxHp = 4459.2,
			colorType = 3,
			monsterType = 0,
			id = 11053403,
			mobility = 2,
			pre_magicDef = 386.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 76,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 76,
			modelId = 120029,
			magicDef = 386.1,
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
		[11053404] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 84.7,
			maxHp = 7596.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 84.7,
			pre_meleeDef = 447.3,
			sanity = 0,
			remark = "守卫小怪（受到攻击后锥刺）",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 447.3,
			level = 62,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 847.4,
			pre_meleeAtk = 847.4,
			pre_maxHp = 7596.1,
			colorType = 2,
			monsterType = 0,
			id = 11053404,
			mobility = 2,
			pre_magicDef = 249.3,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120014,
			magicDef = 249.3,
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
