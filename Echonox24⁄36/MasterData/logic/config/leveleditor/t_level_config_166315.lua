-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166315.lua

module("logic.config.leveleditor.t_level_config_166315", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166315",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 2,
	levelName = "新1教学15",
	lossConditionDesc = "",
	sceneId = "99000112",
	winConditionDesc = "利用陨灭移动特性",
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
			x = 0,
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
					monsterId = 16631501,
					x = 6,
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
			monsterId = 16631502,
			pos = {
				x = 0,
				y = 1
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[16631501] = {
			normalSkill = 1740050,
			name = "迷雾使徒",
			pre_magicAtk = 10.7,
			maxHp = 99,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 10.7,
			pre_meleeDef = 54.4,
			sanity = 0,
			remark = "陨灭小怪模板",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 54.4,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 300,
			pre_meleeAtk = 106.6,
			pre_maxHp = 253.6,
			colorType = 4,
			monsterType = 0,
			id = 16631501,
			mobility = 1,
			pre_magicDef = 36,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35.5,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35.5,
			modelId = 120010,
			magicDef = 36,
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
		[16631502] = {
			normalSkill = 1740010,
			name = "烟火",
			pre_magicAtk = 10.5,
			maxHp = 99,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 10.5,
			pre_meleeDef = 57.6,
			sanity = -1,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 57.6,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 200,
			pre_meleeAtk = 104.8,
			pre_maxHp = 285.2,
			colorType = 1,
			monsterType = 0,
			id = 16631502,
			mobility = 4,
			pre_magicDef = 28.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 35.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35.5,
			modelId = 100016,
			magicDef = 28.8,
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
