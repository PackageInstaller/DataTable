-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_171052.lua

module("logic.config.leveleditor.t_level_config_171052", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "171052",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 15,
	levelName = "尖叫鸡02",
	lossConditionDesc = "",
	sceneId = "930017",
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
			x = 5,
			y = 2
		},
		{
			direction = 1,
			x = 6,
			y = 2
		},
		{
			direction = 1,
			x = 4,
			y = 2
		},
		{
			direction = 1,
			x = 4,
			y = 3
		},
		{
			direction = 1,
			x = 7,
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
					y = 5,
					tag = "",
					monsterId = 17105201,
					x = 5,
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
		[17105201] = {
			normalSkill = 1208701,
			name = "人生放映机",
			pre_magicAtk = 45.3,
			maxHp = 35833.3,
			aiName = "mob_stand_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 45.3,
			pre_meleeDef = 234,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 234,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 453.2,
			pre_meleeAtk = 453.2,
			pre_maxHp = 35833.3,
			colorType = 2,
			monsterType = 0,
			id = 17105201,
			mobility = 0,
			pre_magicDef = 122,
			aiStepOrder = 0,
			trumpSkill = 1208704,
			isFuzzy = false,
			inspire = 45,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45,
			modelId = 120087,
			magicDef = 122,
			specialSkill = 1208702,
			extraSkills = {
				1208705
			},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
