-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110210.lua

module("logic.config.leveleditor.t_level_config_110210", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal03_block",
	remarks = "",
	levelId = "110210",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通2-10",
	lossConditionDesc = "",
	sceneId = "108004",
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
			x = 2,
			y = 9
		},
		{
			direction = 2,
			x = 1,
			y = 8
		},
		{
			direction = 2,
			x = 2,
			y = 7
		},
		{
			direction = 2,
			x = 1,
			y = 6
		},
		{
			direction = 2,
			x = 2,
			y = 5
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1022,
			times = 1,
			posList = {
				{
					x = 5,
					y = 7
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
			groupName = "后排愤怨",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11021002,
					x = 7,
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
					monsterId = 11021002,
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
			groupName = "前排怪物",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 11021001,
					x = 4,
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
					monsterId = 11021001,
					x = 4,
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
					monsterId = 11021001,
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
			groupName = "两侧包围",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 11021001,
					x = 1,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 11021001,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 11021001,
					x = 1,
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
					monsterId = 11021001,
					x = 2,
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
					monsterId = 11021001,
					x = 1,
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
		[11021001] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 14.4,
			maxHp = 943.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 14.4,
			pre_meleeDef = 100.2,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 100.2,
			level = 17,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 144.2,
			pre_meleeAtk = 144.2,
			pre_maxHp = 943.4,
			colorType = 2,
			monsterType = 0,
			id = 11021001,
			mobility = 2,
			pre_magicDef = 44.4,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 34.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 34.3,
			modelId = 120067,
			magicDef = 44.4,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			}
		},
		[11021002] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 15.1,
			maxHp = 697.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 15.1,
			pre_meleeDef = 87,
			sanity = 0,
			remark = "",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 87,
			level = 17,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 151,
			pre_meleeAtk = 151,
			pre_maxHp = 697.1,
			colorType = 4,
			monsterType = 0,
			id = 11021002,
			mobility = 1,
			pre_magicDef = 54.6,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 44.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 44.3,
			modelId = 120069,
			magicDef = 54.6,
			specialSkill = 1206902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		}
	}
}

return configData
