-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166340.lua

module("logic.config.leveleditor.t_level_config_166340", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166340",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 2,
	levelName = "新2教学20",
	lossConditionDesc = "",
	sceneId = "99000104",
	winConditionDesc = "首回合夹住敌人不攻击",
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
			x = 1,
			y = 0
		},
		{
			direction = 4,
			x = 7,
			y = 0
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
					y = 0,
					tag = "",
					monsterId = 16634001,
					x = 4,
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
			monsterId = 16634002,
			pos = {
				x = 1,
				y = 0
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 4,
			heroType = 2,
			monsterId = 16634003,
			pos = {
				x = 7,
				y = 0
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[16634001] = {
			normalSkill = 1740054,
			name = "迷雾使徒",
			pre_magicAtk = 82.6,
			maxHp = 365,
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
			meleeAtk = 226.4,
			pre_meleeAtk = 226.4,
			pre_maxHp = 365,
			colorType = 4,
			monsterType = 0,
			id = 16634001,
			mobility = 2,
			pre_magicDef = 32.5,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.9,
			camp = 1,
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
		[16634002] = {
			normalSkill = 1740006,
			name = "一云",
			pre_magicAtk = 74.9,
			maxHp = 124.1,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 74.9,
			pre_meleeDef = 48.2,
			sanity = -1,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 48.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 189.6,
			pre_meleeAtk = 189.6,
			pre_maxHp = 124.1,
			colorType = 1,
			monsterType = 0,
			id = 16634002,
			mobility = 4,
			pre_magicDef = 37.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22.4,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 22.4,
			modelId = 100011,
			magicDef = 37.8,
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
		[16634003] = {
			normalSkill = 1740010,
			name = "烟火",
			pre_magicAtk = 74.9,
			maxHp = 124.1,
			aiName = "auto_yanhuo_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 74.9,
			pre_meleeDef = 48.2,
			sanity = -1,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 48.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 189.6,
			pre_meleeAtk = 189.6,
			pre_maxHp = 124.1,
			colorType = 1,
			monsterType = 0,
			id = 16634003,
			mobility = 4,
			pre_magicDef = 37.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22.4,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 22.4,
			modelId = 100016,
			magicDef = 37.8,
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
