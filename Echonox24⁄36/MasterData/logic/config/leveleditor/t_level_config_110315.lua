-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110315.lua

module("logic.config.leveleditor.t_level_config_110315", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110315",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通3-15",
	lossConditionDesc = "",
	sceneId = "113002",
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
			x = 4,
			y = 10
		},
		{
			direction = 1,
			x = 5,
			y = 8
		},
		{
			direction = 1,
			x = 4,
			y = 8
		},
		{
			direction = 1,
			x = 5,
			y = 10
		},
		{
			direction = 1,
			x = 3,
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
			groupName = "精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 11031501,
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
			groupName = "前排近战",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 11031503,
					x = 3,
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
					monsterId = 11031503,
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
			groupName = "后排远程+奶妈",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 14,
					tag = "",
					monsterId = 11031502,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 14,
					tag = "",
					monsterId = 11031504,
					x = 5,
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
					monsterId = 11031504,
					x = 2,
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
		[11031501] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 42.4,
			maxHp = 9804.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 42.4,
			pre_meleeDef = 183,
			sanity = 0,
			remark = "狙击精英（弧光额外弹射3次）",
			giftSkill = 1203002,
			weakPointHpRate = 0.3,
			meleeDef = 183,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 423.9,
			pre_meleeAtk = 423.9,
			pre_maxHp = 9804.7,
			colorType = 3,
			monsterType = 1,
			id = 11031501,
			mobility = 2,
			pre_magicDef = 115,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 63,
			modelId = 120030,
			magicDef = 115,
			specialSkill = 1203003,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[11031502] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 407.9,
			maxHp = 1252.7,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 407.9,
			pre_meleeDef = 115.2,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 115.2,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 40.8,
			pre_meleeAtk = 40.8,
			pre_maxHp = 1252.7,
			colorType = 4,
			monsterType = 0,
			id = 11031502,
			mobility = 2,
			pre_magicDef = 180.9,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 40,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 40,
			modelId = 120031,
			magicDef = 180.9,
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
		[11031503] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 35.1,
			maxHp = 2054.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 35.1,
			pre_meleeDef = 195.3,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 195.3,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 350.5,
			pre_meleeAtk = 350.5,
			pre_maxHp = 2054.5,
			colorType = 2,
			monsterType = 0,
			id = 11031503,
			mobility = 2,
			pre_magicDef = 102.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 40,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 40,
			modelId = 120028,
			magicDef = 102.6,
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
		[11031504] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 38.4,
			maxHp = 1454,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 38.4,
			pre_meleeDef = 164.7,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 164.7,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 384.1,
			pre_meleeAtk = 384.1,
			pre_maxHp = 1454,
			colorType = 3,
			monsterType = 0,
			id = 11031504,
			mobility = 2,
			pre_magicDef = 103.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120030,
			magicDef = 103.5,
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
		}
	}
}

return configData
