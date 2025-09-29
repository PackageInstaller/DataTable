-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130602.lua

module("logic.config.leveleditor.t_level_config_130602", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130602",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "特异材料本-2",
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
			direction = 1,
			x = 9,
			y = 5
		},
		{
			direction = 3,
			x = 7,
			y = 9
		},
		{
			direction = 3,
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
					monsterId = 13060202,
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
					monsterId = 13060203,
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
					monsterId = 13060203,
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
					monsterId = 13060204,
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
					monsterId = 13060204,
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
		[13060201] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 145,
			maxHp = 2695.4,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 145,
			pre_meleeDef = 36,
			sanity = 0,
			remark = "",
			giftSkill = 1202903,
			weakPointHpRate = 0.3,
			meleeDef = 36,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 14.5,
			pre_meleeAtk = 14.5,
			pre_maxHp = 2695.4,
			colorType = 2,
			monsterType = 1,
			id = 13060201,
			mobility = 2,
			pre_magicDef = 64,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 53.5,
			modelId = 120029,
			magicDef = 64,
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
		[13060202] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 126.9,
			maxHp = 192.6,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 126.9,
			pre_meleeDef = 28.8,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 51.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 12.7,
			pre_meleeAtk = 12.7,
			pre_maxHp = 192.6,
			colorType = 1,
			monsterType = 0,
			id = 13060202,
			mobility = 2,
			pre_magicDef = 51.2,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 25,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.5,
			modelId = 120029,
			magicDef = 28.8,
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
		[13060203] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 126.9,
			maxHp = 192.6,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 126.9,
			pre_meleeDef = 28.8,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 51.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 12.7,
			pre_meleeAtk = 12.7,
			pre_maxHp = 192.6,
			colorType = 2,
			monsterType = 0,
			id = 13060203,
			mobility = 2,
			pre_magicDef = 51.2,
			aiStepOrder = 20,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 25,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.5,
			modelId = 120029,
			magicDef = 28.8,
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
		[13060204] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 126.9,
			maxHp = 192.6,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 126.9,
			pre_meleeDef = 28.8,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 51.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 12.7,
			pre_meleeAtk = 12.7,
			pre_maxHp = 192.6,
			colorType = 3,
			monsterType = 0,
			id = 13060204,
			mobility = 2,
			pre_magicDef = 51.2,
			aiStepOrder = 30,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 25,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.5,
			modelId = 120029,
			magicDef = 28.8,
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
