-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110509.lua

module("logic.config.leveleditor.t_level_config_110509", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "",
	levelId = "110509",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通5-9",
	lossConditionDesc = "",
	sceneId = "113004",
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
			x = 4,
			y = 2
		},
		{
			direction = 1,
			x = 5,
			y = 2
		},
		{
			direction = 1,
			x = 8,
			y = 2
		},
		{
			direction = 1,
			x = 9,
			y = 2
		},
		{
			direction = 1,
			x = 10,
			y = 2
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
			form = 4,
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
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 11050901,
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
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 11050902,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11050902,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11050902,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11050902,
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
			groupName = "怪物组3",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11050903,
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
			groupName = "怪物组4",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11050904,
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
					monsterId = 11050904,
					x = 7,
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
		[11050901] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 1011.4,
			maxHp = 25505,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 1011.4,
			pre_meleeDef = 251.2,
			sanity = 0,
			remark = "绿特异精英（主动攻击触发超感；超感强化）",
			giftSkill = 1206802,
			weakPointHpRate = 0.3,
			meleeDef = 251.2,
			level = 58,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 101.2,
			pre_meleeAtk = 101.2,
			pre_maxHp = 25505,
			colorType = 3,
			monsterType = 1,
			id = 11050901,
			mobility = 2,
			pre_magicDef = 373.8,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 77.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 77.2,
			modelId = 120068,
			magicDef = 373.8,
			specialSkill = 1206803,
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
		[11050902] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 919.8,
			maxHp = 4019,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 919.8,
			pre_meleeDef = 226.1,
			sanity = 0,
			remark = "蓝特异小怪",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 226.1,
			level = 58,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 92,
			pre_meleeAtk = 92,
			pre_maxHp = 4019,
			colorType = 2,
			monsterType = 0,
			id = 11050902,
			mobility = 2,
			pre_magicDef = 336.4,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 74.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 74.2,
			modelId = 120068,
			magicDef = 336.4,
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
		[11050903] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 878,
			maxHp = 4167.3,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 878,
			pre_meleeDef = 247.3,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 247.3,
			level = 58,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 87.8,
			pre_meleeAtk = 87.8,
			pre_maxHp = 4167.3,
			colorType = 4,
			monsterType = 0,
			id = 11050903,
			mobility = 2,
			pre_magicDef = 364.5,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 54.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 54.2,
			modelId = 120031,
			magicDef = 364.5,
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
		[11050904] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 82.4,
			maxHp = 4783.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 82.4,
			pre_meleeDef = 336.4,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 336.4,
			level = 58,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 823.5,
			pre_meleeAtk = 823.5,
			pre_maxHp = 4783.1,
			colorType = 3,
			monsterType = 0,
			id = 11050904,
			mobility = 2,
			pre_magicDef = 226.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 74.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 74.2,
			modelId = 120088,
			magicDef = 226.1,
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
		[11050905] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 91.4,
			maxHp = 30354.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 91.4,
			pre_meleeDef = 373.8,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 373.8,
			level = 58,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 914.5,
			pre_meleeAtk = 914.5,
			pre_maxHp = 30354.6,
			colorType = 3,
			monsterType = 1,
			id = 11050905,
			mobility = 2,
			pre_magicDef = 251.2,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 77.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 77.2,
			modelId = 120088,
			magicDef = 251.2,
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
		}
	}
}

return configData
