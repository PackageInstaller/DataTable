-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_190102.lua

module("logic.config.leveleditor.t_level_config_190102", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "190102",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "追击体验难度2",
	lossConditionDesc = "",
	sceneId = "116002",
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
			x = 9,
			y = 8
		},
		{
			direction = 4,
			x = 5,
			y = 8
		},
		{
			direction = 3,
			x = 8,
			y = 6
		},
		{
			direction = 3,
			x = 6,
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
					DIYName = "10回合内击杀所有原体",
					condition = 13,
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
	globalSkillCodeList = {
		1721911
	},
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
					y = 2,
					tag = "",
					monsterId = 19010202,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 19010202,
					x = 0,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 19010202,
					x = 14,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	trialHeroes = {},
	monsters = {
		[19010201] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 48.3,
			maxHp = 2106.2,
			aiName = "ai_追击体验本",
			battleCamp = 1,
			career = 3,
			magicAtk = 48.3,
			pre_meleeDef = 206.1,
			sanity = 0,
			remark = "狙击小怪（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0,
			meleeDef = 206.1,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 483.3,
			pre_meleeAtk = 483.3,
			pre_maxHp = 2106.2,
			colorType = 3,
			monsterType = 0,
			id = 19010201,
			mobility = 2,
			pre_magicDef = 122.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120088,
			magicDef = 122.4,
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
		[19010202] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 53.4,
			maxHp = 13765.5,
			aiName = "ai_追击体验本",
			battleCamp = 1,
			career = 3,
			magicAtk = 53.4,
			pre_meleeDef = 229,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.18,
			meleeDef = 229,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 533.5,
			pre_meleeAtk = 533.5,
			pre_maxHp = 13765.5,
			colorType = 3,
			monsterType = 1,
			id = 19010202,
			mobility = 2,
			pre_magicDef = 136,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 68,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 68,
			modelId = 120088,
			magicDef = 136,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
