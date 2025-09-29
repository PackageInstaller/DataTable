-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166339.lua

module("logic.config.leveleditor.t_level_config_166339", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166339",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 2,
	levelName = "新2教学19",
	lossConditionDesc = "",
	sceneId = "99000212",
	winConditionDesc = "配合完成攻击与撤离",
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
					y = 1,
					tag = "",
					monsterId = 16633905,
					x = 6,
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
					monsterId = 16633906,
					x = 6,
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
					monsterId = 16633901,
					x = 5,
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
			monsterId = 16633903,
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
			monsterId = 16633904,
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
			monsterId = 16633902,
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
		[16633901] = {
			normalSkill = 1740053,
			name = "迷雾使徒",
			pre_magicAtk = 68.8,
			maxHp = 715,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 68.8,
			pre_meleeDef = 53.5,
			sanity = 0,
			remark = "",
			giftSkill = 1740041,
			weakPointHpRate = 0,
			meleeDef = 53.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 101.2,
			pre_meleeAtk = 101.2,
			pre_maxHp = 515,
			colorType = 2,
			monsterType = 0,
			id = 16633901,
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
		[16633902] = {
			normalSkill = 1740026,
			name = "飞鸟",
			pre_magicAtk = 82.6,
			maxHp = 94,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 3,
			magicAtk = 82.6,
			pre_meleeDef = 43,
			sanity = -1,
			remark = "",
			giftSkill = 1740028,
			weakPointHpRate = 0,
			meleeDef = 43,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 206.4,
			pre_meleeAtk = 206.4,
			pre_maxHp = 94,
			colorType = 3,
			monsterType = 0,
			id = 16633902,
			mobility = 2,
			pre_magicDef = 32.5,
			aiStepOrder = 1,
			trumpSkill = 1740027,
			isFuzzy = false,
			inspire = 26.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 100022,
			magicDef = 32.5,
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
		[16633903] = {
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
			id = 16633903,
			mobility = 4,
			pre_magicDef = 37.8,
			aiStepOrder = 1,
			trumpSkill = 1740012,
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
		[16633904] = {
			normalSkill = 1740017,
			name = "安妮薇",
			pre_magicAtk = 206.4,
			maxHp = 94,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 206.4,
			pre_meleeDef = 32.5,
			sanity = -1,
			remark = "",
			giftSkill = 1740018,
			weakPointHpRate = 0,
			meleeDef = 32.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.6,
			pre_meleeAtk = 82.6,
			pre_maxHp = 94,
			colorType = 3,
			monsterType = 0,
			id = 16633904,
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
			modelId = 100013,
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
		},
		[16633905] = {
			normalSkill = 1740053,
			name = "迷雾使徒",
			pre_magicAtk = 68.8,
			maxHp = 715,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 68.8,
			pre_meleeDef = 53.5,
			sanity = 0,
			remark = "",
			giftSkill = 1740041,
			weakPointHpRate = 0,
			meleeDef = 53.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 101.2,
			pre_meleeAtk = 101.2,
			pre_maxHp = 515,
			colorType = 2,
			monsterType = 0,
			id = 16633905,
			mobility = 2,
			pre_magicDef = 37.8,
			aiStepOrder = 2,
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
		[16633906] = {
			normalSkill = 1740053,
			name = "迷雾使徒",
			pre_magicAtk = 68.8,
			maxHp = 715,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 68.8,
			pre_meleeDef = 53.5,
			sanity = 0,
			remark = "",
			giftSkill = 1740041,
			weakPointHpRate = 0,
			meleeDef = 53.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 101.2,
			pre_meleeAtk = 101.2,
			pre_maxHp = 515,
			colorType = 2,
			monsterType = 0,
			id = 16633906,
			mobility = 2,
			pre_magicDef = 37.8,
			aiStepOrder = 3,
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
		}
	}
}

return configData
