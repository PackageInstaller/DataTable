-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_100001.lua

module("logic.config.leveleditor.t_level_config_100001", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "cpj：删除反击组",
	levelId = "100001",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "序章-1",
	lossConditionDesc = "",
	sceneId = "111002",
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
			y = 1
		},
		{
			direction = 1,
			x = 8,
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
					DIYName = "击杀所有密室原体",
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
			groupName = "黑伞-玩家操作打死",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 10000101,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 10000101,
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
			heroId = -1,
			direction = 1,
			heroType = 2,
			monsterId = 10000102,
			pos = {
				x = 5,
				y = 1
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = -1,
			direction = 1,
			heroType = 2,
			monsterId = 10000103,
			pos = {
				x = 8,
				y = 1
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[10000101] = {
			normalSkill = 1209801,
			name = "徘徊雨具",
			pre_magicAtk = 48.4,
			maxHp = 77,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 48.4,
			pre_meleeDef = 57.8,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 57.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 96.7,
			pre_meleeAtk = 96.7,
			pre_maxHp = 77,
			colorType = 1,
			monsterType = 0,
			id = 10000101,
			mobility = 4,
			pre_magicDef = 28.9,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 40,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 40,
			modelId = 120098,
			magicDef = 28.9,
			specialSkill = 0,
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
		[10000102] = {
			normalSkill = 1101101,
			name = "一云",
			pre_magicAtk = 41.5,
			maxHp = 800,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 41.5,
			pre_meleeDef = 84.1,
			sanity = 0,
			remark = "",
			giftSkill = 1101104,
			weakPointHpRate = 0,
			meleeDef = 84.1,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 152.3,
			pre_meleeAtk = 152.3,
			pre_maxHp = 800,
			colorType = 1,
			monsterType = 0,
			id = 10000102,
			mobility = 4,
			pre_magicDef = 34.8,
			aiStepOrder = 0,
			trumpSkill = 1101103,
			isFuzzy = false,
			inspire = 38.1,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.1,
			modelId = 100011,
			magicDef = 34.8,
			specialSkill = 1101102,
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
		[10000103] = {
			normalSkill = 1101601,
			name = "烟火",
			pre_magicAtk = 38,
			maxHp = 800,
			aiName = "auto_yanhuo_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 38,
			pre_meleeDef = 63.1,
			sanity = 0,
			remark = "",
			giftSkill = 1101604,
			weakPointHpRate = 0,
			meleeDef = 63.1,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 167.5,
			pre_meleeAtk = 167.5,
			pre_maxHp = 800,
			colorType = 1,
			monsterType = 0,
			id = 10000103,
			mobility = 4,
			pre_magicDef = 29.8,
			aiStepOrder = 0,
			trumpSkill = 1101603,
			isFuzzy = false,
			inspire = 38.8,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 38.8,
			modelId = 100016,
			magicDef = 29.8,
			specialSkill = 1101602,
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
