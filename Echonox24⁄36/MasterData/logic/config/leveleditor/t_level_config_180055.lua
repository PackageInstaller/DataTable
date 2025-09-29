-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_180055.lua

module("logic.config.leveleditor.t_level_config_180055", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "180055",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "格里高列",
	lossConditionDesc = "",
	sceneId = "114001",
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
			y = 7
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
					DIYName = "击杀所有敌人",
					condition = 1,
					monsterIds = {}
				}
			}
		}
	},
	lossConditionList = {},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 18005502,
					x = 9,
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
			monsterId = 18005501,
			pos = {
				x = 5,
				y = 7
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[18005501] = {
			normalSkill = 1105501,
			name = "格里高列",
			pre_magicAtk = 194.4,
			maxHp = 414.5,
			aiName = "auto_support_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 194.4,
			pre_meleeDef = 42.9,
			sanity = 0,
			remark = "",
			giftSkill = 1105504,
			weakPointHpRate = 0,
			meleeDef = 42.9,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 39,
			pre_meleeAtk = 39,
			pre_maxHp = 414.5,
			colorType = 1,
			monsterType = 0,
			id = 18005501,
			mobility = 2,
			pre_magicDef = 78.3,
			aiStepOrder = 1,
			trumpSkill = 1105503,
			isFuzzy = false,
			inspire = 27.5,
			camp = 2,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 27.5,
			modelId = 100055,
			magicDef = 78.3,
			specialSkill = 1105502,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A"
			},
			tags = {}
		},
		[18005502] = {
			normalSkill = 1209801,
			name = "徘徊雨具",
			pre_magicAtk = 40,
			maxHp = 449.59,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 40,
			pre_meleeDef = 40.46,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 40.46,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 136.7,
			pre_meleeAtk = 136.7,
			pre_maxHp = 449.59,
			colorType = 2,
			monsterType = 0,
			id = 18005502,
			mobility = 2,
			pre_magicDef = 51.59,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 20.53,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 20.53,
			modelId = 120098,
			magicDef = 51.59,
			specialSkill = 0,
			extraSkills = {},
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
