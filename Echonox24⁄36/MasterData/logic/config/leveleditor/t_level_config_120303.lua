-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120303.lua

module("logic.config.leveleditor.t_level_config_120303", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120303",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "3-断章A-3",
	lossConditionDesc = "",
	sceneId = "109001",
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
			y = 7
		},
		{
			direction = 2,
			x = 1,
			y = 7
		},
		{
			direction = 2,
			x = 3,
			y = 8
		},
		{
			direction = 2,
			x = 1,
			y = 6
		},
		{
			direction = 2,
			x = 3,
			y = 6
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 16,
					y = 8
				},
				{
					x = 16,
					y = 7
				},
				{
					x = 16,
					y = 6
				},
				{
					x = 16,
					y = 5
				}
			}
		},
		{
			terrainId = 1008,
			times = 1,
			posList = {
				{
					x = 7,
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
					count = 2,
					monsterTag = "",
					DIYName = "",
					condition = 7,
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 12030301,
					x = 13,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 4,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "陨灭",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 12030302,
					x = 12,
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
					monsterId = 12030302,
					x = 12,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 12030302,
					x = 11,
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
			form = 3,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "特异",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 12030303,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 12030303,
					x = 7,
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
					monsterId = 12030303,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 12030303,
					x = 5,
					initialStatus = {
						hpPercent = 100,
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
			groupName = "狙",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 12030304,
					x = 9,
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
					monsterId = 12030304,
					x = 10,
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
		[12030301] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 37.1,
			maxHp = 7659,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 37.1,
			pre_meleeDef = 185.2,
			sanity = 0,
			remark = "陨灭精英（具有3层及以上的轰鸣时；主动攻击必定暴击；暴伤提升）",
			giftSkill = 1206903,
			weakPointHpRate = 0.3,
			meleeDef = 185.2,
			level = 28,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 370.8,
			pre_meleeAtk = 370.8,
			pre_maxHp = 7659,
			colorType = 4,
			monsterType = 1,
			id = 12030301,
			mobility = 1,
			pre_magicDef = 124.6,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 52.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 52.4,
			modelId = 120069,
			magicDef = 124.6,
			specialSkill = 1206902,
			extraSkills = {
				1206904
			},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"B"
			}
		},
		[12030302] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 29.9,
			maxHp = 2088.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 29.9,
			pre_meleeDef = 166.7,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 166.7,
			level = 28,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 299.1,
			pre_meleeAtk = 299.1,
			pre_maxHp = 2088.6,
			colorType = 4,
			monsterType = 0,
			id = 12030302,
			mobility = 1,
			pre_magicDef = 112.1,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 49.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 49.4,
			modelId = 120069,
			magicDef = 112.1,
			specialSkill = 1206902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			}
		},
		[12030303] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 330,
			maxHp = 1716.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 330,
			pre_meleeDef = 95.6,
			sanity = 0,
			remark = "红特异小怪（主动攻击触发超感）",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 95.6,
			level = 28,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 33,
			pre_meleeAtk = 33,
			pre_maxHp = 1716.9,
			colorType = 1,
			monsterType = 0,
			id = 12030303,
			mobility = 2,
			pre_magicDef = 159.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.4,
			modelId = 120068,
			magicDef = 159.3,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			}
		},
		[12030304] = {
			normalSkill = 1200801,
			name = "迷雾使徒",
			pre_magicAtk = 30.5,
			maxHp = 2043.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 30.5,
			pre_meleeDef = 159.3,
			sanity = 0,
			remark = "狙击小怪",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 159.3,
			level = 28,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 304.6,
			pre_meleeAtk = 304.6,
			pre_maxHp = 2043.4,
			colorType = 3,
			monsterType = 0,
			id = 12030304,
			mobility = 2,
			pre_magicDef = 95.6,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.4,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.4,
			modelId = 120008,
			magicDef = 95.6,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C"
			}
		}
	}
}

return configData
