-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166350.lua

module("logic.config.leveleditor.t_level_config_166350", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166350",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 2,
	levelName = "新2教学30",
	lossConditionDesc = "",
	sceneId = "99000212",
	winConditionDesc = "利用瓦解辅助队友",
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
					monsterId = 16635001,
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
					monsterId = 16635004,
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
			monsterId = 16635002,
			pos = {
				x = 1,
				y = 2
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16635003,
			pos = {
				x = 1,
				y = 1
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {}
			}
		}
	},
	trialHeroes = {},
	monsters = {
		[16635001] = {
			normalSkill = 1770102,
			name = "迷雾使徒",
			pre_magicAtk = 19,
			maxHp = 400,
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
			meleeAtk = 400,
			pre_meleeAtk = 190.4,
			pre_maxHp = 1538.6,
			colorType = 2,
			monsterType = 0,
			id = 16635001,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 36,
			camp = 7,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 36,
			modelId = 120007,
			magicDef = 80,
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
		[16635002] = {
			normalSkill = 1770125,
			name = "安妮薇",
			pre_magicAtk = 267.9,
			maxHp = 700,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 300,
			pre_meleeDef = 68.4,
			sanity = 0,
			remark = "安妮薇",
			giftSkill = 1770105,
			weakPointHpRate = 0,
			meleeDef = 60,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 20,
			pre_meleeAtk = 26.8,
			pre_maxHp = 712.6,
			colorType = 3,
			monsterType = 0,
			id = 16635002,
			mobility = 2,
			pre_magicDef = 108,
			aiStepOrder = 0,
			trumpSkill = 1770104,
			isFuzzy = false,
			inspire = 56,
			camp = 1,
			hasSanity = false,
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
		[16635003] = {
			normalSkill = 1770129,
			name = "厄迪普斯",
			pre_magicAtk = 267.9,
			maxHp = 700,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 300,
			pre_meleeDef = 68.4,
			sanity = 0,
			remark = "厄迪普斯",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 60,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 20,
			pre_meleeAtk = 26.8,
			pre_maxHp = 712.6,
			colorType = 3,
			monsterType = 0,
			id = 16635003,
			mobility = 2,
			pre_magicDef = 108,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 7,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 100057,
			magicDef = 120,
			specialSkill = 1770130,
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
		[16635004] = {
			normalSkill = 1770103,
			name = "迷雾使徒",
			pre_magicAtk = 24.2,
			maxHp = 220,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 20,
			pre_meleeDef = 108,
			sanity = 0,
			remark = "狙击小怪",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 120,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 240,
			pre_meleeAtk = 242.3,
			pre_maxHp = 848.1,
			colorType = 3,
			monsterType = 0,
			id = 16635004,
			mobility = 2,
			pre_magicDef = 68.4,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 56,
			camp = 7,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 56,
			modelId = 120008,
			magicDef = 100,
			specialSkill = 0,
			extraSkills = {
				1770132
			},
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
