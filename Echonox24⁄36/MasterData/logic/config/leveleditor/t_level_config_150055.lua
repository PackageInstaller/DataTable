-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150055.lua

module("logic.config.leveleditor.t_level_config_150055", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150055",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面55",
	lossConditionDesc = "",
	sceneId = "113001",
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
			direction = 3,
			x = 10,
			y = 8
		},
		{
			direction = 3,
			x = 11,
			y = 8
		},
		{
			direction = 4,
			x = 11,
			y = 12
		},
		{
			direction = 3,
			x = 12,
			y = 12
		},
		{
			direction = 3,
			x = 13,
			y = 12
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
			groupName = "特异小怪",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 15005502,
					x = 14,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 15005502,
					x = 13,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15005502,
					x = 11,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "支援小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 15005503,
					x = 13,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "狙击小怪",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 15005504,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 12,
					tag = "",
					monsterId = 15005504,
					x = 8,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "蓝色特异精英",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 15005501,
					x = 14,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[15005501] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 1491.3,
			maxHp = 37052,
			aiName = "ai_120068_噩梦圆规",
			battleCamp = 1,
			career = 4,
			magicAtk = 1491.3,
			pre_meleeDef = 384,
			sanity = 0,
			remark = "蓝特异精英-高难度",
			giftSkill = 1206802,
			weakPointHpRate = 0.3,
			meleeDef = 384,
			level = 68,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 149.1,
			pre_meleeAtk = 149.1,
			pre_maxHp = 37052,
			colorType = 2,
			monsterType = 1,
			id = 15005501,
			mobility = 2,
			pre_magicDef = 541,
			aiStepOrder = 1,
			trumpSkill = 1206804,
			isFuzzy = false,
			inspire = 82.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 82.3,
			modelId = 120068,
			magicDef = 541,
			specialSkill = 0,
			extraSkills = {
				1206803
			},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[15005502] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 1354,
			maxHp = 5957.8,
			aiName = "ai_120068_噩梦圆规",
			battleCamp = 1,
			career = 4,
			magicAtk = 1354,
			pre_meleeDef = 345.6,
			sanity = 0,
			remark = "红特异小怪（主动攻击触发超感）",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 345.6,
			level = 68,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 135.4,
			pre_meleeAtk = 135.4,
			pre_maxHp = 5957.8,
			colorType = 1,
			monsterType = 0,
			id = 15005502,
			mobility = 2,
			pre_magicDef = 486.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 79.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 79.3,
			modelId = 120068,
			magicDef = 486.9,
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
		[15005503] = {
			normalSkill = 1209501,
			name = "抽水花洒",
			pre_magicAtk = 1291.1,
			maxHp = 6180.5,
			aiName = "ai_120095_抽水花洒",
			battleCamp = 1,
			career = 6,
			magicAtk = 1291.1,
			pre_meleeDef = 372.9,
			sanity = 0,
			remark = "支援小怪",
			giftSkill = 1209503,
			weakPointHpRate = 0,
			meleeDef = 372.9,
			level = 68,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 129.1,
			pre_meleeAtk = 129.1,
			pre_maxHp = 6180.5,
			colorType = 4,
			monsterType = 0,
			id = 15005503,
			mobility = 2,
			pre_magicDef = 523.5,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.3,
			modelId = 120095,
			magicDef = 523.5,
			specialSkill = 1209502,
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
		[15005504] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 120.9,
			maxHp = 7090.6,
			aiName = "ai_120030_毒沫",
			battleCamp = 1,
			career = 3,
			magicAtk = 120.9,
			pre_meleeDef = 486.9,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 486.9,
			level = 68,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1209.5,
			pre_meleeAtk = 1209.5,
			pre_maxHp = 7090.6,
			colorType = 3,
			monsterType = 0,
			id = 15005504,
			mobility = 2,
			pre_magicDef = 345.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 79.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 79.3,
			modelId = 120030,
			magicDef = 345.6,
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
