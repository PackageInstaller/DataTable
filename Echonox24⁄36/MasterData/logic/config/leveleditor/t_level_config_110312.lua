-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110312.lua

module("logic.config.leveleditor.t_level_config_110312", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110312",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "主线普通3-12",
	lossConditionDesc = "",
	sceneId = "113003",
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
			x = 8,
			y = 9
		},
		{
			direction = 2,
			x = 8,
			y = 8
		},
		{
			direction = 4,
			x = 6,
			y = 5
		},
		{
			direction = 4,
			x = 6,
			y = 7
		},
		{
			direction = 3,
			x = 7,
			y = 4
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 12,
					y = 7
				},
				{
					x = 11,
					y = 7
				},
				{
					x = 2,
					y = 7
				},
				{
					x = 2,
					y = 6
				},
				{
					x = 7,
					y = 0
				},
				{
					x = 6,
					y = 0
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
					count = 3,
					monsterTag = "",
					DIYName = "",
					condition = 7,
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
			groupName = "左侧",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 11031203,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 11031201,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 11031201,
					x = 4,
					initialStatus = {
						hpPercent = 100,
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
			groupName = "下方",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 11031202,
					x = 6,
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
					monsterId = 11031202,
					x = 7,
					initialStatus = {
						hpPercent = 100,
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
			groupName = "右侧",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 11031203,
					x = 12,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11031201,
					x = 11,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11031202,
					x = 12,
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
		[11031201] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 34.2,
			maxHp = 1952.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 34.2,
			pre_meleeDef = 191.9,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 191.9,
			level = 29,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 341.4,
			pre_meleeAtk = 341.4,
			pre_maxHp = 1952.5,
			colorType = 2,
			monsterType = 0,
			id = 11031201,
			mobility = 2,
			pre_magicDef = 98.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 39.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 39.7,
			modelId = 120028,
			magicDef = 98.8,
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
		[11031202] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 37.4,
			maxHp = 1383.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 37.4,
			pre_meleeDef = 162,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 162,
			level = 29,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 373.7,
			pre_meleeAtk = 373.7,
			pre_maxHp = 1383.2,
			colorType = 3,
			monsterType = 0,
			id = 11031202,
			mobility = 2,
			pre_magicDef = 99.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.7,
			modelId = 120030,
			magicDef = 99.5,
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
		[11031203] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 396.6,
			maxHp = 1191,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 396.6,
			pre_meleeDef = 110.9,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 110.9,
			level = 29,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 39.7,
			pre_meleeAtk = 39.7,
			pre_maxHp = 1191,
			colorType = 4,
			monsterType = 0,
			id = 11031203,
			mobility = 2,
			pre_magicDef = 177.8,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 39.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 39.7,
			modelId = 120031,
			magicDef = 177.8,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		}
	}
}

return configData
