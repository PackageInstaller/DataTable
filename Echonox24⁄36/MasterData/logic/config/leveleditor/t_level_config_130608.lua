-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130608.lua

module("logic.config.leveleditor.t_level_config_130608", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130608",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "特异材料本-8",
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
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 13060801,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 10,
					tag = "",
					monsterId = 13060802,
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
			groupName = "怪物-蓝色",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 13060803,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 13060803,
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
					monsterId = 13060804,
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
					monsterId = 13060804,
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
		}
	},
	lockHeroList = {},
	trialHeroes = {},
	monsters = {
		[13060801] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 1596,
			maxHp = 35471.7,
			aiName = "ai_120068_噩梦圆规",
			battleCamp = 1,
			career = 4,
			magicAtk = 1496,
			pre_meleeDef = 398,
			sanity = 0,
			remark = "红特异精英-高难度",
			giftSkill = 1206802,
			weakPointHpRate = 0.3,
			meleeDef = 559,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 159.6,
			pre_meleeAtk = 159.6,
			pre_maxHp = 40471.7,
			colorType = 1,
			monsterType = 1,
			id = 13060801,
			mobility = 2,
			pre_magicDef = 559,
			aiStepOrder = 0,
			trumpSkill = 1206804,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 83,
			modelId = 120068,
			magicDef = 398,
			specialSkill = 0,
			extraSkills = {
				1206803
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
		[13060802] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1445.7,
			maxHp = 5505.8,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 1345.7,
			pre_meleeDef = 358.2,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 503.1,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 144.6,
			pre_meleeAtk = 144.6,
			pre_maxHp = 6505.8,
			colorType = 1,
			monsterType = 0,
			id = 13060802,
			mobility = 2,
			pre_magicDef = 503.1,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 80,
			modelId = 120029,
			magicDef = 358.2,
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
		[13060803] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1445.7,
			maxHp = 5505.8,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 1345.7,
			pre_meleeDef = 358.2,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 503.1,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 144.6,
			pre_meleeAtk = 144.6,
			pre_maxHp = 6505.8,
			colorType = 2,
			monsterType = 0,
			id = 13060803,
			mobility = 2,
			pre_magicDef = 503.1,
			aiStepOrder = 20,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 80,
			modelId = 120029,
			magicDef = 358.2,
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
		[13060804] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1445.7,
			maxHp = 5505.8,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 1345.7,
			pre_meleeDef = 358.2,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 503.1,
			level = 70,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 144.6,
			pre_meleeAtk = 144.6,
			pre_maxHp = 6505.8,
			colorType = 3,
			monsterType = 0,
			id = 13060804,
			mobility = 2,
			pre_magicDef = 503.1,
			aiStepOrder = 30,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 80,
			modelId = 120029,
			magicDef = 358.2,
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
