-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150107.lua

module("logic.config.leveleditor.t_level_config_150107", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150107",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔暗面1-7",
	lossConditionDesc = "",
	sceneId = "116004",
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
			x = 7,
			y = 7
		},
		{
			direction = 2,
			x = 8,
			y = 6
		},
		{
			direction = 1,
			x = 6,
			y = 7
		},
		{
			direction = 3,
			x = 6,
			y = 5
		},
		{
			direction = 3,
			x = 7,
			y = 5
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
			groupName = "左边狙击",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15010701,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15010701,
					x = 8,
					initialStatus = {
						hpPercent = 1,
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
			groupName = "下面守卫",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 15010702,
					x = 6,
					initialStatus = {
						hpPercent = 1,
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
			groupName = "右侧幻影",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15010703,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 15010703,
					x = 10,
					initialStatus = {
						hpPercent = 1,
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
			groupName = "上面",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15010704,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	trialHeroes = {},
	monsters = {
		[15010701] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 105.7,
			maxHp = 6138.2,
			aiName = "ai_120030_毒沫",
			battleCamp = 1,
			career = 3,
			magicAtk = 105.7,
			pre_meleeDef = 443.4,
			sanity = 0,
			remark = "狙击精英-高难度",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 443.4,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1057.8,
			pre_meleeAtk = 1057.8,
			pre_maxHp = 6138.2,
			colorType = 3,
			monsterType = 0,
			id = 15010701,
			mobility = 2,
			pre_magicDef = 291.9,
			aiStepOrder = 0,
			trumpSkill = 1203004,
			isFuzzy = false,
			inspire = 77.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 77.7,
			modelId = 120030,
			magicDef = 291.9,
			specialSkill = 0,
			extraSkills = {
				1203003
			},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[15010702] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 93.4,
			maxHp = 53761.9,
			aiName = "ai_120028_秽卵",
			battleCamp = 1,
			career = 2,
			magicAtk = 93.4,
			pre_meleeDef = 566.3,
			sanity = 0,
			remark = "守卫精英-高难度",
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
			id = 15010702,
			mobility = 2,
			pre_magicDef = 322.3,
			aiStepOrder = 0,
			trumpSkill = 1202804,
			isFuzzy = false,
			inspire = 60.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60.7,
			modelId = 120028,
			magicDef = 322.3,
			specialSkill = 0,
			extraSkills = {
				1202803
			},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		},
		[15010703] = {
			normalSkill = 1201601,
			name = "巡逻道闸",
			pre_magicAtk = 100.6,
			maxHp = 7109.9,
			aiName = "ai_120016_巡逻道闸",
			battleCamp = 1,
			career = 1,
			magicAtk = 100.6,
			pre_meleeDef = 478.8,
			sanity = 0,
			remark = "幻影精英-高难度",
			giftSkill = 1201602,
			weakPointHpRate = 0,
			meleeDef = 478.8,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1005.2,
			pre_meleeAtk = 1005.2,
			pre_maxHp = 7109.9,
			colorType = 1,
			monsterType = 0,
			id = 15010703,
			mobility = 4,
			pre_magicDef = 289.2,
			aiStepOrder = 0,
			trumpSkill = 1201604,
			isFuzzy = false,
			inspire = 67.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 67.7,
			modelId = 120016,
			magicDef = 289.2,
			specialSkill = 0,
			extraSkills = {
				1201603
			},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[15010704] = {
			normalSkill = 1208101,
			name = "拟态/葵",
			pre_magicAtk = 103.2,
			maxHp = 6306.6,
			aiName = "ai_120081_尖刺",
			battleCamp = 1,
			career = 5,
			magicAtk = 103.2,
			pre_meleeDef = 459.6,
			sanity = 0,
			remark = "陨灭精英-高难度",
			giftSkill = 1208103,
			weakPointHpRate = 0,
			meleeDef = 459.6,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1031.5,
			pre_meleeAtk = 1031.5,
			pre_maxHp = 6306.6,
			colorType = 4,
			monsterType = 0,
			id = 15010704,
			mobility = 1,
			pre_magicDef = 329.1,
			aiStepOrder = 3,
			trumpSkill = 1208102,
			isFuzzy = false,
			inspire = 67.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 67.7,
			modelId = 120081,
			magicDef = 329.1,
			specialSkill = 1208104,
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
