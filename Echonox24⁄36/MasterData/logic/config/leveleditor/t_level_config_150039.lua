-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150039.lua

module("logic.config.leveleditor.t_level_config_150039", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150039",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面39",
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
			direction = 4,
			x = 6,
			y = 6
		},
		{
			direction = 4,
			x = 5,
			y = 6
		},
		{
			direction = 3,
			x = 6,
			y = 5
		},
		{
			direction = 1,
			x = 6,
			y = 7
		},
		{
			direction = 4,
			x = 4,
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
					y = 6,
					tag = "",
					monsterId = 15003904,
					x = 2,
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
					monsterId = 15003903,
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
					monsterId = 15003903,
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
					monsterId = 15003903,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 15003902,
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
					monsterId = 15003901,
					x = 6,
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
			y = 9
		},
		{
			x = 6,
			y = 1
		}
	},
	lockHeroList = {},
	monsters = {
		[15003901] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 81.6,
			maxHp = 22699.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 81.6,
			pre_meleeDef = 357,
			sanity = 0,
			remark = "陨灭精英（具有3层及以上的轰鸣时；主动攻击必定暴击；暴伤提升）",
			giftSkill = 1206903,
			weakPointHpRate = 0.3,
			meleeDef = 357,
			level = 54,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 815.5,
			pre_meleeAtk = 815.5,
			pre_maxHp = 22699.6,
			colorType = 4,
			monsterType = 1,
			id = 15003901,
			mobility = 1,
			pre_magicDef = 262.2,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 65.4,
			modelId = 120069,
			magicDef = 262.2,
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
		},
		[15003902] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 75.6,
			maxHp = 4168.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 75.6,
			pre_meleeDef = 309.1,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 309.1,
			level = 54,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 755.7,
			pre_meleeAtk = 755.7,
			pre_maxHp = 4168.4,
			colorType = 3,
			monsterType = 0,
			id = 15003902,
			mobility = 2,
			pre_magicDef = 204.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 72.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 72.4,
			modelId = 120088,
			magicDef = 204.5,
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
		[15003903] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 68.5,
			maxHp = 6003.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 68.5,
			pre_meleeDef = 359.3,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 359.3,
			level = 54,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 685.5,
			pre_meleeAtk = 685.5,
			pre_maxHp = 6003.7,
			colorType = 2,
			monsterType = 0,
			id = 15003903,
			mobility = 2,
			pre_magicDef = 203.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 52.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 52.4,
			modelId = 120028,
			magicDef = 203.6,
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
		[15003904] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 73.7,
			maxHp = 4285.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 73.7,
			pre_meleeDef = 321.3,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 321.3,
			level = 54,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 736.5,
			pre_meleeAtk = 736.5,
			pre_maxHp = 4285.9,
			colorType = 4,
			monsterType = 0,
			id = 15003904,
			mobility = 1,
			pre_magicDef = 236,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 62.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 62.4,
			modelId = 120069,
			magicDef = 236,
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
		}
	}
}

return configData
