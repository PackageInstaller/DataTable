-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166347.lua

module("logic.config.leveleditor.t_level_config_166347", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166347",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新2教学27",
	lossConditionDesc = "",
	sceneId = "99000212",
	winConditionDesc = "利用破甲",
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
					y = 2,
					tag = "",
					monsterId = 16634701,
					x = 3,
					initialStatus = {
						hpPercent = 100,
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
			monsterId = 16634702,
			pos = {
				x = 1,
				y = 1
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16634703,
			pos = {
				x = 1,
				y = 2
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	trialHeroes = {},
	monsters = {
		[16634701] = {
			normalSkill = 1200701,
			name = "迷雾使徒",
			pre_magicAtk = 19,
			maxHp = 300,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 20,
			pre_meleeDef = 126.9,
			sanity = 0,
			remark = "守卫小怪",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 120,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 2000,
			pre_meleeAtk = 190.4,
			pre_maxHp = 1538.6,
			colorType = 2,
			monsterType = 0,
			id = 16634701,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36,
			modelId = 120007,
			magicDef = 70,
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
		[16634702] = {
			normalSkill = 1770101,
			name = "多里安",
			pre_magicAtk = 20.4,
			maxHp = 1000,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 3,
			magicAtk = 20,
			pre_meleeDef = 108,
			sanity = -1,
			remark = "多里安",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 100,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 200,
			pre_meleeAtk = 203.7,
			pre_maxHp = 1082.9,
			colorType = 3,
			monsterType = 0,
			id = 16634702,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 100019,
			magicDef = 70,
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
		[16634703] = {
			normalSkill = 1770117,
			name = "飞鸟",
			pre_magicAtk = 20.4,
			maxHp = 1000,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 3,
			magicAtk = 20,
			pre_meleeDef = 108,
			sanity = -1,
			remark = "飞鸟",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 120,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 200,
			pre_meleeAtk = 203.7,
			pre_maxHp = 1082.9,
			colorType = 3,
			monsterType = 0,
			id = 16634703,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 100022,
			magicDef = 68,
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
