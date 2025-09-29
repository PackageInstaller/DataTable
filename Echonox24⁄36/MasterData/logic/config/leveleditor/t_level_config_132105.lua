-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_132105.lua

module("logic.config.leveleditor.t_level_config_132105", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "132105",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "装备副本1-5",
	lossConditionDesc = "",
	sceneId = "109003",
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
			x = 8,
			y = 4
		},
		{
			direction = 1,
			x = 7,
			y = 4
		},
		{
			direction = 1,
			x = 7,
			y = 3
		},
		{
			direction = 1,
			x = 9,
			y = 4
		},
		{
			direction = 1,
			x = 9,
			y = 3
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
					condition = 3,
					monsterIds = {
						13210501
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
					y = 8,
					tag = "",
					monsterId = 13210501,
					x = 7,
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
		[13210501] = {
			normalSkill = 1213215,
			name = "猎食者",
			pre_magicAtk = 54.6,
			maxHp = 56472.6,
			aiName = "boss_equipment_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 54.6,
			pre_meleeDef = 272,
			sanity = 0,
			remark = "装备本-中等BOSS1",
			giftSkill = 1213218,
			weakPointHpRate = 0.3,
			meleeDef = 272,
			level = 40,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 545.6,
			pre_meleeAtk = 545.6,
			pre_maxHp = 56472.6,
			colorType = 2,
			monsterType = 2,
			id = 13210501,
			mobility = 2,
			pre_magicDef = 135,
			aiStepOrder = 0,
			trumpSkill = 1213217,
			isFuzzy = false,
			inspire = 50,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 120017,
			magicDef = 135,
			specialSkill = 1213216,
			extraSkills = {
				1213224,
				1213220,
				1213222
			},
			attributeGrade = {
				"A",
				"A",
				"S",
				"C",
				"C"
			},
			tags = {
				"近战",
				"锥刺"
			}
		}
	}
}

return configData
