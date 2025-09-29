-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110214.lua

module("logic.config.leveleditor.t_level_config_110214", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110214",
	plotEventGroup = 110214,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通2-14",
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
			direction = 2,
			x = 5,
			y = 5
		},
		{
			direction = 2,
			x = 5,
			y = 4
		},
		{
			direction = 2,
			x = 5,
			y = 3
		},
		{
			direction = 2,
			x = 5,
			y = 6
		},
		{
			direction = 2,
			x = 4,
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
			groupName = "本体",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 11021401,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "101",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = true,
			groupName = "左右手",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "101",
					monsterId = 11021402,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "102",
					monsterId = 11021403,
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
			y = 2
		}
	},
	lockHeroList = {},
	monsters = {
		[11021401] = {
			normalSkill = 1203801,
			name = "嵌合电话亭",
			pre_magicAtk = 29,
			maxHp = 4791,
			aiName = "ai_蔑视本体",
			battleCamp = 1,
			career = 2,
			magicAtk = 29,
			pre_meleeDef = 141,
			sanity = 0,
			remark = "",
			giftSkill = 1203804,
			weakPointHpRate = 0,
			meleeDef = 141,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 290.4,
			pre_meleeAtk = 290.4,
			pre_maxHp = 28689.9,
			colorType = 2,
			monsterType = 2,
			id = 11021401,
			mobility = 0,
			pre_magicDef = 76,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 41,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 41,
			modelId = 120038,
			magicDef = 76,
			specialSkill = 1203802,
			extraSkills = {},
			attributeGrade = {
				"A",
				"A",
				"S",
				"C",
				"C"
			},
			tags = {}
		},
		[11021402] = {
			normalSkill = 1203811,
			name = "左位嵌合装置",
			pre_magicAtk = 19.6,
			maxHp = 2100,
			aiName = "",
			battleCamp = 1,
			career = 1,
			magicAtk = 19.6,
			pre_meleeDef = 117.9,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 117.9,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 196.4,
			pre_meleeAtk = 196.4,
			pre_maxHp = 1311.2,
			colorType = 1,
			monsterType = 0,
			id = 11021402,
			mobility = 0,
			pre_magicDef = 68.4,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 46,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 46,
			modelId = 120128,
			magicDef = 68.4,
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
		[11021403] = {
			normalSkill = 1203812,
			name = "右位嵌合装置",
			pre_magicAtk = 19.6,
			maxHp = 2100,
			aiName = "",
			battleCamp = 1,
			career = 1,
			magicAtk = 19.6,
			pre_meleeDef = 117.9,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 117.9,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 196.4,
			pre_meleeAtk = 196.4,
			pre_maxHp = 1311.2,
			colorType = 1,
			monsterType = 0,
			id = 11021403,
			mobility = 0,
			pre_magicDef = 68.4,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 46,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 46,
			modelId = 120129,
			magicDef = 68.4,
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
