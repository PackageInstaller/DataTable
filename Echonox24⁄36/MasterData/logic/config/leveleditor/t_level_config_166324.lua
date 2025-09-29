-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166324.lua

module("logic.config.leveleditor.t_level_config_166324", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166324",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新2教学4",
	lossConditionDesc = "",
	sceneId = "99000114",
	winConditionDesc = "让安布蕾拉触发[振荡]",
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
			y = 2
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
					monsterId = 16632401,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 16632401,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 16632401,
					x = 5,
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
					monsterId = 16632401,
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
			monsterId = 16632402,
			pos = {
				x = 0,
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
			monsterId = 16632403,
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
		[16632401] = {
			normalSkill = 1740056,
			name = "惑形/蜉蝣",
			pre_magicAtk = 200,
			maxHp = 30,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 200,
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
			meleeAtk = 200,
			pre_meleeAtk = 200,
			pre_maxHp = 30,
			colorType = 1,
			monsterType = 0,
			id = 16632401,
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
		[16632402] = {
			normalSkill = 1740010,
			name = "烟火",
			pre_magicAtk = 74.9,
			maxHp = 164.1,
			aiName = "auto_yanhuo_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 74.9,
			pre_meleeDef = 48.2,
			sanity = -1,
			remark = "",
			giftSkill = 1740013,
			weakPointHpRate = 0,
			meleeDef = 48.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 189.6,
			pre_meleeAtk = 189.6,
			pre_maxHp = 164.1,
			colorType = 1,
			monsterType = 0,
			id = 16632402,
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
			modelId = 100016,
			magicDef = 37.8,
			specialSkill = 1740011,
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
		[16632403] = {
			normalSkill = 1740031,
			name = "安布蕾拉",
			pre_magicAtk = 68.8,
			maxHp = 190.2,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 2,
			magicAtk = 68.8,
			pre_meleeDef = 53.5,
			sanity = -1,
			remark = "",
			giftSkill = 1740033,
			weakPointHpRate = 0,
			meleeDef = 53.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 171.2,
			pre_meleeAtk = 171.2,
			pre_maxHp = 190.2,
			colorType = 2,
			monsterType = 0,
			id = 16632403,
			mobility = 2,
			pre_magicDef = 37.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 17.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 17.9,
			modelId = 100020,
			magicDef = 37.8,
			specialSkill = 1740032,
			extraSkills = {},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
