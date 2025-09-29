-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120101.lua

module("logic.config.leveleditor.t_level_config_120101", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120101",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "1-断章A-1",
	lossConditionDesc = "",
	sceneId = "111002",
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
			x = 6,
			y = 6
		},
		{
			direction = 3,
			x = 7,
			y = 6
		},
		{
			direction = 3,
			x = 7,
			y = 5
		},
		{
			direction = 4,
			x = 5,
			y = 7
		},
		{
			direction = 2,
			x = 8,
			y = 7
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1004,
			times = 0,
			posList = {
				{
					x = 5,
					y = 14
				},
				{
					x = 6,
					y = 14
				},
				{
					x = 7,
					y = 14
				},
				{
					x = 8,
					y = 14
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
					condition = 1,
					monsterIds = {}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 6,
			maxDeadCount = 0,
			count = 3,
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
			round = 2,
			hasSymbol = false,
			groupName = "幻影",
			color = 8,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 12010101,
					x = 10,
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
					monsterId = 12010101,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 12010101,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 12010101,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 12010101,
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
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "精英幻影",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 12010102,
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
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "第2组",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 12010101,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 12010101,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 12010101,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 2000021,
			direction = 3,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 6,
				y = 6
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 2000053,
			direction = 3,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 7,
				y = 6
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[12010101] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 11.2,
			maxHp = 263.1,
			aiName = "ai-断章1-a1",
			battleCamp = 1,
			career = 1,
			magicAtk = 11.2,
			pre_meleeDef = 57.6,
			sanity = 0,
			remark = "",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 57.6,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 112.2,
			pre_meleeAtk = 112.2,
			pre_maxHp = 263.1,
			colorType = 1,
			monsterType = 0,
			id = 12010101,
			mobility = 4,
			pre_magicDef = 28.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35.5,
			modelId = 120089,
			magicDef = 28.8,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		},
		[12010102] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 12.8,
			maxHp = 2358.6,
			aiName = "ai-断章1-a1",
			battleCamp = 1,
			career = 1,
			magicAtk = 12.8,
			pre_meleeDef = 72,
			sanity = 0,
			remark = "",
			giftSkill = 1208903,
			weakPointHpRate = 0.5,
			meleeDef = 72,
			level = 10,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 127.6,
			pre_meleeAtk = 127.6,
			pre_maxHp = 2358.6,
			colorType = 1,
			monsterType = 1,
			id = 12010102,
			mobility = 4,
			pre_magicDef = 36,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 43.5,
			modelId = 120089,
			magicDef = 36,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			}
		}
	}
}

return configData
