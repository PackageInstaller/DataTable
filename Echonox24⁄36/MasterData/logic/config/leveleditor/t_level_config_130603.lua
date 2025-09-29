-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130603.lua

module("logic.config.leveleditor.t_level_config_130603", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130603",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "特异材料本-3",
	lossConditionDesc = "",
	sceneId = "116003",
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
			x = 9,
			y = 5
		},
		{
			direction = 4,
			x = 7,
			y = 9
		},
		{
			direction = 2,
			x = 9,
			y = 10
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
					DIYName = "10回合内击杀所有来袭密室原体",
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
			groupName = "怪物-红色",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 11,
					tag = "",
					monsterId = 13060302,
					x = 12,
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
			groupName = "怪物-蓝色",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 10,
					tag = "",
					monsterId = 13060303,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 13060303,
					x = 4,
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
			groupName = "怪物-绿色",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 13060304,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 13060304,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 8,
			y = 7
		},
		{
			x = 9,
			y = 5
		}
	},
	lockHeroList = {},
	trialHeroes = {},
	monsters = {
		[13060301] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 276.7,
			maxHp = 6613.5,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 276.7,
			pre_meleeDef = 76,
			sanity = 0,
			remark = "",
			giftSkill = 1202903,
			weakPointHpRate = 0.3,
			meleeDef = 76,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 27.7,
			pre_meleeAtk = 27.7,
			pre_maxHp = 6613.5,
			colorType = 2,
			monsterType = 1,
			id = 13060301,
			mobility = 2,
			pre_magicDef = 120,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 59,
			modelId = 120029,
			magicDef = 120,
			specialSkill = 0,
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
		[13060302] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 267.9,
			maxHp = 620,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 267.9,
			pre_meleeDef = 68.4,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 108,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 26.8,
			pre_meleeAtk = 26.8,
			pre_maxHp = 712.6,
			colorType = 1,
			monsterType = 0,
			id = 13060302,
			mobility = 2,
			pre_magicDef = 108,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120029,
			magicDef = 68.4,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"A",
				"S",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[13060303] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 267.9,
			maxHp = 620,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 267.9,
			pre_meleeDef = 68.4,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 108,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 26.8,
			pre_meleeAtk = 26.8,
			pre_maxHp = 712.6,
			colorType = 2,
			monsterType = 0,
			id = 13060303,
			mobility = 2,
			pre_magicDef = 108,
			aiStepOrder = 20,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120029,
			magicDef = 68.4,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"A",
				"S",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[13060304] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 267.9,
			maxHp = 620,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 267.9,
			pre_meleeDef = 68.4,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 108,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 26.8,
			pre_meleeAtk = 26.8,
			pre_maxHp = 712.6,
			colorType = 3,
			monsterType = 0,
			id = 13060304,
			mobility = 2,
			pre_magicDef = 108,
			aiStepOrder = 30,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120029,
			magicDef = 68.4,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"A",
				"S",
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
