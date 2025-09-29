-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166314.lua

module("logic.config.leveleditor.t_level_config_166314", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166314",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 2,
	levelName = "新1教学14",
	lossConditionDesc = "",
	sceneId = "99000109",
	winConditionDesc = "利用锁定远距离击杀",
	forbidAction = {
		auto = true,
		move = false,
		strengthenSkill = true,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 2,
			x = 3,
			y = 1
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
			condition = 3,
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
					y = 1,
					tag = "",
					monsterId = 16631402,
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
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16631401,
			pos = {
				x = 3,
				y = 1
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[16631401] = {
			normalSkill = 1740026,
			name = "飞鸟",
			pre_magicAtk = 9.4,
			maxHp = 200,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 9.4,
			pre_meleeDef = 61.2,
			sanity = -1,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 61.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 93.9,
			pre_meleeAtk = 93.9,
			pre_maxHp = 434.1,
			colorType = 3,
			monsterType = 0,
			id = 16631401,
			mobility = 2,
			pre_magicDef = 30.6,
			aiStepOrder = 0,
			trumpSkill = 1740027,
			isFuzzy = false,
			inspire = 40,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 40,
			modelId = 100022,
			magicDef = 30.6,
			specialSkill = 0,
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
		[16631402] = {
			normalSkill = 1740050,
			name = "迷雾使徒",
			pre_magicAtk = 7.9,
			maxHp = 120,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 7.9,
			pre_meleeDef = 47.7,
			sanity = 0,
			remark = "陨灭小怪模板",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 17,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 300,
			pre_meleeAtk = 78.6,
			pre_maxHp = 291.4,
			colorType = 4,
			monsterType = 0,
			id = 16631402,
			mobility = 1,
			pre_magicDef = 31.5,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 37,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 37,
			modelId = 120010,
			magicDef = 31.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
