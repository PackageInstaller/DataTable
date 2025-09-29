-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130310.lua

module("logic.config.leveleditor.t_level_config_130310", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130310",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "幻影材料本-10",
	lossConditionDesc = "",
	sceneId = "115002",
	winConditionDesc = "10回合内刺杀所有的仪式负责人",
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
			y = 1
		},
		{
			direction = 1,
			x = 7,
			y = 2
		},
		{
			direction = 1,
			x = 8,
			y = 1
		},
		{
			direction = 1,
			x = 8,
			y = 3
		},
		{
			direction = 1,
			x = 6,
			y = 3
		}
	},
	additionalTerrainList = {
		{
			terrainId = 4001,
			times = 0,
			posList = {
				{
					x = 7,
					y = 13
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
					condition = 11,
					monsterIds = {
						13031001,
						13031004
					}
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
			symbolStr = "刺杀",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = true,
			groupName = "胜利条件的刺杀怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 12,
					tag = "",
					monsterId = 13031001,
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
			refreshType = 1,
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "守卫道路的怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 13,
					tag = "",
					monsterId = 13031002,
					x = 4,
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
					monsterId = 13031002,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 13,
					tag = "",
					monsterId = 13031002,
					x = 10,
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
					monsterId = 13031002,
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
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "第2个刺杀目标",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 13031004,
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组4",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13031003,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13031003,
					x = 3,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13031003,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13031003,
					x = 11,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 7,
			y = 12
		},
		{
			x = 6,
			y = 1
		}
	},
	lockHeroList = {},
	monsters = {
		[13031001] = {
			normalSkill = 1223101,
			name = "仪式负责人",
			pre_magicAtk = 202.9,
			maxHp = 65443.6,
			aiName = "ai-幻影本-刺杀目标2",
			battleCamp = 1,
			career = 3,
			magicAtk = 0,
			pre_meleeDef = 783,
			sanity = 0,
			remark = "",
			giftSkill = 1223102,
			weakPointHpRate = 0.3,
			meleeDef = 550,
			level = 90,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 2029.1,
			pre_maxHp = 80904.2,
			colorType = 3,
			monsterType = 1,
			id = 13031001,
			mobility = 2,
			pre_magicDef = 550,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 90,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 120030,
			magicDef = 783,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"C",
				"B"
			},
			tags = {}
		},
		[13031002] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 163.9,
			maxHp = 19162.5,
			aiName = "ai-幻影本-守卫小怪",
			battleCamp = 1,
			career = 2,
			magicAtk = 163.9,
			pre_meleeDef = 808.2,
			sanity = 0,
			remark = "守卫精英-高难度",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 808.2,
			level = 90,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1638.7,
			pre_meleeAtk = 1638.7,
			pre_maxHp = 19162.5,
			colorType = 2,
			monsterType = 0,
			id = 13031002,
			mobility = 2,
			pre_magicDef = 493.2,
			aiStepOrder = 0,
			trumpSkill = 1201405,
			isFuzzy = false,
			inspire = 67,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 67,
			modelId = 120014,
			magicDef = 493.2,
			specialSkill = 0,
			extraSkills = {
				1201404
			},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[13031003] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 163.9,
			maxHp = 19162.5,
			aiName = "ai-幻影本-守卫小怪2",
			battleCamp = 1,
			career = 2,
			magicAtk = 163.9,
			pre_meleeDef = 808.2,
			sanity = 0,
			remark = "守卫精英-高难度",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 808.2,
			level = 90,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1638.7,
			pre_meleeAtk = 1638.7,
			pre_maxHp = 19162.5,
			colorType = 2,
			monsterType = 0,
			id = 13031003,
			mobility = 2,
			pre_magicDef = 493.2,
			aiStepOrder = 0,
			trumpSkill = 1201405,
			isFuzzy = false,
			inspire = 67,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 67,
			modelId = 120014,
			magicDef = 493.2,
			specialSkill = 0,
			extraSkills = {
				1201404
			},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[13031004] = {
			normalSkill = 1223101,
			name = "仪式负责人",
			pre_magicAtk = 202.9,
			maxHp = 65443.6,
			aiName = "ai-幻影本-刺杀目标3",
			battleCamp = 1,
			career = 3,
			magicAtk = 0,
			pre_meleeDef = 783,
			sanity = 0,
			remark = "",
			giftSkill = 1223102,
			weakPointHpRate = 0.3,
			meleeDef = 550,
			level = 90,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 2029.1,
			pre_maxHp = 80904.2,
			colorType = 3,
			monsterType = 1,
			id = 13031004,
			mobility = 2,
			pre_magicDef = 550,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 90,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 120030,
			magicDef = 783,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"C",
				"B"
			},
			tags = {}
		}
	}
}

return configData
