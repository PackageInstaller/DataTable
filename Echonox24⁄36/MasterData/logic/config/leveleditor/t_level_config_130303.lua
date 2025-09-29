-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130303.lua

module("logic.config.leveleditor.t_level_config_130303", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130303",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "幻影材料本-3",
	lossConditionDesc = "仪式负责人通过[撤离点]逃脱",
	sceneId = "115001",
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
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1004,
			times = 0,
			posList = {
				{
					x = 6,
					y = 13
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
				},
				{
					x = 7,
					y = 13
				},
				{
					x = 8,
					y = 13
				}
			}
		},
		{
			terrainId = 4001,
			times = 0,
			posList = {
				{
					x = 7,
					y = 9
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
					DIYName = "10回合内刺杀仪式负责人",
					condition = 3,
					monsterIds = {
						13030301
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
			DIYName = "实验负责人通过[撤离点]逃脱",
			isBackup = false,
			tag = "",
			targetId = 0,
			monsterIds = {
				13030301
			}
		},
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
			hasSymbol = false,
			groupName = "胜利条件的刺杀怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 13030301,
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
					isInitialStatus = true,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030302,
					x = 3,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = true,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030302,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = true,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 13030302,
					x = 3,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = true,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030302,
					x = 11,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = true,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030302,
					x = 12,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = true,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 13030302,
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
			y = 8
		},
		{
			x = 6,
			y = 1
		}
	},
	lockHeroList = {},
	monsters = {
		[13030301] = {
			normalSkill = 1223101,
			name = "仪式负责人",
			pre_magicAtk = 25.3,
			maxHp = 1812.8,
			aiName = "ai-幻影本-刺杀目标1",
			battleCamp = 1,
			career = 3,
			magicAtk = 0,
			pre_meleeDef = 120,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 83.7,
			level = 20,
			monsterGroup = "",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 253.4,
			pre_maxHp = 7871,
			colorType = 3,
			monsterType = 1,
			id = 13030301,
			mobility = 2,
			pre_magicDef = 76,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58.5,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 0,
			pre_inspire = 59,
			modelId = 120047,
			magicDef = 151.2,
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
		[13030302] = {
			normalSkill = 1204601,
			name = "水滴执行者",
			pre_magicAtk = 22.2,
			maxHp = 1205.1,
			aiName = "ai-幻影本-守卫小怪",
			battleCamp = 1,
			career = 2,
			magicAtk = 22.2,
			pre_meleeDef = 126.9,
			sanity = -1,
			remark = "",
			giftSkill = 1223201,
			weakPointHpRate = 0,
			meleeDef = 126.9,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 221.9,
			pre_meleeAtk = 221.9,
			pre_maxHp = 1205.1,
			colorType = 2,
			monsterType = 0,
			id = 13030302,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36,
			modelId = 120046,
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
		}
	}
}

return configData
