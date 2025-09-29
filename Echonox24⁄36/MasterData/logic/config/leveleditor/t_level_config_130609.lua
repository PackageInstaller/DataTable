-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130609.lua

module("logic.config.leveleditor.t_level_config_130609", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130609",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "特异材料本-9",
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
			x = 6,
			y = 11
		},
		{
			direction = 3,
			x = 6,
			y = 12
		},
		{
			direction = 3,
			x = 10,
			y = 12
		},
		{
			direction = 3,
			x = 10,
			y = 11
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
					monsterId = 13060902,
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
					monsterId = 13060902,
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
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 13060901,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 13060903,
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
			groupName = "怪物-绿色",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 13060904,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 13060904,
					x = 6,
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
			y = 12
		}
	},
	lockHeroList = {},
	trialHeroes = {},
	monsters = {
		[13060901] = {
			normalSkill = 1209301,
			name = "自裁气球",
			pre_magicAtk = 1837.3,
			maxHp = 50988.1,
			aiName = "ai_120093_自裁气球",
			battleCamp = 1,
			career = 4,
			magicAtk = 1837.3,
			pre_meleeDef = 463,
			sanity = 0,
			remark = "绿特异精英-高难度（禁疗）",
			giftSkill = 1209302,
			weakPointHpRate = 0.3,
			meleeDef = 656,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 183.7,
			pre_meleeAtk = 183.7,
			pre_maxHp = 54988.1,
			colorType = 3,
			monsterType = 1,
			id = 13060901,
			mobility = 2,
			pre_magicDef = 656,
			aiStepOrder = 2,
			trumpSkill = 1209304,
			isFuzzy = false,
			inspire = 67,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 120093,
			magicDef = 463,
			specialSkill = 0,
			extraSkills = {
				1209303
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
		[13060902] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1666.5,
			maxHp = 7899.4,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 1566.5,
			pre_meleeDef = 416.7,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 590.4,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 166.6,
			pre_meleeAtk = 166.6,
			pre_maxHp = 8899.4,
			colorType = 1,
			monsterType = 0,
			id = 13060902,
			mobility = 2,
			pre_magicDef = 590.4,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 67,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 87,
			modelId = 120029,
			magicDef = 416.7,
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
		[13060903] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1666.5,
			maxHp = 7899.4,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 1566.5,
			pre_meleeDef = 416.7,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 590.4,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 166.6,
			pre_meleeAtk = 166.6,
			pre_maxHp = 8899.4,
			colorType = 2,
			monsterType = 0,
			id = 13060903,
			mobility = 2,
			pre_magicDef = 590.4,
			aiStepOrder = 20,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 67,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 87,
			modelId = 120029,
			magicDef = 416.7,
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
		[13060904] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1666.5,
			maxHp = 7899.4,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 1566.5,
			pre_meleeDef = 416.7,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 590.4,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 166.6,
			pre_meleeAtk = 166.6,
			pre_maxHp = 8899.4,
			colorType = 3,
			monsterType = 0,
			id = 13060904,
			mobility = 2,
			pre_magicDef = 590.4,
			aiStepOrder = 30,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 67,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 87,
			modelId = 120029,
			magicDef = 416.7,
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
