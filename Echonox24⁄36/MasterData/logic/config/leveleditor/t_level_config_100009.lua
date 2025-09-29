-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_100009.lua

module("logic.config.leveleditor.t_level_config_100009", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_01",
	remarks = "",
	levelId = "100009",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "实机录制2",
	lossConditionDesc = "",
	sceneId = "111001",
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
			direction = 2,
			x = 2,
			y = 8
		},
		{
			direction = 2,
			x = 2,
			y = 6
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
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 10000901,
					x = 8,
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
			heroId = -1,
			direction = 2,
			heroType = 2,
			monsterId = 10000902,
			pos = {
				x = 2,
				y = 8
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 2,
			heroType = 2,
			monsterId = 10000903,
			pos = {
				x = 2,
				y = 6
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[10000901] = {
			normalSkill = 1282101,
			name = "枯荣/孵化",
			pre_magicAtk = 68,
			maxHp = 4088.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 68,
			pre_meleeDef = 118.3,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 118.3,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 169,
			pre_meleeAtk = 169,
			pre_maxHp = 4088.8,
			colorType = 2,
			monsterType = 1,
			id = 10000901,
			mobility = 2,
			pre_magicDef = 50.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 20.9,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 20.9,
			modelId = 120028,
			magicDef = 50.8,
			specialSkill = 1282102,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		},
		[10000902] = {
			normalSkill = 1102201,
			name = "飞鸟",
			pre_magicAtk = 77.4,
			maxHp = 385.5,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 3,
			magicAtk = 77.4,
			pre_meleeDef = 66.3,
			sanity = 0,
			remark = "",
			giftSkill = 1102204,
			weakPointHpRate = 0,
			meleeDef = 66.3,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 356.7,
			pre_meleeAtk = 356.7,
			pre_maxHp = 385.5,
			colorType = 3,
			monsterType = 0,
			id = 10000902,
			mobility = 2,
			pre_magicDef = 49.6,
			aiStepOrder = 0,
			trumpSkill = 1102203,
			isFuzzy = false,
			inspire = 26.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 100022,
			magicDef = 49.6,
			specialSkill = 1102202,
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
		[10000903] = {
			normalSkill = 1101201,
			name = "芬里尔",
			pre_magicAtk = 214.8,
			maxHp = 406.6,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 214.8,
			pre_meleeDef = 52.3,
			sanity = 0,
			remark = "",
			giftSkill = 1101204,
			weakPointHpRate = 0,
			meleeDef = 52.3,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 77.2,
			pre_meleeAtk = 77.2,
			pre_maxHp = 406.6,
			colorType = 3,
			monsterType = 0,
			id = 10000903,
			mobility = 2,
			pre_magicDef = 66.5,
			aiStepOrder = 0,
			trumpSkill = 1101203,
			isFuzzy = false,
			inspire = 30.8,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 30.8,
			modelId = 100012,
			magicDef = 66.5,
			specialSkill = 1101202,
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
