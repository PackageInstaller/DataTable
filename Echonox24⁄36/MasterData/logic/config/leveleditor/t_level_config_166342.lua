-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166342.lua

module("logic.config.leveleditor.t_level_config_166342", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166342",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新2教学22",
	lossConditionDesc = "",
	sceneId = "99000210",
	winConditionDesc = "振荡的不同触发",
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
			y = 2
		},
		{
			direction = 2,
			x = 0,
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
					y = 2,
					tag = "",
					monsterId = 16634203,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 16634203,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 16634203,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 16634203,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 16634203,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 16634203,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 16634203,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 16634203,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 16634203,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 16634203,
					x = 4,
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
			monsterId = 16634202,
			pos = {
				x = 0,
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
			monsterId = 16634201,
			pos = {
				x = 0,
				y = 0
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[16634201] = {
			normalSkill = 1740061,
			name = "伊丽莎白",
			pre_magicAtk = 10.5,
			maxHp = 266.6,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 10.5,
			pre_meleeDef = 57.6,
			sanity = -1,
			remark = "伊丽莎白",
			giftSkill = 1740064,
			weakPointHpRate = 0,
			meleeDef = 100,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 130,
			pre_meleeAtk = 104.8,
			pre_maxHp = 266.6,
			colorType = 1,
			monsterType = 0,
			id = 16634201,
			mobility = 4,
			pre_magicDef = 28.8,
			aiStepOrder = 0,
			trumpSkill = 1740063,
			isFuzzy = false,
			inspire = 35.5,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 35.5,
			modelId = 100039,
			magicDef = 28.8,
			specialSkill = 1740062,
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
		[16634202] = {
			normalSkill = 1740031,
			name = "安布蕾拉",
			pre_magicAtk = 10.2,
			maxHp = 330.3,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 2,
			magicAtk = 10.2,
			pre_meleeDef = 62.4,
			sanity = -1,
			remark = "安布蕾拉",
			giftSkill = 1740033,
			weakPointHpRate = 0,
			meleeDef = 62.4,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 101.8,
			pre_meleeAtk = 101.8,
			pre_maxHp = 330.3,
			colorType = 2,
			monsterType = 0,
			id = 16634202,
			mobility = 2,
			pre_magicDef = 28.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 25.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 25.5,
			modelId = 100020,
			magicDef = 28.8,
			specialSkill = 1740032,
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
		[16634203] = {
			normalSkill = 1740056,
			name = "惑形/蜉蝣",
			pre_magicAtk = 96.2,
			maxHp = 100,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 300,
			pre_meleeDef = 24,
			sanity = 0,
			remark = "红特异小怪（主动攻击时触发超感；超感范围+1）",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 24,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 9.6,
			pre_meleeAtk = 9.6,
			pre_maxHp = 161.3,
			colorType = 1,
			monsterType = 0,
			id = 16634203,
			mobility = 2,
			pre_magicDef = 42.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 42.5,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 42.5,
			modelId = 120029,
			magicDef = 42.4,
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
		}
	}
}

return configData
