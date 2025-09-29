-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150028.lua

module("logic.config.leveleditor.t_level_config_150028", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150028",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面28",
	lossConditionDesc = "",
	sceneId = "109003",
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
			x = 6,
			y = 9
		},
		{
			direction = 1,
			x = 7,
			y = 9
		},
		{
			direction = 1,
			x = 8,
			y = 9
		},
		{
			direction = 1,
			x = 7,
			y = 8
		},
		{
			direction = 1,
			x = 8,
			y = 8
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1005,
			times = 5,
			posList = {
				{
					x = 6,
					y = 13
				},
				{
					x = 6,
					y = 12
				}
			}
		}
	},
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
					condition = 6,
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
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15002801,
					x = 6,
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
					monsterId = 15002801,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 15002801,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15002801,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15002803,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组2",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15002802,
					x = 5,
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
					monsterId = 15002804,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[15002801] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 48.7,
			maxHp = 3444.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 48.7,
			pre_meleeDef = 272.9,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 272.9,
			level = 43,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 486.4,
			pre_meleeAtk = 486.4,
			pre_maxHp = 3444.9,
			colorType = 2,
			monsterType = 0,
			id = 15002801,
			mobility = 2,
			pre_magicDef = 135.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 46.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 46.2,
			modelId = 120028,
			magicDef = 135.5,
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
		[15002802] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 565,
			maxHp = 2103.5,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 565,
			pre_meleeDef = 151,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 151,
			level = 43,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 56.5,
			pre_meleeAtk = 56.5,
			pre_maxHp = 2103.5,
			colorType = 4,
			monsterType = 0,
			id = 15002802,
			mobility = 2,
			pre_magicDef = 253.3,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 46.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 46.2,
			modelId = 120031,
			magicDef = 253.3,
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
		[15002803] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 47.3,
			maxHp = 21751.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 47.3,
			pre_meleeDef = 303.2,
			sanity = 0,
			remark = "守卫精英（受到攻击后触发振荡；振荡范围强化）",
			giftSkill = 1202802,
			weakPointHpRate = 0.3,
			meleeDef = 303.2,
			level = 43,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 473.4,
			pre_meleeAtk = 473.4,
			pre_maxHp = 21751.7,
			colorType = 2,
			monsterType = 1,
			id = 15002803,
			mobility = 2,
			pre_magicDef = 150.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 49.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 49.2,
			modelId = 120028,
			magicDef = 150.6,
			specialSkill = 1202803,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		},
		[15002804] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 614.9,
			maxHp = 11213.2,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 614.9,
			pre_meleeDef = 167.8,
			sanity = 0,
			remark = "支援精英（行动结束时援护；援护强化）",
			giftSkill = 1203105,
			weakPointHpRate = 0.3,
			meleeDef = 167.8,
			level = 43,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 61.5,
			pre_meleeAtk = 61.5,
			pre_maxHp = 11213.2,
			colorType = 4,
			monsterType = 1,
			id = 15002804,
			mobility = 2,
			pre_magicDef = 281.4,
			aiStepOrder = 0,
			trumpSkill = 1203104,
			isFuzzy = false,
			inspire = 49.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 49.2,
			modelId = 120031,
			magicDef = 281.4,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		}
	}
}

return configData
