-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150036.lua

module("logic.config.leveleditor.t_level_config_150036", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150036",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面36",
	lossConditionDesc = "",
	sceneId = "113003",
	winConditionDesc = "",
	forbidAction = {
		auto = false,
		move = false,
		strengthenSkill = false,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {
			3
		}
	},
	bornPosList = {
		{
			direction = 4,
			x = 6,
			y = 6
		},
		{
			direction = 4,
			x = 6,
			y = 7
		},
		{
			direction = 3,
			x = 6,
			y = 5
		},
		{
			direction = 1,
			x = 6,
			y = 8
		},
		{
			direction = 4,
			x = 5,
			y = 6
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
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 15003603,
					x = 3,
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
					monsterId = 15003603,
					x = 3,
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
					monsterId = 15003601,
					x = 6,
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
					monsterId = 15003601,
					x = 6,
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
					monsterId = 15003604,
					x = 4,
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
					monsterId = 15003602,
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
					monsterId = 15003602,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 6,
			y = 12
		},
		{
			x = 6,
			y = 1
		}
	},
	lockHeroList = {},
	monsters = {
		[15003601] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 68.9,
			maxHp = 3678.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 68.9,
			pre_meleeDef = 284.6,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 284.6,
			level = 52,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 689.4,
			pre_meleeAtk = 689.4,
			pre_maxHp = 3678.2,
			colorType = 3,
			monsterType = 0,
			id = 15003601,
			mobility = 2,
			pre_magicDef = 185,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 71.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 71.2,
			modelId = 120088,
			magicDef = 185,
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
		[15003602] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 62.6,
			maxHp = 5266.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 62.6,
			pre_meleeDef = 332.6,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 332.6,
			level = 52,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 626.2,
			pre_meleeAtk = 626.2,
			pre_maxHp = 5266.4,
			colorType = 2,
			monsterType = 0,
			id = 15003602,
			mobility = 2,
			pre_magicDef = 184.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 51.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 51.2,
			modelId = 120028,
			magicDef = 184.1,
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
		[15003603] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 68.9,
			maxHp = 3678.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 68.9,
			pre_meleeDef = 284.6,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 284.6,
			level = 52,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 689.4,
			pre_meleeAtk = 689.4,
			pre_maxHp = 3678.2,
			colorType = 3,
			monsterType = 0,
			id = 15003603,
			mobility = 2,
			pre_magicDef = 185,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 71.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 71.2,
			modelId = 120030,
			magicDef = 185,
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
		[15003604] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 60.8,
			maxHp = 32970.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 60.8,
			pre_meleeDef = 369.6,
			sanity = 0,
			remark = "守卫精英（受到攻击后触发振荡；振荡范围强化）",
			giftSkill = 1202802,
			weakPointHpRate = 0.3,
			meleeDef = 369.6,
			level = 52,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 608.2,
			pre_meleeAtk = 608.2,
			pre_maxHp = 32970.9,
			colorType = 2,
			monsterType = 1,
			id = 15003604,
			mobility = 2,
			pre_magicDef = 204.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 54.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 54.2,
			modelId = 120028,
			magicDef = 204.6,
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
