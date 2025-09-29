-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110120.lua

module("logic.config.leveleditor.t_level_config_110120", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110120",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通1-20",
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
			direction = 3,
			x = 4,
			y = 6
		},
		{
			direction = 3,
			x = 4,
			y = 8
		},
		{
			direction = 3,
			x = 4,
			y = 7
		},
		{
			direction = 3,
			x = 5,
			y = 7
		},
		{
			direction = 3,
			x = 3,
			y = 7
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
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 11012004,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 11012003,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 11012002,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 11012001,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 11012002,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 4,
			y = 2
		}
	},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 2000021,
			direction = 3,
			heroType = 1,
			monsterId = 11011502,
			pos = {
				x = 4,
				y = 6
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[11012001] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 9.5,
			maxHp = 305.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 9.5,
			pre_meleeDef = 58.4,
			sanity = 0,
			remark = "",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 58.4,
			level = 8,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 94.7,
			pre_meleeAtk = 94.7,
			pre_maxHp = 305.6,
			colorType = 2,
			monsterType = 0,
			id = 11012001,
			mobility = 2,
			pre_magicDef = 27.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 24,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 24,
			modelId = 120090,
			magicDef = 27.2,
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
		[11012002] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 10.1,
			maxHp = 215,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 10.1,
			pre_meleeDef = 48,
			sanity = 0,
			remark = "",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 48,
			level = 8,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 100.9,
			pre_meleeAtk = 100.9,
			pre_maxHp = 215,
			colorType = 3,
			monsterType = 0,
			id = 11012002,
			mobility = 2,
			pre_magicDef = 27.2,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 44,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 44,
			modelId = 120088,
			magicDef = 27.2,
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
		[11012003] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 9.8,
			maxHp = 247.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 9.8,
			pre_meleeDef = 53.6,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 53.6,
			level = 8,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 97.5,
			pre_meleeAtk = 97.5,
			pre_maxHp = 247.6,
			colorType = 1,
			monsterType = 0,
			id = 11012003,
			mobility = 4,
			pre_magicDef = 26.4,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 34,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 34,
			modelId = 120089,
			magicDef = 26.4,
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
		[11012004] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 10.3,
			maxHp = 1992.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 10.3,
			pre_meleeDef = 73,
			sanity = 0,
			remark = "守卫精英（振荡2次；范围变大）",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 73,
			level = 8,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 102.9,
			pre_meleeAtk = 102.9,
			pre_maxHp = 1992.3,
			colorType = 2,
			monsterType = 1,
			id = 11012004,
			mobility = 2,
			pre_magicDef = 34,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 32,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 32,
			modelId = 120090,
			magicDef = 34,
			specialSkill = 1209003,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
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
