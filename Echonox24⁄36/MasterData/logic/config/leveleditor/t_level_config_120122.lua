-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120122.lua

module("logic.config.leveleditor.t_level_config_120122", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120122",
	plotEventGroup = 200132,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "1-断章C-2",
	lossConditionDesc = "",
	sceneId = "112001",
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
			x = 7,
			y = 7
		},
		{
			direction = 2,
			x = 7,
			y = 8
		},
		{
			direction = 2,
			x = 7,
			y = 9
		},
		{
			direction = 2,
			x = 7,
			y = 6
		},
		{
			direction = 2,
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
			targetId = 2000053,
			monsterIds = {}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 5,
			plotStr = "1001",
			round = 2,
			hasSymbol = false,
			groupName = "主战场",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 12012201,
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
					monsterId = 12012201,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 12012203,
					x = 10,
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
					monsterId = 12012203,
					x = 9,
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
					monsterId = 12012203,
					x = 10,
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
					monsterId = 12012204,
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
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "背后",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 12012201,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 12012201,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 4,
			form = 2,
			plotStr = "101",
			round = 1,
			hasSymbol = false,
			groupName = "友军",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 12012205,
					x = 2,
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
			round = 4,
			hasSymbol = false,
			groupName = "第4回合",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 12012201,
					x = 0,
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
					monsterId = 12012201,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[12012201] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 14.4,
			maxHp = 651.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 14.4,
			pre_meleeDef = 78.3,
			sanity = 0,
			remark = "",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 78.3,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 144.2,
			pre_meleeAtk = 144.2,
			pre_maxHp = 651.8,
			colorType = 3,
			monsterType = 0,
			id = 12012201,
			mobility = 2,
			pre_magicDef = 38.7,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 53,
			modelId = 120030,
			magicDef = 38.7,
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
		[12012202] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 14,
			maxHp = 738.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 14,
			pre_meleeDef = 87.3,
			sanity = 0,
			remark = "",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 87.3,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 139.5,
			pre_meleeAtk = 139.5,
			pre_maxHp = 738.7,
			colorType = 1,
			monsterType = 0,
			id = 12012202,
			mobility = 4,
			pre_magicDef = 37.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 43,
			modelId = 120089,
			magicDef = 37.8,
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
		[12012203] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 13.6,
			maxHp = 894.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 13.6,
			pre_meleeDef = 95.4,
			sanity = 0,
			remark = "",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 95.4,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 135.6,
			pre_meleeAtk = 135.6,
			pre_maxHp = 894.2,
			colorType = 2,
			monsterType = 0,
			id = 12012203,
			mobility = 2,
			pre_magicDef = 37.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 33,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 33,
			modelId = 120028,
			magicDef = 37.8,
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
		[12012204] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 17.8,
			maxHp = 2884.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 17.8,
			pre_meleeDef = 105,
			sanity = 0,
			remark = "",
			giftSkill = 1208903,
			weakPointHpRate = 0.3,
			meleeDef = 105,
			level = 18,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 178.3,
			pre_meleeAtk = 178.3,
			pre_maxHp = 2884.2,
			colorType = 1,
			monsterType = 1,
			id = 12012204,
			mobility = 4,
			pre_magicDef = 52,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 48,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 48,
			modelId = 120089,
			magicDef = 52,
			specialSkill = 1208902,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[12012205] = {
			normalSkill = 1102801,
			name = "创",
			pre_magicAtk = 30.9,
			maxHp = 2608.2,
			aiName = "mob_active_ai",
			battleCamp = 3,
			career = 1,
			magicAtk = 30.9,
			pre_meleeDef = 180.9,
			sanity = 0,
			remark = "",
			giftSkill = 1102804,
			weakPointHpRate = 0,
			meleeDef = 180.9,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 308.6,
			pre_meleeAtk = 308.6,
			pre_maxHp = 2608.2,
			colorType = 1,
			monsterType = 0,
			id = 12012205,
			mobility = 4,
			pre_magicDef = 102.6,
			aiStepOrder = 0,
			trumpSkill = 1102803,
			isFuzzy = false,
			inspire = 50,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 100028,
			magicDef = 102.6,
			specialSkill = 1102802,
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
