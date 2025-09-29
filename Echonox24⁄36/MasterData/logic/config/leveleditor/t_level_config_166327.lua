-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166327.lua

module("logic.config.leveleditor.t_level_config_166327", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166327",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新2教学7",
	lossConditionDesc = "",
	sceneId = "99000206",
	winConditionDesc = "触发[援护]治疗友军",
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
			x = 2,
			y = 2
		},
		{
			direction = 2,
			x = 2,
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
					y = 2,
					tag = "",
					monsterId = 16632701,
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
					monsterId = 16632701,
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
			isInitialStatus = true,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16632703,
			pos = {
				x = 2,
				y = 2
			},
			initialStatus = {
				hpPercent = 0.7,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16632702,
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
			isInitialStatus = true,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16632704,
			pos = {
				x = 2,
				y = 0
			},
			initialStatus = {
				hpPercent = 0.7,
				buffList = {}
			}
		}
	},
	monsters = {
		[16632701] = {
			normalSkill = 1740055,
			name = "迷雾使徒",
			pre_magicAtk = 10.5,
			maxHp = 150,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 10.5,
			pre_meleeDef = 57.6,
			sanity = 0,
			remark = "幻影小怪模板",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 20.6,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 154.8,
			pre_meleeAtk = 104.8,
			pre_maxHp = 285.2,
			colorType = 1,
			monsterType = 0,
			id = 16632701,
			mobility = 4,
			pre_magicDef = 28.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35.5,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35.5,
			modelId = 120006,
			magicDef = 80,
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
		[16632702] = {
			normalSkill = 1740019,
			name = "幻星",
			pre_magicAtk = 113.2,
			maxHp = 213.7,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 113.2,
			pre_meleeDef = 33.6,
			sanity = -1,
			remark = "",
			giftSkill = 1740021,
			weakPointHpRate = 0,
			meleeDef = 33.6,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 11.3,
			pre_meleeAtk = 11.3,
			pre_maxHp = 213.7,
			colorType = 4,
			monsterType = 0,
			id = 16632702,
			mobility = 2,
			pre_magicDef = 57.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 25.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 25.5,
			modelId = 100005,
			magicDef = 57.6,
			specialSkill = 0,
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
		[16632703] = {
			normalSkill = 1740010,
			name = "烟火",
			pre_magicAtk = 10.5,
			maxHp = 285.2,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 10.5,
			pre_meleeDef = 57.6,
			sanity = -1,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 57.6,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 104.8,
			pre_meleeAtk = 104.8,
			pre_maxHp = 285.2,
			colorType = 1,
			monsterType = 0,
			id = 16632703,
			mobility = 4,
			pre_magicDef = 28.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35.5,
			modelId = 100016,
			magicDef = 28.8,
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
		[16632704] = {
			normalSkill = 1740006,
			name = "一云",
			pre_magicAtk = 10.5,
			maxHp = 285.2,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 10.5,
			pre_meleeDef = 57.6,
			sanity = -1,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 57.6,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 104.8,
			pre_meleeAtk = 104.8,
			pre_maxHp = 285.2,
			colorType = 1,
			monsterType = 0,
			id = 16632704,
			mobility = 4,
			pre_magicDef = 28.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35.5,
			modelId = 100011,
			magicDef = 28.8,
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
		}
	}
}

return configData
