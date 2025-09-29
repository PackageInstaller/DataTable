-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110105.lua

module("logic.config.leveleditor.t_level_config_110105", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "弱点击破教学关",
	levelId = "110105",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "主线普通1-5",
	lossConditionDesc = "",
	sceneId = "110002",
	winConditionDesc = "",
	forbidAction = {
		auto = false,
		move = false,
		strengthenSkill = false,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 3,
			x = 2,
			y = 8
		},
		{
			direction = 3,
			x = 4,
			y = 8
		},
		{
			direction = 3,
			x = 4,
			y = 9
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
			condition = 1,
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
			groupName = "精英",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 11010504,
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
			heroId = 2000022,
			direction = 3,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 4,
				y = 9
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[11010501] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 8.1,
			maxHp = 280.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 8.1,
			pre_meleeDef = 49.6,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 49.6,
			level = 4,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 80.7,
			pre_meleeAtk = 80.7,
			pre_maxHp = 280.8,
			colorType = 2,
			monsterType = 0,
			id = 11010501,
			mobility = 2,
			pre_magicDef = 23.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 22,
			modelId = 120090,
			magicDef = 23.2,
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
		[11010502] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 8.6,
			maxHp = 197.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 8.6,
			pre_meleeDef = 40.8,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 40.8,
			level = 4,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 86,
			pre_meleeAtk = 86,
			pre_maxHp = 197.3,
			colorType = 3,
			monsterType = 0,
			id = 11010502,
			mobility = 2,
			pre_magicDef = 23.2,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 42,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 42,
			modelId = 120088,
			magicDef = 23.2,
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
		[11010503] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 8.3,
			maxHp = 227.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 8.3,
			pre_meleeDef = 45.6,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 45.6,
			level = 4,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 83.1,
			pre_meleeAtk = 83.1,
			pre_maxHp = 227.2,
			colorType = 1,
			monsterType = 0,
			id = 11010503,
			mobility = 4,
			pre_magicDef = 22.4,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 32,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 32,
			modelId = 120089,
			magicDef = 22.4,
			specialSkill = 1208902,
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
		[11010504] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 9.9,
			maxHp = 2885.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 9.9,
			pre_meleeDef = 70,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 60,
			level = 7,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 98.6,
			pre_meleeAtk = 98.6,
			pre_maxHp = 3885.4,
			colorType = 2,
			monsterType = 1,
			id = 11010504,
			mobility = 2,
			pre_magicDef = 32,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 31.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 31.5,
			modelId = 120090,
			magicDef = 32,
			specialSkill = 1209003,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
