-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_190602.lua

module("logic.config.leveleditor.t_level_config_190602", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "弧光体验难度1",
	levelId = "190602",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "弧光体验难度2",
	lossConditionDesc = "",
	sceneId = "111009",
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
			x = 4,
			y = 0
		},
		{
			direction = 1,
			x = 4,
			y = 1
		},
		{
			direction = 1,
			x = 5,
			y = 1
		},
		{
			direction = 1,
			x = 10,
			y = 0
		},
		{
			direction = 1,
			x = 11,
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
					DIYName = "10回合内击杀所有原体",
					condition = 13,
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
	globalSkillCodeList = {
		1721916
	},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "守卫怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 19060201,
					x = 4,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 19060201,
					x = 4,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 19060202,
					x = 2,
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
					monsterId = 19060201,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 14,
					tag = "",
					monsterId = 19060202,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 19060202,
					x = 7,
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
			form = 6,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "治疗",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 19060202,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 19060201,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 19060201,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 19060202,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 19060201,
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
		[19060201] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 44.1,
			maxHp = 2958.2,
			aiName = "ai_弧光体验本_攻击怪",
			battleCamp = 1,
			career = 2,
			magicAtk = 44.1,
			pre_meleeDef = 244.8,
			sanity = 0,
			remark = "守卫小怪（主动攻击触发2次锥刺）",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 121.5,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 440.9,
			pre_meleeAtk = 440.9,
			pre_maxHp = 2958.2,
			colorType = 2,
			monsterType = 0,
			id = 19060201,
			mobility = 2,
			pre_magicDef = 121.5,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45,
			modelId = 120067,
			magicDef = 244.8,
			specialSkill = 0,
			extraSkills = {
				1206703
			},
			attributeGrade = {
				"B",
				"B",
				"C",
				"C",
				"A"
			},
			tags = {}
		},
		[19060202] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 513.3,
			maxHp = 1807.9,
			aiName = "ai_弧光体验本_治疗怪",
			battleCamp = 1,
			career = 6,
			magicAtk = 513.3,
			pre_meleeDef = 135.9,
			sanity = 0,
			remark = "支援小怪(主动攻击后援护)",
			giftSkill = 1201204,
			weakPointHpRate = 0,
			meleeDef = 135.9,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 51.3,
			pre_meleeAtk = 51.3,
			pre_maxHp = 1807.9,
			colorType = 4,
			monsterType = 0,
			id = 19060202,
			mobility = 2,
			pre_magicDef = 226.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45,
			modelId = 120012,
			magicDef = 226.8,
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
		}
	}
}

return configData
