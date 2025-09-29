-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130607.lua

module("logic.config.leveleditor.t_level_config_130607", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130607",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "特异材料本-7",
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
			direction = 3,
			x = 9,
			y = 11
		},
		{
			direction = 3,
			x = 10,
			y = 11
		},
		{
			direction = 3,
			x = 10,
			y = 12
		},
		{
			direction = 3,
			x = 6,
			y = 11
		},
		{
			direction = 3,
			x = 6,
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
					direction = 2,
					y = 10,
					tag = "",
					monsterId = 13060702,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 13060702,
					x = 10,
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
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 13060703,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 13060703,
					x = 6,
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
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 13060701,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 13060704,
					x = 9,
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
		}
	},
	lockHeroList = {},
	trialHeroes = {},
	monsters = {
		[13060701] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1293.7,
			maxHp = 26150.8,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 1193.7,
			pre_meleeDef = 324.3,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0.3,
			meleeDef = 492.7,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 129.4,
			pre_meleeAtk = 129.4,
			pre_maxHp = 32150.8,
			colorType = 3,
			monsterType = 1,
			id = 13060701,
			mobility = 2,
			pre_magicDef = 492.7,
			aiStepOrder = 99,
			trumpSkill = 1202905,
			isFuzzy = false,
			inspire = 57,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 80.7,
			modelId = 120029,
			magicDef = 324.3,
			specialSkill = 0,
			extraSkills = {
				1202904
			},
			attributeGrade = {
				"C",
				"C",
				"S",
				"S",
				"C"
			},
			tags = {}
		},
		[13060702] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1178.7,
			maxHp = 4157.5,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 1078.7,
			pre_meleeDef = 291.9,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 443.4,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 117.9,
			pre_meleeAtk = 117.9,
			pre_maxHp = 5157.5,
			colorType = 1,
			monsterType = 0,
			id = 13060702,
			mobility = 2,
			pre_magicDef = 443.4,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 57,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 77.7,
			modelId = 120029,
			magicDef = 291.9,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"A",
				"S",
				"C"
			},
			tags = {}
		},
		[13060703] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1178.7,
			maxHp = 4157.5,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 1078.7,
			pre_meleeDef = 291.9,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 443.4,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 117.9,
			pre_meleeAtk = 117.9,
			pre_maxHp = 5157.5,
			colorType = 2,
			monsterType = 0,
			id = 13060703,
			mobility = 2,
			pre_magicDef = 443.4,
			aiStepOrder = 20,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 57,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 77.7,
			modelId = 120029,
			magicDef = 291.9,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"A",
				"S",
				"C"
			},
			tags = {}
		},
		[13060704] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1178.7,
			maxHp = 4157.5,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 1078.7,
			pre_meleeDef = 291.9,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 443.4,
			level = 65,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 117.9,
			pre_meleeAtk = 117.9,
			pre_maxHp = 5157.5,
			colorType = 3,
			monsterType = 0,
			id = 13060704,
			mobility = 2,
			pre_magicDef = 443.4,
			aiStepOrder = 30,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 57,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 77.7,
			modelId = 120029,
			magicDef = 291.9,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"A",
				"S",
				"C"
			},
			tags = {}
		}
	}
}

return configData
