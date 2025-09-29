-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150040.lua

module("logic.config.leveleditor.t_level_config_150040", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150040",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面40",
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
			y = 6
		},
		{
			direction = 1,
			x = 7,
			y = 6
		},
		{
			direction = 1,
			x = 6,
			y = 6
		},
		{
			direction = 1,
			x = 9,
			y = 6
		},
		{
			direction = 1,
			x = 7,
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
					monsterId = 15004001,
					x = 7,
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
		[15004001] = {
			normalSkill = 1208701,
			name = "人生放映机",
			pre_magicAtk = 89.6,
			maxHp = 95793.7,
			aiName = "ai_蠕虫放映机",
			battleCamp = 1,
			career = 2,
			magicAtk = 89.6,
			pre_meleeDef = 414,
			sanity = 0,
			remark = "boss模板",
			giftSkill = 0,
			weakPointHpRate = 0.16,
			meleeDef = 414,
			level = 55,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 896.5,
			pre_meleeAtk = 896.5,
			pre_maxHp = 95793.7,
			colorType = 4,
			monsterType = 2,
			id = 15004001,
			mobility = 0,
			pre_magicDef = 237,
			aiStepOrder = 1,
			trumpSkill = 1208704,
			isFuzzy = false,
			inspire = 58,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 58,
			modelId = 120087,
			magicDef = 237,
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
		}
	}
}

return configData
