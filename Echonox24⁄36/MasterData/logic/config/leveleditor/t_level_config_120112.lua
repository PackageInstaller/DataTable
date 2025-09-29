-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120112.lua

module("logic.config.leveleditor.t_level_config_120112", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120112",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "1-断章B-2",
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
			direction = 1,
			x = 7,
			y = 4
		},
		{
			direction = 1,
			x = 6,
			y = 4
		},
		{
			direction = 1,
			x = 8,
			y = 4
		},
		{
			direction = 1,
			x = 6,
			y = 5
		},
		{
			direction = 1,
			x = 8,
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
					condition = 3,
					monsterIds = {
						12011204
					}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 1,
			maxDeadCount = 0,
			count = 3,
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
			form = 6,
			plotStr = "1001",
			round = 3,
			hasSymbol = false,
			groupName = "精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 12011204,
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
			form = 5,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "狙2",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 6,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 12011205,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 12011205,
					x = 5,
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "盾1",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 12011203,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 12011203,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 12011203,
					x = 9,
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
			round = 3,
			hasSymbol = false,
			groupName = "特异3",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 12011202,
					x = 13,
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
					monsterId = 12011202,
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
			form = 5,
			plotStr = "",
			round = 4,
			hasSymbol = false,
			groupName = "狙4",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 12011205,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 12011205,
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
			refreshType = 2,
			form = 1,
			plotStr = "",
			round = 5,
			hasSymbol = false,
			groupName = "盾5",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 12011206,
					x = 5,
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
					monsterId = 12011206,
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
			form = 3,
			plotStr = "",
			round = 6,
			hasSymbol = false,
			groupName = "特异6",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 12011202,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 11,
					tag = "",
					monsterId = 12011202,
					x = 12,
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
		[12011201] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 16.9,
			maxHp = 507.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 16.9,
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
			meleeAtk = 169.3,
			pre_meleeAtk = 169.3,
			pre_maxHp = 507.8,
			colorType = 3,
			monsterType = 0,
			id = 12011201,
			mobility = 2,
			pre_magicDef = 38.7,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53,
			camp = 8,
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
		[12011202] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 185.9,
			maxHp = 426.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 185.9,
			pre_meleeDef = 38.7,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 38.7,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 18.6,
			pre_meleeAtk = 18.6,
			pre_maxHp = 426.7,
			colorType = 3,
			monsterType = 0,
			id = 12011202,
			mobility = 2,
			pre_magicDef = 78.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 53,
			modelId = 120029,
			magicDef = 78.3,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		},
		[12011203] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 15.6,
			maxHp = 696.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 15.6,
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
			meleeAtk = 156.1,
			pre_meleeAtk = 156.1,
			pre_maxHp = 696.6,
			colorType = 2,
			monsterType = 0,
			id = 12011203,
			mobility = 2,
			pre_magicDef = 37.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 33,
			camp = 8,
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
		[12011204] = {
			normalSkill = 1209702,
			name = "徘徊者",
			pre_magicAtk = 18.1,
			maxHp = 3009.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 18.1,
			pre_meleeDef = 92,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.5,
			meleeDef = 92,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 180.6,
			pre_meleeAtk = 180.6,
			pre_maxHp = 3009.9,
			colorType = 4,
			monsterType = 1,
			id = 12011204,
			mobility = 1,
			pre_magicDef = 52,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 46,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 46,
			modelId = 120097,
			magicDef = 52,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"B"
			},
			tags = {}
		},
		[12011205] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 185.9,
			maxHp = 426.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 185.9,
			pre_meleeDef = 38.7,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 38.7,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 18.6,
			pre_meleeAtk = 18.6,
			pre_maxHp = 426.7,
			colorType = 3,
			monsterType = 0,
			id = 12011205,
			mobility = 2,
			pre_magicDef = 78.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 53,
			modelId = 120029,
			magicDef = 78.3,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		},
		[12011206] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 15.6,
			maxHp = 696.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 15.6,
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
			meleeAtk = 156.1,
			pre_meleeAtk = 156.1,
			pre_maxHp = 696.6,
			colorType = 2,
			monsterType = 0,
			id = 12011206,
			mobility = 2,
			pre_magicDef = 37.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 33,
			camp = 8,
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
		}
	}
}

return configData
