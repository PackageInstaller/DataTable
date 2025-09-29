-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166338.lua

module("logic.config.leveleditor.t_level_config_166338", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166338",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新2教学18",
	lossConditionDesc = "",
	sceneId = "99000210",
	winConditionDesc = "利用群体坚韧与光环",
	forbidAction = {
		auto = true,
		move = false,
		strengthenSkill = true,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 2,
			x = 0,
			y = 0
		},
		{
			direction = 2,
			x = 1,
			y = 1
		},
		{
			direction = 2,
			x = 1,
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
			condition = 3,
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
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 16633801,
					x = 4,
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
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16633802,
			pos = {
				x = 1,
				y = 2
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16633803,
			pos = {
				x = 1,
				y = 1
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16633804,
			pos = {
				x = 0,
				y = 0
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[16633801] = {
			normalSkill = 1740054,
			name = "迷雾使徒",
			pre_magicAtk = 74.9,
			maxHp = 388,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 74.9,
			pre_meleeDef = 48.2,
			sanity = 0,
			remark = "狙击小怪",
			giftSkill = 1740045,
			weakPointHpRate = 0,
			meleeDef = 48.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 90,
			pre_meleeAtk = 89.6,
			pre_maxHp = 281,
			colorType = 3,
			monsterType = 0,
			id = 16633801,
			mobility = 2,
			pre_magicDef = 37.8,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22.4,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 22.4,
			modelId = 120008,
			magicDef = 37.8,
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
		[16633802] = {
			normalSkill = 0,
			name = "阿妮亚",
			pre_magicAtk = 171.2,
			maxHp = 44,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 171.2,
			pre_meleeDef = 37.8,
			sanity = -1,
			remark = "",
			giftSkill = 1740025,
			weakPointHpRate = 0,
			meleeDef = 37.8,
			level = 1,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.6,
			pre_meleeAtk = 82.6,
			pre_maxHp = 112.7,
			colorType = 4,
			monsterType = 0,
			id = 16633802,
			mobility = 2,
			pre_magicDef = 43,
			aiStepOrder = 1,
			trumpSkill = 1740024,
			isFuzzy = false,
			inspire = 17.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 17.9,
			modelId = 100053,
			magicDef = 32.5,
			specialSkill = 1740023,
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
		[16633803] = {
			normalSkill = 1740014,
			name = "芬里尔",
			pre_magicAtk = 206.4,
			maxHp = 172,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 206.4,
			pre_meleeDef = 32.5,
			sanity = -1,
			remark = "",
			giftSkill = 1740016,
			weakPointHpRate = 0,
			meleeDef = 32.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.6,
			pre_meleeAtk = 82.6,
			pre_maxHp = 94,
			colorType = 2,
			monsterType = 0,
			id = 16633803,
			mobility = 2,
			pre_magicDef = 43,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 28.8,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 100012,
			magicDef = 43,
			specialSkill = 0,
			extraSkills = {
				1740015
			},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		},
		[16633804] = {
			normalSkill = 1740034,
			name = "林鸮",
			pre_magicAtk = 82.6,
			maxHp = 44,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 82.6,
			pre_meleeDef = 43,
			sanity = -1,
			remark = "",
			giftSkill = 1740036,
			weakPointHpRate = 0,
			meleeDef = 43,
			level = 1,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 206.4,
			pre_meleeAtk = 206.4,
			pre_maxHp = 94,
			colorType = 3,
			monsterType = 0,
			id = 16633804,
			mobility = 2,
			pre_magicDef = 32.5,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 30,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 100010,
			magicDef = 32.5,
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
