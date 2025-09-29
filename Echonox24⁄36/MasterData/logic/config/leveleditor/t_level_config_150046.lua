-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150046.lua

module("logic.config.leveleditor.t_level_config_150046", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150046",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面46",
	lossConditionDesc = "",
	sceneId = "109003",
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
			x = 6,
			y = 8
		},
		{
			direction = 3,
			x = 7,
			y = 8
		},
		{
			direction = 3,
			x = 8,
			y = 8
		},
		{
			direction = 3,
			x = 9,
			y = 8
		},
		{
			direction = 3,
			x = 10,
			y = 8
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "狙击精英",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15004601,
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
			groupName = "狙击小怪",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15004602,
					x = 9,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 15004602,
					x = 7,
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
			groupName = "怪物组3",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15004603,
					x = 9,
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
					monsterId = 15004603,
					x = 7,
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
			groupName = "怪物组4",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15004604,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15004604,
					x = 8,
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
		[15004601] = {
			normalSkill = 1207001,
			name = "彩绘积木",
			pre_magicAtk = 94,
			maxHp = 31822,
			aiName = "ai_120070_涂鸦积木",
			battleCamp = 1,
			career = 3,
			magicAtk = 94,
			pre_meleeDef = 385,
			sanity = 0,
			remark = "狙击精英",
			giftSkill = 1207003,
			weakPointHpRate = 0.3,
			meleeDef = 385,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 940.1,
			pre_meleeAtk = 940.1,
			pre_maxHp = 31822,
			colorType = 3,
			monsterType = 1,
			id = 15004601,
			mobility = 2,
			pre_magicDef = 260,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 78,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 78,
			modelId = 120070,
			magicDef = 260,
			specialSkill = 1207004,
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
		[15004602] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 84.7,
			maxHp = 5029.5,
			aiName = "ai_120088_狂欢路灯",
			battleCamp = 1,
			career = 3,
			magicAtk = 84.7,
			pre_meleeDef = 346.5,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 346.5,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 846.7,
			pre_meleeAtk = 846.7,
			pre_maxHp = 5029.5,
			colorType = 3,
			monsterType = 0,
			id = 15004602,
			mobility = 2,
			pre_magicDef = 234,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 75,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 75,
			modelId = 120088,
			magicDef = 234,
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
		[15004603] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 76.8,
			maxHp = 7272.7,
			aiName = "ai_120028_秽卵",
			battleCamp = 1,
			career = 2,
			magicAtk = 76.8,
			pre_meleeDef = 400.5,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 400.5,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 767.9,
			pre_meleeAtk = 767.9,
			pre_maxHp = 7272.7,
			colorType = 2,
			monsterType = 0,
			id = 15004603,
			mobility = 2,
			pre_magicDef = 232.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120028,
			magicDef = 232.2,
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
		[15004604] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 945.5,
			maxHp = 4226,
			aiName = "ai_120068_噩梦圆规",
			battleCamp = 1,
			career = 4,
			magicAtk = 945.5,
			pre_meleeDef = 234,
			sanity = 0,
			remark = "蓝特异小怪",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 234,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 94.6,
			pre_meleeAtk = 94.6,
			pre_maxHp = 4226,
			colorType = 2,
			monsterType = 0,
			id = 15004604,
			mobility = 2,
			pre_magicDef = 346.5,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 75,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 75,
			modelId = 120068,
			magicDef = 346.5,
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
