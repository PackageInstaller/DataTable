-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_132209.lua

module("logic.config.leveleditor.t_level_config_132209", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "132209",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "装备本2-9",
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
			x = 6,
			y = 7
		},
		{
			direction = 1,
			x = 5,
			y = 6
		},
		{
			direction = 1,
			x = 7,
			y = 6
		},
		{
			direction = 1,
			x = 8,
			y = 7
		},
		{
			direction = 1,
			x = 8,
			y = 6
		},
		{
			direction = 1,
			x = 5,
			y = 7
		},
		{
			direction = 1,
			x = 7,
			y = 7
		},
		{
			direction = 1,
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
					DIYName = "",
					condition = 3,
					monsterIds = {
						13220901
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "小怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 13220901,
					x = 6,
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
		[13220901] = {
			normalSkill = 1207801,
			name = "拟态/二重幻影",
			pre_magicAtk = 1569.7,
			maxHp = 145771.2,
			aiName = "boss02_equipment_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 1569.7,
			pre_meleeDef = 392,
			sanity = 0,
			remark = "",
			giftSkill = 1207823,
			weakPointHpRate = 0.19,
			meleeDef = 392,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 157,
			pre_meleeAtk = 157,
			pre_maxHp = 145771.2,
			colorType = 1,
			monsterType = 2,
			id = 13220901,
			mobility = 8,
			pre_magicDef = 567,
			aiStepOrder = 0,
			trumpSkill = 1207804,
			isFuzzy = false,
			inspire = 90,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 120078,
			magicDef = 567,
			specialSkill = 0,
			extraSkills = {
				1207811,
				1207812,
				1207816
			},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {
				"瞬移",
				"远程",
				"超感"
			}
		}
	}
}

return configData
