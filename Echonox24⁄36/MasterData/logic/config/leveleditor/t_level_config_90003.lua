-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_90003.lua

module("logic.config.leveleditor.t_level_config_90003", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "90003",
	plotEventGroup = 10001,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 8,
	levelName = "战斗事件测试用",
	lossConditionDesc = "",
	sceneId = "10402",
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
			x = 1,
			y = 1
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1004,
			times = 0,
			posList = {
				{
					x = 8,
					y = 5
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
					condition = 6,
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
			refreshType = 4,
			form = 2,
			plotStr = "101",
			round = 1,
			hasSymbol = false,
			groupName = "刷新二人组",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "testmonst_1",
					monsterId = 9000301,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 9000302,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 4,
			form = 3,
			plotStr = "102",
			round = 1,
			hasSymbol = false,
			groupName = "被召唤的怪物",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 9000303,
					x = 4,
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
		[9000301] = {
			normalSkill = 1101601,
			name = "烟火",
			pre_magicAtk = 0,
			maxHp = 0,
			aiName = "",
			battleCamp = 1,
			career = 1,
			magicAtk = 0,
			pre_meleeDef = 0,
			sanity = 0,
			remark = "",
			giftSkill = 1101604,
			weakPointHpRate = 0,
			meleeDef = 0,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 0,
			pre_maxHp = 0,
			colorType = 1,
			monsterType = 0,
			id = 9000301,
			mobility = 3,
			pre_magicDef = 0,
			aiStepOrder = 0,
			trumpSkill = 1101603,
			isFuzzy = false,
			inspire = 0,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 100016,
			magicDef = 0,
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
		},
		[9000302] = {
			normalSkill = 1101201,
			name = "芬里尔",
			pre_magicAtk = 0,
			maxHp = 0,
			aiName = "",
			battleCamp = 1,
			career = 4,
			magicAtk = 0,
			pre_meleeDef = 0,
			sanity = 0,
			remark = "",
			giftSkill = 1101204,
			weakPointHpRate = 0,
			meleeDef = 0,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 0,
			pre_maxHp = 0,
			colorType = 2,
			monsterType = 0,
			id = 9000302,
			mobility = 2,
			pre_magicDef = 0,
			aiStepOrder = 0,
			trumpSkill = 1101203,
			isFuzzy = false,
			inspire = 0,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 100012,
			magicDef = 0,
			specialSkill = 1101202,
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
		[9000303] = {
			normalSkill = 1201101,
			name = "长螯幽灵",
			pre_magicAtk = 0,
			maxHp = 0,
			aiName = "boss_atzero_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 0,
			pre_meleeDef = 0,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 0,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 0,
			pre_maxHp = 0,
			colorType = 2,
			monsterType = 0,
			id = 9000303,
			mobility = 2,
			pre_magicDef = 0,
			aiStepOrder = 3,
			trumpSkill = 1201103,
			isFuzzy = false,
			inspire = 0,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 120011,
			magicDef = 0,
			specialSkill = 1201102,
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
