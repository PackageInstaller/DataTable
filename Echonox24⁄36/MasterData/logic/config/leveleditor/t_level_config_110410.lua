-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110410.lua

module("logic.config.leveleditor.t_level_config_110410", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "",
	levelId = "110410",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通4-10",
	lossConditionDesc = "",
	sceneId = "110001",
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
			y = 9
		},
		{
			direction = 1,
			x = 5,
			y = 9
		},
		{
			direction = 1,
			x = 3,
			y = 9
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
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 11041004,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 11041004,
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
			groupName = "怪物组2",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 14,
					tag = "",
					monsterId = 11041003,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 11041003,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 11,
					tag = "",
					monsterId = 11041003,
					x = 8,
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
					monsterId = 11041003,
					x = 11,
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
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 11,
					tag = "",
					monsterId = 11041002,
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
			form = 5,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组4",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 11041001,
					x = 4,
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
		[11041001] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 54.1,
			maxHp = 27439.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 54.1,
			pre_meleeDef = 336.8,
			sanity = 0,
			remark = "守卫精英（主动攻击触发2次锥刺并回血坚韧）",
			giftSkill = 1206702,
			weakPointHpRate = 0.3,
			meleeDef = 336.8,
			level = 49,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 541.3,
			pre_meleeAtk = 541.3,
			pre_maxHp = 27439.1,
			colorType = 2,
			monsterType = 1,
			id = 11041001,
			mobility = 2,
			pre_magicDef = 178.6,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 52.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 52.4,
			modelId = 120067,
			magicDef = 178.6,
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
		[11041002] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 55.7,
			maxHp = 4377.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 55.7,
			pre_meleeDef = 303.1,
			sanity = 0,
			remark = "守卫小怪（主动攻击触发2次锥刺）",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 303.1,
			level = 49,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 556.9,
			pre_meleeAtk = 556.9,
			pre_maxHp = 4377.1,
			colorType = 2,
			monsterType = 0,
			id = 11041002,
			mobility = 2,
			pre_magicDef = 160.7,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 49.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 49.4,
			modelId = 120067,
			magicDef = 160.7,
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
		[11041003] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 58.1,
			maxHp = 3553.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 58.1,
			pre_meleeDef = 281.7,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 281.7,
			level = 49,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 581.7,
			pre_meleeAtk = 581.7,
			pre_maxHp = 3553.6,
			colorType = 1,
			monsterType = 0,
			id = 11041003,
			mobility = 4,
			pre_magicDef = 159.8,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.4,
			modelId = 120089,
			magicDef = 159.8,
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
		[11041004] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 650.4,
			maxHp = 2663.4,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 650.4,
			pre_meleeDef = 179.1,
			sanity = 0,
			remark = "支援小怪(主动攻击后援护)",
			giftSkill = 1201203,
			weakPointHpRate = 0,
			meleeDef = 179.1,
			level = 49,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 65,
			pre_meleeAtk = 65,
			pre_maxHp = 2663.4,
			colorType = 4,
			monsterType = 0,
			id = 11041004,
			mobility = 2,
			pre_magicDef = 281.7,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 49.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 49.4,
			modelId = 120012,
			magicDef = 281.7,
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
		[11041005] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 61,
			maxHp = 22544.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 61,
			pre_meleeDef = 313,
			sanity = 0,
			remark = "幻影精英怪（主动攻击时追击；位移再动追击强化）",
			giftSkill = 1208905,
			weakPointHpRate = 0.3,
			meleeDef = 313,
			level = 49,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 610.4,
			pre_meleeAtk = 610.4,
			pre_maxHp = 22544.3,
			colorType = 1,
			monsterType = 1,
			id = 11041005,
			mobility = 4,
			pre_magicDef = 177.6,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 62.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 62.4,
			modelId = 120089,
			magicDef = 177.6,
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
