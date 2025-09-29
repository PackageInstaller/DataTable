-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110408.lua

module("logic.config.leveleditor.t_level_config_110408", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "",
	levelId = "110408",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通4-8",
	lossConditionDesc = "",
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
			x = 5,
			y = 2
		},
		{
			direction = 1,
			x = 6,
			y = 2
		},
		{
			direction = 1,
			x = 7,
			y = 2
		},
		{
			direction = 1,
			x = 8,
			y = 2
		},
		{
			direction = 1,
			x = 9,
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
			form = 5,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11040803,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11040803,
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
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组2",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11040802,
					x = 10,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11040802,
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
			groupName = "怪物组3",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11040805,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11040801,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 11040801,
					x = 13,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 2,
					tag = "",
					monsterId = 11040801,
					x = 1,
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
		[11040801] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 57.4,
			maxHp = 2949.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 57.4,
			pre_meleeDef = 263.3,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 263.3,
			level = 47,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 574.3,
			pre_meleeAtk = 574.3,
			pre_maxHp = 2949.7,
			colorType = 4,
			monsterType = 0,
			id = 11040801,
			mobility = 1,
			pre_magicDef = 178.9,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 58.2,
			modelId = 120069,
			magicDef = 178.9,
			specialSkill = 1206902,
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
		[11040802] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 53.7,
			maxHp = 4073.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 53.7,
			pre_meleeDef = 297.4,
			sanity = 0,
			remark = "守卫小怪（主动攻击触发2次锥刺）",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 297.4,
			level = 47,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 536.8,
			pre_meleeAtk = 536.8,
			pre_maxHp = 4073.2,
			colorType = 2,
			monsterType = 0,
			id = 11040802,
			mobility = 2,
			pre_magicDef = 152.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 48.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 48.2,
			modelId = 120067,
			magicDef = 152.8,
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
		[11040803] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 624.9,
			maxHp = 2482,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 624.9,
			pre_meleeDef = 170.1,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 170.1,
			level = 47,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 62.5,
			pre_meleeAtk = 62.5,
			pre_maxHp = 2482,
			colorType = 4,
			monsterType = 0,
			id = 11040803,
			mobility = 2,
			pre_magicDef = 276.3,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 48.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 48.2,
			modelId = 120031,
			magicDef = 276.3,
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
		},
		[11040804] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 52.2,
			maxHp = 25568.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 52.2,
			pre_meleeDef = 330.4,
			sanity = 0,
			remark = "守卫精英（主动攻击触发2次锥刺并回血坚韧）",
			giftSkill = 1206702,
			weakPointHpRate = 0.3,
			meleeDef = 330.4,
			level = 47,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 522.2,
			pre_meleeAtk = 522.2,
			pre_maxHp = 25568.2,
			colorType = 2,
			monsterType = 1,
			id = 11040804,
			mobility = 2,
			pre_magicDef = 169.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 51.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 51.2,
			modelId = 120067,
			magicDef = 169.8,
			specialSkill = 1206703,
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
		[11040805] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 63.2,
			maxHp = 15730.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 63.2,
			pre_meleeDef = 292.6,
			sanity = 0,
			remark = "陨灭精英（具有3层及以上的轰鸣时；主动攻击必定暴击；暴伤提升）",
			giftSkill = 1206903,
			weakPointHpRate = 0.3,
			meleeDef = 292.6,
			level = 47,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 632.4,
			pre_meleeAtk = 632.4,
			pre_maxHp = 15730.7,
			colorType = 4,
			monsterType = 1,
			id = 11040805,
			mobility = 1,
			pre_magicDef = 198.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 61.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 61.2,
			modelId = 120069,
			magicDef = 198.8,
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
			},
			tags = {}
		}
	}
}

return configData
