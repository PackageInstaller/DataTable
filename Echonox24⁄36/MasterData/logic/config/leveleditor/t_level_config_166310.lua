-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166310.lua

module("logic.config.leveleditor.t_level_config_166310", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166310",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新1教学10",
	lossConditionDesc = "",
	sceneId = "99000105",
	winConditionDesc = "利用克制完成弱点击破",
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
			x = 3,
			y = 2
		},
		{
			direction = 2,
			x = 3,
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
					monsterId = 16631001,
					x = 5,
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
			monsterId = 16631002,
			pos = {
				x = 3,
				y = 2
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16631003,
			pos = {
				x = 3,
				y = 1
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[16631001] = {
			normalSkill = 1740053,
			name = "迷雾使徒",
			pre_magicAtk = 12.1,
			maxHp = 243,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 12.1,
			pre_meleeDef = 61,
			sanity = 0,
			remark = "精英",
			giftSkill = 0,
			weakPointHpRate = 0.73,
			meleeDef = 10,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 120.7,
			pre_meleeAtk = 120.7,
			pre_maxHp = 763.8,
			colorType = 2,
			monsterType = 1,
			id = 16631001,
			mobility = 2,
			pre_magicDef = 34,
			aiStepOrder = 4,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 53,
			modelId = 120007,
			magicDef = 10,
			specialSkill = 0,
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
		[16631002] = {
			normalSkill = 1740047,
			name = "天文台调查员",
			pre_magicAtk = 9.4,
			maxHp = 434.1,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 9.4,
			pre_meleeDef = 61.2,
			sanity = -1,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 61.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 93.9,
			pre_meleeAtk = 93.9,
			pre_maxHp = 434.1,
			colorType = 1,
			monsterType = 0,
			id = 16631002,
			mobility = 4,
			pre_magicDef = 30.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 40,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 40,
			modelId = 120002,
			magicDef = 30.6,
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
		[16631003] = {
			normalSkill = 1740048,
			name = "天文台调查员",
			pre_magicAtk = 9.7,
			maxHp = 385.5,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 3,
			magicAtk = 9.7,
			pre_meleeDef = 54.9,
			sanity = -1,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 54.9,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 96.7,
			pre_meleeAtk = 96.7,
			pre_maxHp = 385.5,
			colorType = 3,
			monsterType = 0,
			id = 16631003,
			mobility = 2,
			pre_magicDef = 30.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 120003,
			magicDef = 30.6,
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
		}
	}
}

return configData
