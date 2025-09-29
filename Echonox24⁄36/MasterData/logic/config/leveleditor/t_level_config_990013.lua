-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_990013.lua

module("logic.config.leveleditor.t_level_config_990013", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "所有已有地形特效的展示关卡",
	levelId = "990013",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 99,
	levelName = "测试-附加地形特效展示",
	lossConditionDesc = "",
	sceneId = "920001",
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
			x = 0,
			y = 13
		},
		{
			direction = 2,
			x = 0,
			y = 11
		},
		{
			direction = 2,
			x = 0,
			y = 7
		},
		{
			direction = 2,
			x = 0,
			y = 9
		},
		{
			direction = 2,
			x = 0,
			y = 5
		},
		{
			direction = 2,
			x = 0,
			y = 0
		},
		{
			direction = 2,
			x = 0,
			y = 3
		},
		{
			direction = 2,
			x = 14,
			y = 7
		},
		{
			direction = 2,
			x = 9,
			y = 14
		},
		{
			direction = 2,
			x = 9,
			y = 12
		},
		{
			direction = 2,
			x = 9,
			y = 10
		},
		{
			direction = 2,
			x = 9,
			y = 8
		},
		{
			direction = 2,
			x = 9,
			y = 6
		},
		{
			direction = 2,
			x = 9,
			y = 4
		}
	},
	additionalTerrainList = {
		{
			terrainId = 9001,
			times = 0,
			posList = {
				{
					x = 4,
					y = 10
				},
				{
					x = 4,
					y = 9
				},
				{
					x = 5,
					y = 10
				},
				{
					x = 5,
					y = 9
				}
			}
		},
		{
			terrainId = 9002,
			times = 0,
			posList = {
				{
					x = 4,
					y = 7
				},
				{
					x = 4,
					y = 6
				},
				{
					x = 5,
					y = 7
				},
				{
					x = 5,
					y = 6
				}
			}
		},
		{
			terrainId = 9003,
			times = 0,
			posList = {
				{
					x = 4,
					y = 4
				},
				{
					x = 4,
					y = 3
				},
				{
					x = 5,
					y = 4
				},
				{
					x = 5,
					y = 3
				}
			}
		},
		{
			terrainId = 9004,
			times = 0,
			posList = {
				{
					x = 4,
					y = 1
				},
				{
					x = 5,
					y = 0
				},
				{
					x = 4,
					y = 0
				},
				{
					x = 5,
					y = 1
				}
			}
		},
		{
			terrainId = 9005,
			times = 0,
			posList = {
				{
					x = 4,
					y = 13
				},
				{
					x = 5,
					y = 13
				},
				{
					x = 4,
					y = 12
				},
				{
					x = 5,
					y = 12
				}
			}
		},
		{
			terrainId = 9006,
			times = 0,
			posList = {
				{
					x = 7,
					y = 10
				},
				{
					x = 8,
					y = 9
				},
				{
					x = 12,
					y = 8
				}
			}
		},
		{
			terrainId = 9007,
			times = 0,
			posList = {
				{
					x = 7,
					y = 7
				},
				{
					x = 8,
					y = 6
				},
				{
					x = 12,
					y = 6
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
					round = 99,
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
			groupName = "单格单位",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 99001301,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 13,
					tag = "",
					monsterId = 99001301,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "多格单位",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 99001302,
					x = 7,
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
		[99001301] = {
			normalSkill = 1204601,
			name = "水滴执行者",
			pre_magicAtk = 8.5,
			maxHp = 437.9,
			aiName = "ai-幻影本-守卫小怪",
			battleCamp = 1,
			career = 2,
			magicAtk = 8.5,
			pre_meleeDef = 62.1,
			sanity = -1,
			remark = "",
			giftSkill = 1223201,
			weakPointHpRate = 0,
			meleeDef = 62.1,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 84.8,
			pre_meleeAtk = 84.8,
			pre_maxHp = 437.9,
			colorType = 2,
			monsterType = 0,
			id = 99001301,
			mobility = 2,
			pre_magicDef = 28.8,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 29,
			camp = 0,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 29,
			modelId = 120046,
			magicDef = 28.8,
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
		[99001302] = {
			normalSkill = 1202601,
			name = "未知原体",
			pre_magicAtk = 165,
			maxHp = 3240,
			aiName = "ai-不朽-序章",
			battleCamp = 1,
			career = 4,
			magicAtk = 165,
			pre_meleeDef = 34,
			sanity = 0,
			remark = "",
			giftSkill = 1202607,
			weakPointHpRate = 0,
			meleeDef = 34,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 49.5,
			pre_meleeAtk = 49.5,
			pre_maxHp = 3240,
			colorType = 3,
			monsterType = 2,
			id = 99001302,
			mobility = 0,
			pre_magicDef = 61,
			aiStepOrder = 0,
			trumpSkill = 1202603,
			isFuzzy = false,
			inspire = 55,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120026,
			magicDef = 61,
			specialSkill = 1202602,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		}
	}
}

return configData
