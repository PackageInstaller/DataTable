-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_950002.lua

module("logic.config.leveleditor.t_level_config_950002", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "950002",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "月岛-1",
	lossConditionDesc = "",
	sceneId = "108001",
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
			x = 2,
			y = 3
		},
		{
			direction = 1,
			x = 3,
			y = 3
		},
		{
			direction = 1,
			x = 4,
			y = 3
		},
		{
			direction = 2,
			x = 2,
			y = 4
		},
		{
			direction = 2,
			x = 2,
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
					y = 6,
					tag = "",
					monsterId = 95000201,
					x = 3,
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
		[95000201] = {
			normalSkill = 1203201,
			name = "猎食者",
			pre_magicAtk = 137.3,
			maxHp = 251591.4,
			aiName = "boss_equipment_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 137.3,
			pre_meleeDef = 652,
			sanity = 0,
			remark = "数值验证关卡猎食者",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 652,
			level = 80,
			monsterGroup = "通用关卡",
			hasGodlike = false,
			meleeAtk = 1372.8,
			pre_meleeAtk = 1372.8,
			pre_maxHp = 251591.4,
			colorType = 2,
			monsterType = 2,
			id = 95000201,
			mobility = 2,
			pre_magicDef = 390,
			aiStepOrder = 0,
			trumpSkill = 1203203,
			isFuzzy = false,
			inspire = 70,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120017,
			magicDef = 390,
			specialSkill = 1203202,
			extraSkills = {},
			attributeGrade = {
				"A",
				"A",
				"S",
				"C",
				"C"
			}
		}
	}
}

return configData
