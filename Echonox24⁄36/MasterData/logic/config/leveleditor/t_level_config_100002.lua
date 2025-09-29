-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_100002.lua

module("logic.config.leveleditor.t_level_config_100002", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "100002",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "序章-2",
	lossConditionDesc = "",
	sceneId = "109001",
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
			y = 8
		},
		{
			direction = 2,
			x = 6,
			y = 6
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
			groupName = "狂欢路灯",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 10000201,
					x = 9,
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
					monsterId = 10000202,
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
			heroId = -1,
			direction = 2,
			heroType = 2,
			monsterId = 10000204,
			pos = {
				x = 6,
				y = 8
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 2,
			heroType = 2,
			monsterId = 10000205,
			pos = {
				x = 6,
				y = 6
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[10000201] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 50,
			maxHp = 210,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 50,
			pre_meleeDef = 51.8,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 51.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 99.9,
			pre_meleeAtk = 99.9,
			pre_maxHp = 330,
			colorType = 3,
			monsterType = 0,
			id = 10000201,
			mobility = 2,
			pre_magicDef = 28.9,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 120088,
			magicDef = 28.9,
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
		[10000202] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 50,
			maxHp = 270,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 50,
			pre_meleeDef = 51.8,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 51.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 99.9,
			pre_meleeAtk = 99.9,
			pre_maxHp = 270,
			colorType = 3,
			monsterType = 0,
			id = 10000202,
			mobility = 2,
			pre_magicDef = 28.9,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 120088,
			magicDef = 28.9,
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
		[10000203] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 47,
			maxHp = 180,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 47,
			pre_meleeDef = 62.9,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 62.9,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 94.1,
			pre_meleeAtk = 94.1,
			pre_maxHp = 180,
			colorType = 2,
			monsterType = 0,
			id = 10000203,
			mobility = 2,
			pre_magicDef = 28.9,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 30,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 30,
			modelId = 120090,
			magicDef = 28.9,
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
		[10000204] = {
			normalSkill = 1101101,
			name = "一云",
			pre_magicAtk = 41.5,
			maxHp = 800,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 41.5,
			pre_meleeDef = 84.1,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 84.1,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 152.3,
			pre_meleeAtk = 152.3,
			pre_maxHp = 800,
			colorType = 1,
			monsterType = 0,
			id = 10000204,
			mobility = 4,
			pre_magicDef = 34.8,
			aiStepOrder = 0,
			trumpSkill = 1101103,
			isFuzzy = false,
			inspire = 38.1,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.1,
			modelId = 100011,
			magicDef = 34.8,
			specialSkill = 1101102,
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
		[10000205] = {
			normalSkill = 1101601,
			name = "烟火",
			pre_magicAtk = 38,
			maxHp = 800,
			aiName = "auto_yanhuo_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 38,
			pre_meleeDef = 63.1,
			sanity = 0,
			remark = "",
			giftSkill = 1101604,
			weakPointHpRate = 0,
			meleeDef = 63.1,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 167.5,
			pre_meleeAtk = 167.5,
			pre_maxHp = 800,
			colorType = 1,
			monsterType = 0,
			id = 10000205,
			mobility = 4,
			pre_magicDef = 29.8,
			aiStepOrder = 0,
			trumpSkill = 1101603,
			isFuzzy = false,
			inspire = 38.8,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.8,
			modelId = 100016,
			magicDef = 29.8,
			specialSkill = 1101602,
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
