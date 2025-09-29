-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130502.lua

module("logic.config.leveleditor.t_level_config_130502", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130502",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "狙击材料本-2",
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
			direction = 1,
			x = 6,
			y = 8
		},
		{
			direction = 1,
			x = 7,
			y = 8
		},
		{
			direction = 1,
			x = 8,
			y = 8
		}
	},
	additionalTerrainList = {
		{
			terrainId = 4003,
			times = 1,
			posList = {
				{
					x = 3,
					y = 8
				},
				{
					x = 7,
					y = 4
				},
				{
					x = 11,
					y = 8
				},
				{
					x = 2,
					y = 5
				},
				{
					x = 1,
					y = 13
				},
				{
					x = 7,
					y = 11
				},
				{
					x = 11,
					y = 2
				},
				{
					x = 3,
					y = 2
				},
				{
					x = 13,
					y = 5
				},
				{
					x = 13,
					y = 11
				},
				{
					x = 11,
					y = 13
				},
				{
					x = 7,
					y = 7
				},
				{
					x = 7,
					y = 9
				},
				{
					x = 7,
					y = 2
				}
			}
		}
	},
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
					condition = 3,
					monsterIds = {
						13050201
					}
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "boss",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 13050201,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 7,
			y = 10
		}
	},
	lockHeroList = {},
	trialHeroes = {},
	monsters = {
		[13050201] = {
			normalSkill = 1203201,
			name = "猎食者",
			pre_magicAtk = 13,
			maxHp = 4234.1,
			aiName = "ai-狙击本-执行者boss",
			battleCamp = 1,
			career = 2,
			magicAtk = 15.7,
			pre_meleeDef = 65,
			sanity = 0,
			remark = "",
			giftSkill = 1203202,
			weakPointHpRate = 0.3,
			meleeDef = 30,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 157.3,
			pre_meleeAtk = 129.8,
			pre_maxHp = 10229.4,
			colorType = 2,
			monsterType = 2,
			id = 13050201,
			mobility = 2,
			pre_magicDef = 30,
			aiStepOrder = 0,
			trumpSkill = 1203203,
			isFuzzy = false,
			inspire = 35.5,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 32.5,
			modelId = 120017,
			magicDef = 78,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"A",
				"C",
				"C",
				"S"
			},
			tags = {}
		}
	}
}

return configData
