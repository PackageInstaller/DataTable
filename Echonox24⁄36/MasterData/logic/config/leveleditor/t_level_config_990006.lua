-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_990006.lua

module("logic.config.leveleditor.t_level_config_990006", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "990006",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 99,
	levelName = "测试-战前UI",
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
			direction = 1,
			x = 6,
			y = 11
		},
		{
			direction = 1,
			x = 7,
			y = 8
		},
		{
			direction = 3,
			x = 8,
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
					condition = 3,
					monsterIds = {
						99000604
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
			DIYName = "",
			isBackup = false,
			tag = "",
			targetId = 99000601,
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
			groupName = "击杀标识",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 99000604,
					x = 7,
					initialStatus = {
						hpPercent = 0.01,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "保护标识、支援标识",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 9,
					tag = "",
					monsterId = 99000601,
					x = 6,
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
			groupName = "小型以太晶石",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 99000602,
					x = 7,
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
			heroId = 2000053,
			direction = 1,
			heroType = 2,
			monsterId = 20010603,
			pos = {
				x = 7,
				y = 8
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[99000601] = {
			normalSkill = 1209901,
			name = "阿妮亚(伪）",
			pre_magicAtk = 0,
			maxHp = 0,
			aiName = "auto_waitforhelp_ai",
			battleCamp = 3,
			career = 6,
			magicAtk = 0,
			pre_meleeDef = 0,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 0,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 0,
			pre_maxHp = 0,
			colorType = 4,
			monsterType = 0,
			id = 99000601,
			mobility = 2,
			pre_magicDef = 0,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 0,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 100053,
			magicDef = 0,
			specialSkill = 1209903,
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
		[99000602] = {
			normalSkill = 1202601,
			name = "伴生以太水晶",
			pre_magicAtk = 129,
			maxHp = 5300,
			aiName = "ai-不朽-序章",
			battleCamp = 1,
			career = 4,
			magicAtk = 129,
			pre_meleeDef = 32.5,
			sanity = 0,
			remark = "",
			giftSkill = 1202607,
			weakPointHpRate = 0,
			meleeDef = 32.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 51.6,
			pre_meleeAtk = 51.6,
			pre_maxHp = 5300,
			colorType = 2,
			monsterType = 2,
			id = 99000602,
			mobility = 0,
			pre_magicDef = 51.6,
			aiStepOrder = 0,
			trumpSkill = 1202603,
			isFuzzy = false,
			inspire = 26.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 120084,
			magicDef = 51.6,
			specialSkill = 1202602,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		},
		[99000603] = {
			normalSkill = 1105301,
			name = "阿妮亚",
			pre_magicAtk = 169,
			maxHp = 213.8,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 169,
			pre_meleeDef = 59.8,
			sanity = 0,
			remark = "",
			giftSkill = 1105304,
			weakPointHpRate = 0,
			meleeDef = 59.8,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 81.6,
			pre_meleeAtk = 81.6,
			pre_maxHp = 213.8,
			colorType = 4,
			monsterType = 0,
			id = 99000603,
			mobility = 2,
			pre_magicDef = 78.2,
			aiStepOrder = 0,
			trumpSkill = 1105303,
			isFuzzy = false,
			inspire = 20.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 20.9,
			modelId = 100053,
			magicDef = 78.2,
			specialSkill = 1105302,
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
		[99000604] = {
			normalSkill = 1101101,
			name = "一云",
			pre_magicAtk = 118.1,
			maxHp = 672.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 118.1,
			pre_meleeDef = 64.8,
			sanity = 0,
			remark = "",
			giftSkill = 1101104,
			weakPointHpRate = 0,
			meleeDef = 64.8,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 300,
			pre_meleeAtk = 300,
			pre_maxHp = 672.6,
			colorType = 1,
			monsterType = 0,
			id = 99000604,
			mobility = 3,
			pre_magicDef = 59.8,
			aiStepOrder = 3,
			trumpSkill = 1101103,
			isFuzzy = false,
			inspire = 26.4,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.4,
			modelId = 100011,
			magicDef = 59.8,
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
		}
	}
}

return configData
