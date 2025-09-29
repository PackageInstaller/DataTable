-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120211.lua

module("logic.config.leveleditor.t_level_config_120211", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120211",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "2-断章B-1",
	lossConditionDesc = "",
	sceneId = "108002",
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
			y = 1
		},
		{
			direction = 2,
			x = 3,
			y = 0
		},
		{
			direction = 2,
			x = 2,
			y = 2
		},
		{
			direction = 2,
			x = 3,
			y = 3
		},
		{
			direction = 2,
			x = 4,
			y = 0
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
					condition = 3,
					monsterIds = {
						12021105
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
			targetId = 2000053,
			monsterIds = {}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "大水晶",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 12021102,
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
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 12021105,
					x = 8,
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
			groupName = "初始盾",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 12021103,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 12021103,
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "初始特异",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 12021104,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 12021104,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 2000053,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 2,
				y = 2
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[12021101] = {
			normalSkill = 1105301,
			name = "阿妮亚",
			pre_magicAtk = 213.1,
			maxHp = 936.1,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 213.1,
			pre_meleeDef = 76.5,
			sanity = 0,
			remark = "",
			giftSkill = 1105304,
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
			id = 12021101,
			mobility = 2,
			pre_magicDef = 117.9,
			aiStepOrder = 0,
			trumpSkill = 1105303,
			isFuzzy = false,
			inspire = 36,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36,
			modelId = 100053,
			magicDef = 117.9,
			specialSkill = 1105302,
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
		[12021102] = {
			normalSkill = 0,
			name = "异变以太水晶",
			pre_magicAtk = 522.5,
			maxHp = 19415,
			aiName = "mob_stand_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 522.5,
			pre_meleeDef = 115,
			sanity = 0,
			remark = "",
			giftSkill = 1208310,
			weakPointHpRate = 0,
			meleeDef = 115,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 52.2,
			pre_meleeAtk = 52.2,
			pre_maxHp = 19415,
			colorType = 2,
			monsterType = 2,
			id = 12021102,
			mobility = 0,
			pre_magicDef = 183,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120083,
			magicDef = 183,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[12021103] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 19,
			maxHp = 1538.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 19,
			pre_meleeDef = 126.9,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
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
			id = 12021103,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36,
			modelId = 120067,
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
		[12021104] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 220.4,
			maxHp = 909.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 220.4,
			pre_meleeDef = 68.4,
			sanity = 0,
			remark = "",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 68.4,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 22,
			pre_meleeAtk = 22,
			pre_maxHp = 909.9,
			colorType = 1,
			monsterType = 0,
			id = 12021104,
			mobility = 2,
			pre_magicDef = 108,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120068,
			magicDef = 108,
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
		[12021105] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 276.7,
			maxHp = 3360,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 276.7,
			pre_meleeDef = 76,
			sanity = 0,
			remark = "",
			giftSkill = 1206802,
			weakPointHpRate = 0.5,
			meleeDef = 76,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 27.7,
			pre_meleeAtk = 27.7,
			pre_maxHp = 3360,
			colorType = 1,
			monsterType = 1,
			id = 12021105,
			mobility = 2,
			pre_magicDef = 120,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 59,
			modelId = 120068,
			magicDef = 120,
			specialSkill = 0,
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
