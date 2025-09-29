-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166313.lua

module("logic.config.leveleditor.t_level_config_166313", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166313",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新1教学13",
	lossConditionDesc = "",
	sceneId = "99000111",
	winConditionDesc = "利用特异飞行特性",
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
			y = 3
		},
		{
			direction = 2,
			x = 0,
			y = 1
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
					y = 2,
					tag = "",
					monsterId = 16631301,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 16631301,
					x = 3,
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
			monsterId = 16631302,
			pos = {
				x = 0,
				y = 3
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
			monsterId = 16631303,
			pos = {
				x = 0,
				y = 1
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[16631301] = {
			normalSkill = 1740056,
			name = "惑形/蜉蝣",
			pre_magicAtk = 176,
			maxHp = 30,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 176,
			pre_meleeDef = 25,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 25,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 176,
			pre_meleeAtk = 176,
			pre_maxHp = 30,
			colorType = 1,
			monsterType = 0,
			id = 16631301,
			mobility = 2,
			pre_magicDef = 17,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 14.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 14.4,
			modelId = 120029,
			magicDef = 17,
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
		[16631302] = {
			normalSkill = 1740006,
			name = "一云",
			pre_magicAtk = 74.9,
			maxHp = 124.1,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 74.9,
			pre_meleeDef = 48.2,
			sanity = -1,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 48.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 189.6,
			pre_meleeAtk = 189.6,
			pre_maxHp = 124.1,
			colorType = 1,
			monsterType = 0,
			id = 16631302,
			mobility = 4,
			pre_magicDef = 37.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22.4,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 22.4,
			modelId = 100011,
			magicDef = 37.8,
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
		[16631303] = {
			normalSkill = 1740014,
			name = "芬里尔",
			pre_magicAtk = 206.4,
			maxHp = 94,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 206.4,
			pre_meleeDef = 32.5,
			sanity = -1,
			remark = "",
			giftSkill = 0,
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
			id = 16631303,
			mobility = 2,
			pre_magicDef = 43,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 100012,
			magicDef = 43,
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
