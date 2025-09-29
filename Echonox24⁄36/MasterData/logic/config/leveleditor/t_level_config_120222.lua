-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120222.lua

module("logic.config.leveleditor.t_level_config_120222", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120222",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "2-断章C-2",
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
			x = 6,
			y = 8
		},
		{
			direction = 1,
			x = 7,
			y = 9
		},
		{
			direction = 1,
			x = 5,
			y = 8
		},
		{
			direction = 1,
			x = 6,
			y = 9
		},
		{
			direction = 1,
			x = 4,
			y = 9
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1004,
			times = 0,
			posList = {
				{
					x = 14,
					y = 0
				},
				{
					x = 14,
					y = 1
				},
				{
					x = 13,
					y = 0
				},
				{
					x = 13,
					y = 1
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
					DIYName = "10回合内阻止[迷雾使徒精英]撤离",
					condition = 3,
					monsterIds = {
						12022205
					}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 7,
			maxDeadCount = 0,
			count = 0,
			hasTag = false,
			DIYName = "",
			isBackup = false,
			tag = "",
			targetId = 2000053,
			monsterIds = {
				12022205
			}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "1001",
			round = 2,
			hasSymbol = false,
			groupName = "逃跑精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 14,
					tag = "",
					monsterId = 12022205,
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
			refreshType = 1,
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "守卫",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 12022204,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 12022204,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 12022204,
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
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "支援",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 14,
					tag = "",
					monsterId = 12022203,
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
			form = 1,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "守卫2",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 12022204,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 12022204,
					x = 10,
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
					monsterId = 12022203,
					x = 11,
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
			round = 4,
			hasSymbol = false,
			groupName = "守卫3",
			color = 6,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 12022204,
					x = 11,
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
					monsterId = 12022204,
					x = 12,
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
			x = 14,
			y = 0
		}
	},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 1,
			heroType = 2,
			monsterId = 12022201,
			pos = {
				x = 7,
				y = 9
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[12022201] = {
			normalSkill = 1101201,
			name = "芬里尔",
			pre_magicAtk = 87,
			maxHp = 871,
			aiName = "",
			battleCamp = 2,
			career = 4,
			magicAtk = 314,
			pre_meleeDef = 120,
			sanity = 0,
			remark = "",
			giftSkill = 1101204,
			weakPointHpRate = 0,
			meleeDef = 77,
			level = 20,
			monsterGroup = "角色模板",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 92,
			pre_meleeAtk = 308,
			pre_maxHp = 871,
			colorType = 2,
			monsterType = 0,
			id = 12022201,
			mobility = 2,
			pre_magicDef = 76,
			aiStepOrder = 0,
			trumpSkill = 1101203,
			isFuzzy = false,
			inspire = 58,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 5,
			pre_inspire = 56,
			modelId = 100012,
			magicDef = 138,
			specialSkill = 1101202,
			extraSkills = {},
			attributeGrade = {
				"S",
				"B",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[12022202] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 20.4,
			maxHp = 1082.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 20.4,
			pre_meleeDef = 108,
			sanity = 0,
			remark = "",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 108,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 203.7,
			pre_meleeAtk = 203.7,
			pre_maxHp = 1082.9,
			colorType = 3,
			monsterType = 0,
			id = 12022202,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120030,
			magicDef = 68.4,
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
		[12022203] = {
			normalSkill = 1200901,
			name = "迷雾使徒",
			pre_magicAtk = 213.1,
			maxHp = 936.1,
			aiName = "ai_治疗",
			battleCamp = 1,
			career = 6,
			magicAtk = 213.1,
			pre_meleeDef = 76.5,
			sanity = 0,
			remark = "",
			giftSkill = 1200903,
			weakPointHpRate = 0,
			meleeDef = 76.5,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 21.3,
			pre_meleeAtk = 21.3,
			pre_maxHp = 936.1,
			colorType = 4,
			monsterType = 0,
			id = 12022203,
			mobility = 2,
			pre_magicDef = 117.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36,
			modelId = 120009,
			magicDef = 117.9,
			specialSkill = 1200902,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		},
		[12022204] = {
			normalSkill = 1200701,
			name = "迷雾使徒",
			pre_magicAtk = 19,
			maxHp = 1538.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 19,
			pre_meleeDef = 126.9,
			sanity = 0,
			remark = "",
			giftSkill = 1200702,
			weakPointHpRate = 0,
			meleeDef = 126.9,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 190.4,
			pre_meleeAtk = 190.4,
			pre_maxHp = 1538.6,
			colorType = 2,
			monsterType = 0,
			id = 12022204,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36,
			modelId = 120007,
			magicDef = 68.4,
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
		[12022205] = {
			normalSkill = 1200601,
			name = "迷雾使徒",
			pre_magicAtk = 23.1,
			maxHp = 4559.7,
			aiName = "ai-断章2-c2",
			battleCamp = 1,
			career = 1,
			magicAtk = 23.1,
			pre_meleeDef = 131,
			sanity = 0,
			remark = "",
			giftSkill = 1200602,
			weakPointHpRate = 0.3,
			meleeDef = 131,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 231.1,
			pre_meleeAtk = 231.1,
			pre_maxHp = 4559.7,
			colorType = 1,
			monsterType = 1,
			id = 12022205,
			mobility = 4,
			pre_magicDef = 76,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 49,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 49,
			modelId = 120006,
			magicDef = 76,
			specialSkill = 1200603,
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
