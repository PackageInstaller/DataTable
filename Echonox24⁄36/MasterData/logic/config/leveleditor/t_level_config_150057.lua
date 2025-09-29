-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150057.lua

module("logic.config.leveleditor.t_level_config_150057", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150057",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面57",
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
			direction = 1,
			x = 7,
			y = 9
		},
		{
			direction = 1,
			x = 8,
			y = 9
		},
		{
			direction = 2,
			x = 9,
			y = 8
		},
		{
			direction = 4,
			x = 6,
			y = 6
		},
		{
			direction = 4,
			x = 6,
			y = 7
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
			groupName = "支援精英",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 15005701,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 15005701,
					x = 2,
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
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 15005702,
					x = 3,
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
			groupName = "陨灭小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 15005703,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 15005703,
					x = 3,
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
			groupName = "特异小怪",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 15005704,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15005704,
					x = 12,
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
		[15005701] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 1416.1,
			maxHp = 31709.8,
			aiName = "ai_120031_再生",
			battleCamp = 1,
			career = 6,
			magicAtk = 1416.1,
			pre_meleeDef = 414.3,
			sanity = 0,
			remark = "支援精英（行动结束时援护；援护强化）",
			giftSkill = 1203105,
			weakPointHpRate = 0.3,
			meleeDef = 414.3,
			level = 68,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 141.6,
			pre_meleeAtk = 141.6,
			pre_maxHp = 31709.8,
			colorType = 4,
			monsterType = 1,
			id = 15005701,
			mobility = 2,
			pre_magicDef = 581.7,
			aiStepOrder = 0,
			trumpSkill = 1203104,
			isFuzzy = false,
			inspire = 62.3,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 4,
			monsterGroupEnum = 1,
			pre_inspire = 62.3,
			modelId = 120031,
			magicDef = 581.7,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[15005702] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 120.9,
			maxHp = 7090.6,
			aiName = "ai_120088_狂欢路灯",
			battleCamp = 1,
			career = 3,
			magicAtk = 120.9,
			pre_meleeDef = 486.9,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
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
			id = 15005702,
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
			modelId = 120088,
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
		},
		[15005703] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 117.8,
			maxHp = 7297.7,
			aiName = "ai_120069_疯狂车轴",
			battleCamp = 1,
			career = 5,
			magicAtk = 117.8,
			pre_meleeDef = 503.7,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 503.7,
			level = 68,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1178.1,
			pre_meleeAtk = 1178.1,
			pre_maxHp = 7297.7,
			colorType = 4,
			monsterType = 0,
			id = 15005703,
			mobility = 1,
			pre_magicDef = 387.6,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 69.3,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 69.3,
			modelId = 120069,
			magicDef = 387.6,
			specialSkill = 0,
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
		[15005704] = {
			normalSkill = 1209301,
			name = "自裁气球",
			pre_magicAtk = 1354,
			maxHp = 5957.8,
			aiName = "ai_120093_自裁气球",
			battleCamp = 1,
			career = 4,
			magicAtk = 1354,
			pre_meleeDef = 345.6,
			sanity = 0,
			remark = "红特异小怪（禁疗）",
			giftSkill = 1209302,
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
			id = 15005704,
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
			modelId = 120093,
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
		}
	}
}

return configData
