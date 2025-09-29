-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110512.lua

module("logic.config.leveleditor.t_level_config_110512", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "",
	levelId = "110512",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通5-12",
	lossConditionDesc = "",
	sceneId = "112001",
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
			direction = 1,
			x = 7,
			y = 5
		},
		{
			direction = 1,
			x = 8,
			y = 5
		},
		{
			direction = 1,
			x = 9,
			y = 5
		},
		{
			direction = 1,
			x = 10,
			y = 5
		},
		{
			direction = 1,
			x = 11,
			y = 5
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11051202,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[11051201] = {
			normalSkill = 1208701,
			name = "人生放映机",
			pre_magicAtk = 96.4,
			maxHp = 121460.6,
			aiName = "ai_蠕虫放映机",
			battleCamp = 1,
			career = 2,
			magicAtk = 96.4,
			pre_meleeDef = 445,
			sanity = 0,
			remark = "boss模板",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 445,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 963.6,
			pre_meleeAtk = 963.6,
			pre_maxHp = 121460.6,
			colorType = 2,
			monsterType = 2,
			id = 11051201,
			mobility = 0,
			pre_magicDef = 258,
			aiStepOrder = 1,
			trumpSkill = 1208704,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120087,
			magicDef = 258,
			specialSkill = 1208702,
			extraSkills = {
				1208705
			},
			attributeGrade = {
				"A",
				"A",
				"S",
				"C",
				"C"
			},
			tags = {}
		},
		[11051202] = {
			normalSkill = 1213215,
			name = "猎食者",
			pre_magicAtk = 96.4,
			maxHp = 121460.6,
			aiName = "boss_equipment_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 96.4,
			pre_meleeDef = 445,
			sanity = 0,
			remark = "装备本-中等BOSS1",
			giftSkill = 1213218,
			weakPointHpRate = 0.3,
			meleeDef = 445,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 963.6,
			pre_meleeAtk = 963.6,
			pre_maxHp = 121460.6,
			colorType = 2,
			monsterType = 2,
			id = 11051202,
			mobility = 2,
			pre_magicDef = 258,
			aiStepOrder = 0,
			trumpSkill = 1213217,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120017,
			magicDef = 258,
			specialSkill = 1213216,
			extraSkills = {
				1213219,
				1213220
			},
			attributeGrade = {
				"A",
				"A",
				"S",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
