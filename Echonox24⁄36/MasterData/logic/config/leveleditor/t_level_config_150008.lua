-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150008.lua

module("logic.config.leveleditor.t_level_config_150008", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150008",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "爬塔明面8",
	lossConditionDesc = "",
	sceneId = "108002",
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
			x = 5,
			y = 4
		},
		{
			direction = 1,
			x = 4,
			y = 3
		},
		{
			direction = 1,
			x = 3,
			y = 3
		},
		{
			direction = 1,
			x = 6,
			y = 3
		},
		{
			direction = 1,
			x = 7,
			y = 3
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
			groupName = "小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 15000802,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 15000802,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 15000802,
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
					monsterId = 15000802,
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
			groupName = "精英",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 15000801,
					x = 5,
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
			groupName = "狙击",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 15000803,
					x = 5,
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
		[15000801] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 28.6,
			maxHp = 8556,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 28.6,
			pre_meleeDef = 198,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 198,
			level = 25,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 286.2,
			pre_meleeAtk = 286.2,
			pre_maxHp = 8556,
			colorType = 2,
			monsterType = 1,
			id = 15000801,
			mobility = 2,
			pre_magicDef = 93,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 41.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 41.5,
			modelId = 120090,
			magicDef = 93,
			specialSkill = 0,
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
		[15000802] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 293.2,
			maxHp = 1463.5,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 293.2,
			pre_meleeDef = 93.6,
			sanity = 0,
			remark = "",
			giftSkill = 1201203,
			weakPointHpRate = 0,
			meleeDef = 93.6,
			level = 25,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 29.3,
			pre_meleeAtk = 29.3,
			pre_maxHp = 1463.5,
			colorType = 4,
			monsterType = 0,
			id = 15000802,
			mobility = 2,
			pre_magicDef = 165.6,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 38.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.5,
			modelId = 120012,
			magicDef = 165.6,
			specialSkill = 1201202,
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
		[15000803] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 28.1,
			maxHp = 1705,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 28.1,
			pre_meleeDef = 151.2,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 151.2,
			level = 25,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 280.7,
			pre_meleeAtk = 280.7,
			pre_maxHp = 1705,
			colorType = 3,
			monsterType = 0,
			id = 15000803,
			mobility = 2,
			pre_magicDef = 83.7,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 58.5,
			modelId = 120088,
			magicDef = 83.7,
			specialSkill = 1208802,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
