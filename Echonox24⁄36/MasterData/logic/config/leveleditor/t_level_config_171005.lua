-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_171005.lua

module("logic.config.leveleditor.t_level_config_171005", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "新手引导用",
	levelId = "171005",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 20,
	levelName = "厄运预告5",
	lossConditionDesc = "",
	sceneId = "117004",
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
			y = 3
		},
		{
			direction = 1,
			x = 6,
			y = 3
		},
		{
			direction = 1,
			x = 8,
			y = 3
		},
		{
			direction = 1,
			x = 8,
			y = 4
		},
		{
			direction = 1,
			x = 6,
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
					monsterTag = "110",
					DIYName = "击杀厄运预告召唤的BOSS",
					condition = 12,
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
					y = 12,
					tag = "",
					monsterId = 17100501,
					x = 6,
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
			x = 6,
			y = 12
		}
	},
	lockHeroList = {},
	monsters = {
		[17100501] = {
			normalSkill = 0,
			name = "厄运预告",
			pre_magicAtk = 500,
			maxHp = 9999,
			aiName = "mob_stand_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 500,
			pre_meleeDef = 9999,
			sanity = 0,
			remark = "",
			giftSkill = 1217102,
			weakPointHpRate = 0,
			meleeDef = 9999,
			level = 99,
			monsterGroup = "",
			hasGodlike = false,
			meleeAtk = 500,
			pre_meleeAtk = 500,
			pre_maxHp = 9999,
			colorType = 4,
			monsterType = 0,
			id = 17100501,
			mobility = 0,
			pre_magicDef = 9999,
			aiStepOrder = 3,
			trumpSkill = 1217103,
			isFuzzy = false,
			inspire = 100,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 0,
			pre_inspire = 100,
			modelId = 120091,
			magicDef = 9999,
			specialSkill = 1217101,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"C",
				"C",
				"C"
			}
		}
	}
}

return configData
