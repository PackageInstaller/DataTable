-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166348.lua

module("logic.config.leveleditor.t_level_config_166348", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166348",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 90,
	maxRound = 1,
	levelName = "新2教学28",
	lossConditionDesc = "",
	sceneId = "99000214",
	winConditionDesc = "依靠配合叠加破甲",
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
			x = 5,
			y = 1
		},
		{
			direction = 4,
			x = 3,
			y = 1
		},
		{
			direction = 4,
			x = 3,
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
					direction = 2,
					y = 1,
					tag = "",
					monsterId = 16634801,
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
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 4,
			heroType = 2,
			monsterId = 16634802,
			pos = {
				x = 5,
				y = 1
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		},
		{
			isInitialStatus = true,
			heroId = 0,
			direction = 4,
			heroType = 2,
			monsterId = 16634803,
			pos = {
				x = 3,
				y = 1
			},
			initialStatus = {
				hpPercent = 0.49,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 4,
			heroType = 2,
			monsterId = 16634804,
			pos = {
				x = 3,
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
		[16634801] = {
			normalSkill = 1770102,
			name = "迷雾使徒",
			pre_magicAtk = 19,
			maxHp = 350,
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
			meleeAtk = 200,
			pre_meleeAtk = 190.4,
			pre_maxHp = 1538.6,
			colorType = 2,
			monsterType = 0,
			id = 16634801,
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
			magicDef = 60,
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
		[16634802] = {
			normalSkill = 1770121,
			name = "阿妮亚",
			pre_magicAtk = 213.1,
			maxHp = 900,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 200,
			pre_meleeDef = 76.5,
			sanity = -1,
			remark = "阿妮亚",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 60,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 20,
			pre_meleeAtk = 21.3,
			pre_maxHp = 936.1,
			colorType = 4,
			monsterType = 0,
			id = 16634802,
			mobility = 2,
			pre_magicDef = 117.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36,
			modelId = 100053,
			magicDef = 120,
			specialSkill = 1770122,
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
		[16634803] = {
			normalSkill = 1770118,
			name = "奥杰塔",
			pre_magicAtk = 19.6,
			maxHp = 1000,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 20,
			pre_meleeDef = 117.9,
			sanity = -1,
			remark = "奥杰塔",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 120,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 200,
			pre_meleeAtk = 196.4,
			pre_maxHp = 1249.1,
			colorType = 1,
			monsterType = 0,
			id = 16634803,
			mobility = 4,
			pre_magicDef = 68.4,
			aiStepOrder = 0,
			trumpSkill = 1770120,
			isFuzzy = false,
			inspire = 46,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 46,
			modelId = 100047,
			magicDef = 60,
			specialSkill = 1770119,
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
		[16634804] = {
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
			id = 16634804,
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
			magicDef = 60,
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
