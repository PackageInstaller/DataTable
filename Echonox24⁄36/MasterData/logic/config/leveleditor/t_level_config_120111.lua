-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120111.lua

module("logic.config.leveleditor.t_level_config_120111", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120111",
	plotEventGroup = 120111,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "1-断章B-1",
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
			direction = 4,
			x = 6,
			y = 10
		},
		{
			direction = 4,
			x = 6,
			y = 11
		},
		{
			direction = 4,
			x = 6,
			y = 9
		},
		{
			direction = 2,
			x = 7,
			y = 10
		},
		{
			direction = 2,
			x = 7,
			y = 9
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
					round = 5,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 2,
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
			round = 3,
			hasSymbol = false,
			groupName = "初始狙击",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 12,
					tag = "",
					monsterId = 12011101,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 11,
					tag = "",
					monsterId = 12011104,
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
			refreshType = 1,
			form = 1,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "初始守卫",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 12011103,
					x = 2,
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
					monsterId = 12011103,
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
			form = 3,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "第3回合刷新",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 12011102,
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
					monsterId = 12011102,
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
			groupName = "第4回合",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 14,
					tag = "",
					monsterId = 12011101,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 14,
					tag = "",
					monsterId = 12011101,
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
			form = 1,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "第2回合",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 12011103,
					x = 6,
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
					monsterId = 12011103,
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
			round = 5,
			hasSymbol = false,
			groupName = "第5回合",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 12011101,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 12011101,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "初始特异",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 12011102,
					x = 13,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 12011102,
					x = 13,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[12011101] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 16.5,
			maxHp = 559.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 16.5,
			pre_meleeDef = 96.3,
			sanity = 0,
			remark = "",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 96.3,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 164.9,
			pre_meleeAtk = 164.9,
			pre_maxHp = 559.9,
			colorType = 3,
			monsterType = 0,
			id = 12011101,
			mobility = 2,
			pre_magicDef = 48.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 52,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 52,
			modelId = 120030,
			magicDef = 48.6,
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
		[12011102] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 175.7,
			maxHp = 470.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 175.7,
			pre_meleeDef = 48.6,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 48.6,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 17.6,
			pre_meleeAtk = 17.6,
			pre_maxHp = 470.5,
			colorType = 3,
			monsterType = 0,
			id = 12011102,
			mobility = 2,
			pre_magicDef = 96.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 52,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 52,
			modelId = 120029,
			magicDef = 96.3,
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
		[12011103] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 15.6,
			maxHp = 761.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 15.6,
			pre_meleeDef = 115.2,
			sanity = 0,
			remark = "",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 115.2,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 156.3,
			pre_meleeAtk = 156.3,
			pre_maxHp = 761.4,
			colorType = 2,
			monsterType = 0,
			id = 12011103,
			mobility = 2,
			pre_magicDef = 48.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 32,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 32,
			modelId = 120028,
			magicDef = 48.6,
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
		[12011104] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 17.7,
			maxHp = 2401.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 17.7,
			pre_meleeDef = 87,
			sanity = 0,
			remark = "",
			giftSkill = 1203002,
			weakPointHpRate = 0.3,
			meleeDef = 87,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 176.5,
			pre_meleeAtk = 176.5,
			pre_maxHp = 2401.6,
			colorType = 3,
			monsterType = 1,
			id = 12011104,
			mobility = 2,
			pre_magicDef = 43,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120030,
			magicDef = 43,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
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
