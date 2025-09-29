-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110538.lua

module("logic.config.leveleditor.t_level_config_110538", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "",
	levelId = "110538",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "困难5-8",
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
			direction = 2,
			x = 6,
			y = 12
		},
		{
			direction = 2,
			x = 6,
			y = 11
		},
		{
			direction = 1,
			x = 8,
			y = 4
		},
		{
			direction = 1,
			x = 9,
			y = 4
		},
		{
			direction = 2,
			x = 5,
			y = 12
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
					condition = 3,
					monsterIds = {
						11053804
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 11053805,
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
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11053801,
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
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "怪物组3",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11053805,
					x = 8,
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
					monsterId = 11053803,
					x = 9,
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
					monsterId = 11053802,
					x = 10,
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
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 11053803,
					x = 10,
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
					monsterId = 11053804,
					x = 10,
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
			x = 8,
			y = 4
		},
		{
			x = 10,
			y = 9
		}
	},
	lockHeroList = {},
	monsters = {
		[11053801] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1293.7,
			maxHp = 32150.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 1293.7,
			pre_meleeDef = 324.3,
			sanity = 0,
			remark = "绿特异精英（主动攻击时触发强化超感；获得高昂）",
			giftSkill = 1202902,
			weakPointHpRate = 0.3,
			meleeDef = 324.3,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 129.4,
			pre_meleeAtk = 129.4,
			pre_maxHp = 32150.8,
			colorType = 3,
			monsterType = 1,
			id = 11053801,
			mobility = 2,
			pre_magicDef = 492.7,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 80.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 80.7,
			modelId = 120029,
			magicDef = 492.7,
			specialSkill = 1202904,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[11053802] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 96.2,
			maxHp = 8814.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 96.2,
			pre_meleeDef = 509.7,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 509.7,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 961.4,
			pre_meleeAtk = 961.4,
			pre_maxHp = 8814.1,
			colorType = 2,
			monsterType = 0,
			id = 11053802,
			mobility = 2,
			pre_magicDef = 290.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 57.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 57.7,
			modelId = 120028,
			magicDef = 290.1,
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
		[11053803] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 1126.1,
			maxHp = 5328.8,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 1126.1,
			pre_meleeDef = 315.9,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 315.9,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 112.6,
			pre_meleeAtk = 112.6,
			pre_maxHp = 5328.8,
			colorType = 4,
			monsterType = 0,
			id = 11053803,
			mobility = 2,
			pre_magicDef = 478.8,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 57.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 57.7,
			modelId = 120031,
			magicDef = 478.8,
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
		[11053804] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 117.2,
			maxHp = 38264,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 117.2,
			pre_meleeDef = 492.7,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 492.7,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1172,
			pre_meleeAtk = 1172,
			pre_maxHp = 38264,
			colorType = 3,
			monsterType = 1,
			id = 11053804,
			mobility = 2,
			pre_magicDef = 324.3,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 80.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 80.7,
			modelId = 120088,
			magicDef = 324.3,
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
		[11053805] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 93.4,
			maxHp = 53761.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 93.4,
			pre_meleeDef = 566.3,
			sanity = 0,
			remark = "守卫精英（受到攻击后触发振荡；振荡范围强化）",
			giftSkill = 1202802,
			weakPointHpRate = 0.3,
			meleeDef = 566.3,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 934.1,
			pre_meleeAtk = 934.1,
			pre_maxHp = 53761.9,
			colorType = 2,
			monsterType = 1,
			id = 11053805,
			mobility = 2,
			pre_magicDef = 322.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 60.7,
			modelId = 120028,
			magicDef = 322.3,
			specialSkill = 1202803,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
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
