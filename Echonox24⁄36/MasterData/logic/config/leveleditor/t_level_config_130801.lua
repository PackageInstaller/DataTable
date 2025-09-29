-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130801.lua

module("logic.config.leveleditor.t_level_config_130801", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130801",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "支援材料本-1",
	lossConditionDesc = "",
	sceneId = "109002",
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
			x = 3,
			y = 7
		},
		{
			direction = 2,
			x = 3,
			y = 3
		},
		{
			direction = 2,
			x = 1,
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
					DIYName = "10回合内击杀所有迷雾使徒",
					condition = 1,
					monsterIds = {}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 2,
			maxDeadCount = 0,
			count = 0,
			hasTag = false,
			DIYName = "暮雪死亡",
			isBackup = false,
			tag = "",
			targetId = 13080102,
			monsterIds = {}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "保护友方目标",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = true,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 13080102,
					x = 4,
					initialStatus = {
						hpPercent = 0.5,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 13080103,
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
					monsterId = 13080103,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 13080103,
					x = 15,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 13080103,
					x = 15,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 13080103,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 13080103,
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
			x = 12,
			y = 5
		},
		{
			x = 3,
			y = 7
		}
	},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 13080101,
			pos = {
				x = 3,
				y = 3
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[13080101] = {
			normalSkill = 1105301,
			name = "阿妮亚",
			pre_magicAtk = 153.6,
			maxHp = 448,
			aiName = "auto_support_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 175,
			pre_meleeDef = 34.8,
			sanity = 0,
			remark = "",
			giftSkill = 1105304,
			weakPointHpRate = 0,
			meleeDef = 36,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 31,
			pre_meleeAtk = 30.4,
			pre_maxHp = 422,
			colorType = 4,
			monsterType = 0,
			id = 13080101,
			mobility = 2,
			pre_magicDef = 59.6,
			aiStepOrder = 1,
			trumpSkill = 1105303,
			isFuzzy = false,
			inspire = 28,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 30.8,
			modelId = 100053,
			magicDef = 68,
			specialSkill = 1105302,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"B"
			},
			tags = {}
		},
		[13080102] = {
			normalSkill = 1228101,
			name = "暮雪",
			pre_magicAtk = 1000,
			maxHp = 1200,
			aiName = "ai-支援本-友方炮台",
			battleCamp = 3,
			career = 5,
			magicAtk = 9000,
			pre_meleeDef = 1000,
			sanity = 0,
			remark = "",
			giftSkill = 1228103,
			weakPointHpRate = 0,
			meleeDef = 9000,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 9000,
			pre_meleeAtk = 1000,
			pre_maxHp = 1200,
			colorType = 4,
			monsterType = 0,
			id = 13080102,
			mobility = 0,
			pre_magicDef = 1000,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 10,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 10,
			modelId = 100021,
			magicDef = 9000,
			specialSkill = 1228102,
			extraSkills = {},
			attributeGrade = {
				"C",
				"A",
				"A",
				"A",
				"A"
			},
			tags = {}
		},
		[13080103] = {
			normalSkill = 1228201,
			name = "迷雾使徒",
			pre_magicAtk = 50,
			maxHp = 1000,
			aiName = "ai-支援本-敌方炮台",
			battleCamp = 1,
			career = 5,
			magicAtk = 50,
			pre_meleeDef = 1000,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 9000,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 50,
			pre_meleeAtk = 50,
			pre_maxHp = 1000,
			colorType = 4,
			monsterType = 0,
			id = 13080103,
			mobility = 0,
			pre_magicDef = 1000,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 10,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 10,
			modelId = 120010,
			magicDef = 9000,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"A",
				"C",
				"A"
			},
			tags = {}
		}
	}
}

return configData
