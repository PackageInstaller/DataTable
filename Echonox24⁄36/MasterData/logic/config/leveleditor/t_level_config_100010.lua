-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_100010.lua

module("logic.config.leveleditor.t_level_config_100010", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_01",
	remarks = "",
	levelId = "100010",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "实机录制3",
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
			direction = 1,
			x = 13,
			y = 1
		},
		{
			direction = 1,
			x = 14,
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
					y = 3,
					tag = "",
					monsterId = 10001001,
					x = 14,
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
					monsterId = 10001002,
					x = 12,
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
			direction = 1,
			heroType = 2,
			monsterId = 10001003,
			pos = {
				x = 13,
				y = 1
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 1,
			heroType = 2,
			monsterId = 10001004,
			pos = {
				x = 14,
				y = 0
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[10001001] = {
			normalSkill = 1105601,
			name = "提亚",
			pre_magicAtk = 159.7,
			maxHp = 851.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 159.7,
			pre_meleeDef = 56.7,
			sanity = 0,
			remark = "",
			giftSkill = 1105604,
			weakPointHpRate = 0,
			meleeDef = 56.7,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 73,
			pre_meleeAtk = 73,
			pre_maxHp = 851.4,
			colorType = 4,
			monsterType = 0,
			id = 10001001,
			mobility = 2,
			pre_magicDef = 57.7,
			aiStepOrder = 0,
			trumpSkill = 1105603,
			isFuzzy = false,
			inspire = 19.2,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 19.2,
			modelId = 100056,
			magicDef = 57.7,
			specialSkill = 1105602,
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
		[10001002] = {
			normalSkill = 1105701,
			name = "厄迪普斯",
			pre_magicAtk = 190.2,
			maxHp = 816.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 190.2,
			pre_meleeDef = 53.1,
			sanity = 0,
			remark = "",
			giftSkill = 1105704,
			weakPointHpRate = 0,
			meleeDef = 53.1,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 86,
			pre_meleeAtk = 86,
			pre_maxHp = 816.8,
			colorType = 3,
			monsterType = 0,
			id = 10001002,
			mobility = 2,
			pre_magicDef = 67.1,
			aiStepOrder = 0,
			trumpSkill = 1105703,
			isFuzzy = false,
			inspire = 34.9,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 34.9,
			modelId = 100057,
			magicDef = 67.1,
			specialSkill = 1105702,
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
		[10001003] = {
			normalSkill = 1101101,
			name = "一云",
			pre_magicAtk = 60.2,
			maxHp = 887.5,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 60.2,
			pre_meleeDef = 60.7,
			sanity = 0,
			remark = "",
			giftSkill = 1101104,
			weakPointHpRate = 0,
			meleeDef = 60.7,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 144.8,
			pre_meleeAtk = 144.8,
			pre_maxHp = 887.5,
			colorType = 1,
			monsterType = 0,
			id = 10001003,
			mobility = 4,
			pre_magicDef = 46.9,
			aiStepOrder = 0,
			trumpSkill = 1101103,
			isFuzzy = false,
			inspire = 19.2,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 19.2,
			modelId = 100011,
			magicDef = 46.9,
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
		[10001004] = {
			normalSkill = 1101301,
			name = "安妮薇",
			pre_magicAtk = 184.4,
			maxHp = 777.2,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 184.4,
			pre_meleeDef = 49.9,
			sanity = 0,
			remark = "",
			giftSkill = 1101304,
			weakPointHpRate = 0,
			meleeDef = 49.9,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 74.8,
			pre_meleeAtk = 74.8,
			pre_maxHp = 777.2,
			colorType = 1,
			monsterType = 0,
			id = 10001004,
			mobility = 2,
			pre_magicDef = 57.9,
			aiStepOrder = 0,
			trumpSkill = 1101303,
			isFuzzy = false,
			inspire = 25.3,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 25.3,
			modelId = 100013,
			magicDef = 57.9,
			specialSkill = 1101302,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		}
	}
}

return configData
