-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130794.lua

module("logic.config.leveleditor.t_level_config_130794", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "130794",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "陨灭材料本-94",
	lossConditionDesc = "",
	sceneId = "130702",
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
			x = 1,
			y = 7
		},
		{
			direction = 2,
			x = 4,
			y = 10
		},
		{
			direction = 2,
			x = 8,
			y = 11
		},
		{
			direction = 2,
			x = 8,
			y = 5
		},
		{
			direction = 2,
			x = 11,
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
					DIYName = "来袭所有敌人全灭",
					condition = 1,
					monsterIds = {
						13079403
					}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 2,
			maxDeadCount = 0,
			count = 0,
			hasTag = false,
			DIYName = "守卫装置被破坏",
			isBackup = false,
			tag = "",
			targetId = 13079404,
			monsterIds = {}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "保护",
			refreshType = 1,
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = true,
			groupName = "保护友方目标",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 13079401,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "进攻怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 13079402,
					x = 0,
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
			y = 7
		}
	},
	lockHeroList = {},
	monsters = {
		[13079402] = {
			normalSkill = 0,
			name = "徘徊者",
			pre_magicAtk = 134,
			maxHp = 80,
			aiName = "ai-陨灭本-1.2",
			battleCamp = 1,
			career = 1,
			magicAtk = 134,
			pre_meleeDef = 21,
			sanity = 0,
			remark = "",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 21,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 53,
			pre_meleeAtk = 53,
			pre_maxHp = 80,
			colorType = 1,
			monsterType = 0,
			id = 13079402,
			mobility = 4,
			pre_magicDef = 41.2,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 23,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 23,
			modelId = 120097,
			magicDef = 41.2,
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
		[13079403] = {
			normalSkill = 1223101,
			name = "仪式负责人",
			pre_magicAtk = 9.7,
			maxHp = 771,
			aiName = "ai-幻影本-刺杀目标1",
			battleCamp = 1,
			career = 3,
			magicAtk = 9.7,
			pre_meleeDef = 30.6,
			sanity = 0,
			remark = "",
			giftSkill = 1223102,
			weakPointHpRate = 0.3,
			meleeDef = 30.6,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 96.7,
			pre_meleeAtk = 96.7,
			pre_maxHp = 771,
			colorType = 3,
			monsterType = 1,
			id = 13079403,
			mobility = 2,
			pre_magicDef = 54.9,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 120047,
			magicDef = 54.9,
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
		},
		[13079404] = {
			normalSkill = 0,
			name = "徘徊者",
			pre_magicAtk = 134,
			maxHp = 80,
			aiName = "ai-陨灭本-1.1",
			battleCamp = 1,
			career = 1,
			magicAtk = 134,
			pre_meleeDef = 21,
			sanity = 0,
			remark = "",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 21,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 53,
			pre_meleeAtk = 53,
			pre_maxHp = 80,
			colorType = 1,
			monsterType = 0,
			id = 13079404,
			mobility = 4,
			pre_magicDef = 41.2,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 23,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 23,
			modelId = 120097,
			magicDef = 41.2,
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
