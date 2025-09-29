-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110112.lua

module("logic.config.leveleditor.t_level_config_110112", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal03_block",
	remarks = "",
	levelId = "110112",
	plotEventGroup = 110112,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通1-12",
	lossConditionDesc = "",
	sceneId = "115002",
	winConditionDesc = "存活3回合",
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
			x = 0,
			y = 4
		},
		{
			direction = 2,
			x = 0,
			y = 2
		},
		{
			direction = 2,
			x = 2,
			y = 3
		},
		{
			direction = 2,
			x = 1,
			y = 3
		},
		{
			direction = 2,
			x = 2,
			y = 2
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
					round = 3,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 2,
					monsterIds = {}
				}
			}
		},
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
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "初始怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 11011201,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 11011202,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 11011201,
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
			refreshType = 2,
			form = 3,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "第二回合精英",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 11011204,
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
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "第二回合刷新通常怪",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11011202,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 11011201,
					x = 5,
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
					monsterId = 11011201,
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
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "第三回合压迫怪物",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 11011203,
					x = 8,
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
					monsterId = 11011203,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11011203,
					x = 2,
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
					monsterId = 11011203,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 11011203,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 11011203,
					x = 9,
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
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 0,
				y = 4
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[11011201] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 8.5,
			maxHp = 217.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 8.5,
			pre_meleeDef = 55.2,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 55.2,
			level = 8,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 84.8,
			pre_meleeAtk = 84.8,
			pre_maxHp = 217.3,
			colorType = 2,
			monsterType = 0,
			id = 11011201,
			mobility = 2,
			pre_magicDef = 25.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 24,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 24,
			modelId = 120090,
			magicDef = 25.6,
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
		[11011202] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 9,
			maxHp = 155,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 9,
			pre_meleeDef = 45.6,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 45.6,
			level = 8,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 89.7,
			pre_meleeAtk = 89.7,
			pre_maxHp = 155,
			colorType = 3,
			monsterType = 0,
			id = 11011202,
			mobility = 2,
			pre_magicDef = 25.6,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 44,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 44,
			modelId = 120088,
			magicDef = 25.6,
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
		[11011203] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 8.7,
			maxHp = 178.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 8.7,
			pre_meleeDef = 50.4,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 50.4,
			level = 8,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 87.1,
			pre_meleeAtk = 87.1,
			pre_maxHp = 178.2,
			colorType = 1,
			monsterType = 0,
			id = 11011203,
			mobility = 4,
			pre_magicDef = 25.6,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 34,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 34,
			modelId = 120089,
			magicDef = 25.6,
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
		[11011204] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 9.4,
			maxHp = 777.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 9.4,
			pre_meleeDef = 69,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 69,
			level = 8,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 93.8,
			pre_meleeAtk = 93.8,
			pre_maxHp = 777.9,
			colorType = 2,
			monsterType = 1,
			id = 11011204,
			mobility = 2,
			pre_magicDef = 32,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 32,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 32,
			modelId = 120090,
			magicDef = 32,
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
		},
		[11011205] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 11.2,
			maxHp = 560,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 11.2,
			pre_meleeDef = 57,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 57,
			level = 8,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 112,
			pre_meleeAtk = 112,
			pre_maxHp = 560,
			colorType = 3,
			monsterType = 1,
			id = 11011205,
			mobility = 2,
			pre_magicDef = 32,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 52,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 52,
			modelId = 120088,
			magicDef = 32,
			specialSkill = 1208802,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[11011206] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 10.3,
			maxHp = 660.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 10.3,
			pre_meleeDef = 63,
			sanity = 0,
			remark = "",
			giftSkill = 1208903,
			weakPointHpRate = 0.3,
			meleeDef = 63,
			level = 8,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 103.1,
			pre_meleeAtk = 103.1,
			pre_maxHp = 660.2,
			colorType = 1,
			monsterType = 1,
			id = 11011206,
			mobility = 4,
			pre_magicDef = 32,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 42,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 42,
			modelId = 120089,
			magicDef = 32,
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
		}
	}
}

return configData
