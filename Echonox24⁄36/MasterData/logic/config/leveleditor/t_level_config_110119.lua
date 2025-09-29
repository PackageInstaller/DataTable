-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110119.lua

module("logic.config.leveleditor.t_level_config_110119", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "1-3.1（1-5）   5级怪物",
	levelId = "110119",
	plotEventGroup = 110119,
	maxPerson = 3,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "主线普通1-3.1",
	lossConditionDesc = "",
	sceneId = "110002",
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
			x = 3,
			y = 12
		},
		{
			direction = 3,
			x = 2,
			y = 13
		},
		{
			direction = 3,
			x = 4,
			y = 13
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
	globalSkillCodeList = {
		0
	},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "前排幻影",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 11,
					tag = "",
					monsterId = 11011902,
					x = 0,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 10,
					tag = "",
					monsterId = 11011902,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 11011902,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 10,
					tag = "",
					monsterId = 11011902,
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
			groupName = "路灯",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 10,
					tag = "",
					monsterId = 11011903,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 11,
					tag = "",
					monsterId = 11011903,
					x = 6,
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
			heroId = 2000022,
			direction = 3,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 4,
				y = 13
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 2000025,
			direction = 3,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 3,
				y = 12
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[11011901] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 7.5,
			maxHp = 208.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 7.5,
			pre_meleeDef = 48.8,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 48.8,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 75.4,
			pre_meleeAtk = 75.4,
			pre_maxHp = 208.9,
			colorType = 2,
			monsterType = 0,
			id = 11011901,
			mobility = 2,
			pre_magicDef = 22.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 22,
			modelId = 120090,
			magicDef = 22.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[11011902] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 7.7,
			maxHp = 231,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 7.7,
			pre_meleeDef = 44.8,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 44.8,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 77.4,
			pre_meleeAtk = 77.4,
			pre_maxHp = 147,
			colorType = 1,
			monsterType = 0,
			id = 11011902,
			mobility = 4,
			pre_magicDef = 21,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 32,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 32,
			modelId = 120089,
			magicDef = 21,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[11011903] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 8,
			maxHp = 149.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 8,
			pre_meleeDef = 40,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 40,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 79.8,
			pre_meleeAtk = 79.8,
			pre_maxHp = 149.5,
			colorType = 3,
			monsterType = 0,
			id = 11011903,
			mobility = 2,
			pre_magicDef = 23.2,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 42,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 42,
			modelId = 120088,
			magicDef = 23.2,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[11011904] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 8.3,
			maxHp = 749.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 8.3,
			pre_meleeDef = 61,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 61,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 83.4,
			pre_meleeAtk = 83.4,
			pre_maxHp = 749.6,
			colorType = 2,
			monsterType = 1,
			id = 11011904,
			mobility = 2,
			pre_magicDef = 40,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 30,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 30,
			modelId = 120090,
			magicDef = 40,
			specialSkill = 1209003,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
