-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166352.lua

module("logic.config.leveleditor.t_level_config_166352", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166352",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新2教学32",
	lossConditionDesc = "",
	sceneId = "99000115",
	winConditionDesc = "注意异能触发的条件，利用弧光与超感",
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
			y = 2
		},
		{
			direction = 2,
			x = 1,
			y = 3
		},
		{
			direction = 2,
			x = 0,
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
					monsterId = 16635204,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 16635204,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 16635204,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 16635204,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 16635201,
					x = 3,
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
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 16635205,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 16635206,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 16635206,
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
			monsterId = 16635203,
			pos = {
				x = 1,
				y = 3
			},
			initialStatus = {
				hpPercent = 0.7,
				buffList = {}
			}
		},
		{
			isInitialStatus = true,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16635202,
			pos = {
				x = 1,
				y = 2
			},
			initialStatus = {
				hpPercent = 0.45,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16635207,
			pos = {
				x = 0,
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
		[16635201] = {
			normalSkill = 1770103,
			name = "迷雾使徒",
			pre_magicAtk = 20.4,
			maxHp = 350,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 20,
			pre_meleeDef = 108,
			sanity = 0,
			remark = "狙击小怪",
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
			id = 16635201,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120008,
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
		},
		[16635202] = {
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
			giftSkill = 1770126,
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
			id = 16635202,
			mobility = 4,
			pre_magicDef = 68.4,
			aiStepOrder = 0,
			trumpSkill = 0,
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
		[16635203] = {
			normalSkill = 1770125,
			name = "安妮薇",
			pre_magicAtk = 220.4,
			maxHp = 900,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 230,
			pre_meleeDef = 68.4,
			sanity = -1,
			remark = "安妮薇",
			giftSkill = 1770136,
			weakPointHpRate = 0,
			meleeDef = 60,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 22,
			pre_meleeAtk = 22,
			pre_maxHp = 909.9,
			colorType = 3,
			monsterType = 0,
			id = 16635203,
			mobility = 2,
			pre_magicDef = 108,
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
			modelId = 100013,
			magicDef = 120,
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
		[16635204] = {
			normalSkill = 1770103,
			name = "迷雾使徒",
			pre_magicAtk = 20.4,
			maxHp = 175,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 20,
			pre_meleeDef = 108,
			sanity = 0,
			remark = "狙击小怪",
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
			id = 16635204,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120008,
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
		},
		[16635205] = {
			normalSkill = 1770103,
			name = "迷雾使徒",
			pre_magicAtk = 20.4,
			maxHp = 200,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 20,
			pre_meleeDef = 108,
			sanity = 0,
			remark = "狙击小怪",
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
			id = 16635205,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120008,
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
		},
		[16635206] = {
			normalSkill = 1770103,
			name = "迷雾使徒",
			pre_magicAtk = 20.4,
			maxHp = 50,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 20,
			pre_meleeDef = 108,
			sanity = 0,
			remark = "狙击小怪",
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
			id = 16635206,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120008,
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
		},
		[16635207] = {
			normalSkill = 1770127,
			name = "幻星",
			pre_magicAtk = 213.1,
			maxHp = 936.1,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 213.1,
			pre_meleeDef = 76.5,
			sanity = -1,
			remark = "幻星",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 76.5,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 21.3,
			pre_meleeAtk = 21.3,
			pre_maxHp = 936.1,
			colorType = 4,
			monsterType = 0,
			id = 16635207,
			mobility = 2,
			pre_magicDef = 117.9,
			aiStepOrder = 0,
			trumpSkill = 1770106,
			isFuzzy = false,
			inspire = 36,
			camp = 6,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36,
			modelId = 100005,
			magicDef = 117.9,
			specialSkill = 1770128,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		}
	}
}

return configData
