-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166321.lua

module("logic.config.leveleditor.t_level_config_166321", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166321",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新2教学1",
	lossConditionDesc = "",
	sceneId = "99000112",
	winConditionDesc = "用一云天赋实现[追击]",
	forbidAction = {
		auto = true,
		move = false,
		strengthenSkill = true,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 4,
			x = 2,
			y = 0
		},
		{
			direction = 2,
			x = 3,
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
					y = 0,
					tag = "",
					monsterId = 16632101,
					x = 1,
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
					monsterId = 16632101,
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
			direction = 4,
			heroType = 2,
			monsterId = 16632102,
			pos = {
				x = 2,
				y = 0
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
			monsterId = 16632103,
			pos = {
				x = 3,
				y = 0
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[16632101] = {
			normalSkill = 1740053,
			name = "迷雾使徒",
			pre_magicAtk = 68.8,
			maxHp = 194,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 68.8,
			pre_meleeDef = 53.5,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 53.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 101.2,
			pre_meleeAtk = 101.2,
			pre_maxHp = 194,
			colorType = 2,
			monsterType = 0,
			id = 16632101,
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
			modelId = 120007,
			magicDef = 37.8,
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
		[16632102] = {
			normalSkill = 1740006,
			name = "一云",
			pre_magicAtk = 74.9,
			maxHp = 164.1,
			aiName = "auto_yanhuo_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 74.9,
			pre_meleeDef = 48.2,
			sanity = -1,
			remark = "",
			giftSkill = 1740009,
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
			id = 16632102,
			mobility = 4,
			pre_magicDef = 37.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22.4,
			camp = 5,
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
		[16632103] = {
			normalSkill = 1740014,
			name = "芬里尔",
			pre_magicAtk = 206.4,
			maxHp = 94,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 245,
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
			id = 16632103,
			mobility = 2,
			pre_magicDef = 43,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 33.1,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 33.1,
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
