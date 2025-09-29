-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110406.lua

module("logic.config.leveleditor.t_level_config_110406", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "",
	levelId = "110406",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通4-6",
	lossConditionDesc = "",
	sceneId = "112001",
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
			x = 3,
			y = 8
		},
		{
			direction = 2,
			x = 3,
			y = 7
		},
		{
			direction = 2,
			x = 3,
			y = 6
		},
		{
			direction = 2,
			x = 4,
			y = 9
		},
		{
			direction = 2,
			x = 4,
			y = 5
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
			groupName = "怪物组1",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11040604,
					x = 6,
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
					monsterId = 11040604,
					x = 6,
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
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11040603,
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
					monsterId = 11040603,
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
					monsterId = 11040605,
					x = 12,
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
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11040602,
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组4",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 11040601,
					x = 1,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 11040601,
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
		[11040601] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 625.8,
			maxHp = 2246.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 625.8,
			pre_meleeDef = 145.8,
			sanity = 0,
			remark = "蓝特异小怪",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 145.8,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 62.6,
			pre_meleeAtk = 62.6,
			pre_maxHp = 2246.6,
			colorType = 2,
			monsterType = 0,
			id = 11040601,
			mobility = 2,
			pre_magicDef = 247.5,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 67,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 67,
			modelId = 120068,
			magicDef = 247.5,
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
		[11040602] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 56.5,
			maxHp = 2673.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 56.5,
			pre_meleeDef = 247.5,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 247.5,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 565.1,
			pre_meleeAtk = 565.1,
			pre_maxHp = 2673.7,
			colorType = 3,
			monsterType = 0,
			id = 11040602,
			mobility = 2,
			pre_magicDef = 145.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 67,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 67,
			modelId = 120030,
			magicDef = 145.8,
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
		[11040603] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 53.9,
			maxHp = 3069.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 53.9,
			pre_meleeDef = 270.9,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 270.9,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 538.7,
			pre_meleeAtk = 538.7,
			pre_maxHp = 3069.5,
			colorType = 1,
			monsterType = 0,
			id = 11040603,
			mobility = 4,
			pre_magicDef = 144,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 57,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 57,
			modelId = 120089,
			magicDef = 144,
			specialSkill = 1208902,
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
		[11040604] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 51.7,
			maxHp = 3769.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 51.7,
			pre_meleeDef = 291.6,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 291.6,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 516.7,
			pre_meleeAtk = 516.7,
			pre_maxHp = 3769.3,
			colorType = 2,
			monsterType = 0,
			id = 11040604,
			mobility = 2,
			pre_magicDef = 144.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 47,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 47,
			modelId = 120028,
			magicDef = 144.9,
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
		[11040605] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 56.4,
			maxHp = 19549.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 56.4,
			pre_meleeDef = 301,
			sanity = 0,
			remark = "幻影精英怪（主动攻击时追击；位移再动追击强化）",
			giftSkill = 1208905,
			weakPointHpRate = 0.3,
			meleeDef = 301,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 564,
			pre_meleeAtk = 564,
			pre_maxHp = 19549.2,
			colorType = 1,
			monsterType = 1,
			id = 11040605,
			mobility = 4,
			pre_magicDef = 160,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120089,
			magicDef = 160,
			specialSkill = 1208904,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[11040606] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 50.3,
			maxHp = 23697.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 50.3,
			pre_meleeDef = 324,
			sanity = 0,
			remark = "守卫精英（受到攻击后触发振荡；振荡范围强化）",
			giftSkill = 1202802,
			weakPointHpRate = 0.3,
			meleeDef = 324,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 503,
			pre_meleeAtk = 503,
			pre_maxHp = 23697.3,
			colorType = 2,
			monsterType = 1,
			id = 11040606,
			mobility = 2,
			pre_magicDef = 161,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 120028,
			magicDef = 161,
			specialSkill = 1202803,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
