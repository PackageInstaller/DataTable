-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150012.lua

module("logic.config.leveleditor.t_level_config_150012", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150012",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面12",
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
			direction = 1,
			x = 3,
			y = 4
		},
		{
			direction = 2,
			x = 1,
			y = 10
		},
		{
			direction = 1,
			x = 4,
			y = 4
		},
		{
			direction = 2,
			x = 1,
			y = 9
		},
		{
			direction = 1,
			x = 11,
			y = 5
		},
		{
			direction = 1,
			x = 10,
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
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 15001202,
					x = 4,
					initialStatus = {
						hpPercent = 0,
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
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 15001202,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15001202,
					x = 3,
					initialStatus = {
						hpPercent = 0,
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
			groupName = "怪物组3",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 15001203,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15001203,
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
	lockHeroList = {},
	monsters = {
		[15001201] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 348.1,
			maxHp = 1906.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 348.1,
			pre_meleeDef = 103.5,
			sanity = 0,
			remark = "",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 103.5,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 34.8,
			pre_meleeAtk = 34.8,
			pre_maxHp = 1906.5,
			colorType = 1,
			monsterType = 0,
			id = 15001201,
			mobility = 2,
			pre_magicDef = 164.7,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120068,
			magicDef = 164.7,
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
		[15001202] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 29.9,
			maxHp = 3206,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 29.9,
			pre_meleeDef = 195.3,
			sanity = 0,
			remark = "",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 195.3,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 298.7,
			pre_meleeAtk = 298.7,
			pre_maxHp = 3206,
			colorType = 2,
			monsterType = 0,
			id = 15001202,
			mobility = 2,
			pre_magicDef = 102.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 40,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 40,
			modelId = 120014,
			magicDef = 102.6,
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
		[15001203] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 32.1,
			maxHp = 2269,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 32.1,
			pre_meleeDef = 164.7,
			sanity = 0,
			remark = "",
			giftSkill = 1201203,
			weakPointHpRate = 0,
			meleeDef = 164.7,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 320.6,
			pre_meleeAtk = 320.6,
			pre_maxHp = 2269,
			colorType = 3,
			monsterType = 0,
			id = 15001203,
			mobility = 2,
			pre_magicDef = 103.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120012,
			magicDef = 103.5,
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
