-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_940002.lua

module("logic.config.leveleditor.t_level_config_940002", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "结算测试用",
	levelId = "940002",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "怪物测试用",
	lossConditionDesc = "",
	sceneId = "99000101",
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
			x = 5,
			y = 2
		},
		{
			direction = 2,
			x = 5,
			y = 3
		},
		{
			direction = 2,
			x = 5,
			y = 4
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
					y = 3,
					tag = "",
					monsterId = 94000201,
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
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 94000202,
			pos = {
				x = 5,
				y = 4
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 94000202,
			pos = {
				x = 5,
				y = 3
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 94000202,
			pos = {
				x = 5,
				y = 2
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[94000201] = {
			normalSkill = 1200801,
			name = "迷雾使徒",
			pre_magicAtk = 82.6,
			maxHp = 340,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 82.6,
			pre_meleeDef = 43,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 43,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 240,
			pre_meleeAtk = 240,
			pre_maxHp = 340,
			colorType = 3,
			monsterType = 0,
			id = 94000201,
			mobility = 2,
			pre_magicDef = 32.5,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.9,
			camp = 0,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 120008,
			magicDef = 32.5,
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
		[94000202] = {
			normalSkill = 1200801,
			name = "迷雾使徒",
			pre_magicAtk = 82.6,
			maxHp = 340,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 3,
			magicAtk = 82.6,
			pre_meleeDef = 43,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 43,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 240,
			pre_meleeAtk = 240,
			pre_maxHp = 340,
			colorType = 3,
			monsterType = 0,
			id = 94000202,
			mobility = 2,
			pre_magicDef = 32.5,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.9,
			camp = 0,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 120008,
			magicDef = 32.5,
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
