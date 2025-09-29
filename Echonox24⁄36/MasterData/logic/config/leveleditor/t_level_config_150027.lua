-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150027.lua

module("logic.config.leveleditor.t_level_config_150027", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150027",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面27",
	lossConditionDesc = "",
	sceneId = "111001",
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
			x = 8,
			y = 10
		},
		{
			direction = 2,
			x = 8,
			y = 9
		},
		{
			direction = 2,
			x = 8,
			y = 11
		},
		{
			direction = 3,
			x = 4,
			y = 7
		},
		{
			direction = 3,
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
					y = 14,
					tag = "",
					monsterId = 15002703,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 15002702,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15002701,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 15002701,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 15002701,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 15002701,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 4,
			y = 5
		}
	},
	lockHeroList = {},
	monsters = {
		[15002701] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 47.1,
			maxHp = 3282.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 47.1,
			pre_meleeDef = 263.5,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 263.5,
			level = 42,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 471.2,
			pre_meleeAtk = 471.2,
			pre_maxHp = 3282.6,
			colorType = 2,
			monsterType = 0,
			id = 15002701,
			mobility = 2,
			pre_magicDef = 130.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 45.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.8,
			modelId = 120028,
			magicDef = 130.9,
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
		},
		[15002702] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 547.7,
			maxHp = 2005,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 547.7,
			pre_meleeDef = 146,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 146,
			level = 42,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 54.7,
			pre_meleeAtk = 54.7,
			pre_maxHp = 2005,
			colorType = 4,
			monsterType = 0,
			id = 15002702,
			mobility = 2,
			pre_magicDef = 244.4,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 45.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.8,
			modelId = 120031,
			magicDef = 244.4,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		},
		[15002703] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 55.4,
			maxHp = 12833.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 55.4,
			pre_meleeDef = 258.8,
			sanity = 0,
			remark = "陨灭精英（具有3层及以上的轰鸣时；主动攻击必定暴击；暴伤提升）",
			giftSkill = 1206903,
			weakPointHpRate = 0.3,
			meleeDef = 258.8,
			level = 42,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 554.3,
			pre_meleeAtk = 554.3,
			pre_maxHp = 12833.4,
			colorType = 4,
			monsterType = 1,
			id = 15002703,
			mobility = 1,
			pre_magicDef = 171.2,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58.8,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 58.8,
			modelId = 120069,
			magicDef = 171.2,
			specialSkill = 1206902,
			extraSkills = {
				1206904
			},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"B"
			},
			tags = {}
		}
	}
}

return configData
