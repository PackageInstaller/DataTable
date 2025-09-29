-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110506.lua

module("logic.config.leveleditor.t_level_config_110506", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "",
	levelId = "110506",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通5-6",
	lossConditionDesc = "",
	sceneId = "113003",
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
			x = 7,
			y = 10
		},
		{
			direction = 3,
			x = 8,
			y = 10
		},
		{
			direction = 3,
			x = 9,
			y = 10
		},
		{
			direction = 3,
			x = 11,
			y = 7
		},
		{
			direction = 3,
			x = 12,
			y = 7
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
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 11050601,
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
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 11050602,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 11050602,
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
			groupName = "怪物组3",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 11050603,
					x = 11,
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
					monsterId = 11050603,
					x = 12,
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
			groupName = "怪物组4",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 11050604,
					x = 13,
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
					monsterId = 11050604,
					x = 8,
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
					monsterId = 11050604,
					x = 6,
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
		[11050601] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 920.9,
			maxHp = 20241.8,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 920.9,
			pre_meleeDef = 261,
			sanity = 0,
			remark = "支援精英（行动结束时援护；援护强化）",
			giftSkill = 1203105,
			weakPointHpRate = 0.3,
			meleeDef = 261,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 92.1,
			pre_meleeAtk = 92.1,
			pre_maxHp = 20241.8,
			colorType = 4,
			monsterType = 1,
			id = 11050601,
			mobility = 2,
			pre_magicDef = 387,
			aiStepOrder = 0,
			trumpSkill = 1203104,
			isFuzzy = false,
			inspire = 56,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120031,
			magicDef = 387,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[11050602] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 78.9,
			maxHp = 4413.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 78.9,
			pre_meleeDef = 321.3,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 321.3,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 788.8,
			pre_meleeAtk = 788.8,
			pre_maxHp = 4413.5,
			colorType = 3,
			monsterType = 0,
			id = 11050602,
			mobility = 2,
			pre_magicDef = 214.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 73,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 73,
			modelId = 120088,
			magicDef = 214.2,
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
		[11050603] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 881.2,
			maxHp = 3708.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 881.2,
			pre_meleeDef = 214.2,
			sanity = 0,
			remark = "红特异小怪（主动攻击触发超感）",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 214.2,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 88.1,
			pre_meleeAtk = 88.1,
			pre_maxHp = 3708.4,
			colorType = 1,
			monsterType = 0,
			id = 11050603,
			mobility = 2,
			pre_magicDef = 321.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 73,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 73,
			modelId = 120068,
			magicDef = 321.3,
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
		[11050604] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 74.9,
			maxHp = 5130.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 74.9,
			pre_meleeDef = 348.3,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 348.3,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 748.6,
			pre_meleeAtk = 748.6,
			pre_maxHp = 5130.3,
			colorType = 1,
			monsterType = 0,
			id = 11050604,
			mobility = 4,
			pre_magicDef = 212.4,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 63,
			modelId = 120089,
			magicDef = 212.4,
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
		[11050605] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 87.6,
			maxHp = 28153.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 87.6,
			pre_meleeDef = 357,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 357,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 876.1,
			pre_meleeAtk = 876.1,
			pre_maxHp = 28153.6,
			colorType = 3,
			monsterType = 1,
			id = 11050605,
			mobility = 2,
			pre_magicDef = 238,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 76,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 76,
			modelId = 120088,
			magicDef = 238,
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
		[11050606] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 78.7,
			maxHp = 32409.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 78.7,
			pre_meleeDef = 387,
			sanity = 0,
			remark = "幻影精英怪（主动攻击时追击；位移再动追击强化）",
			giftSkill = 1208905,
			weakPointHpRate = 0.3,
			meleeDef = 387,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 787.2,
			pre_meleeAtk = 787.2,
			pre_maxHp = 32409.3,
			colorType = 1,
			monsterType = 1,
			id = 11050606,
			mobility = 4,
			pre_magicDef = 236,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 66,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 66,
			modelId = 120089,
			magicDef = 236,
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
		}
	}
}

return configData
