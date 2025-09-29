-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110402.lua

module("logic.config.leveleditor.t_level_config_110402", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110402",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通4-2",
	lossConditionDesc = "",
	sceneId = "110002",
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
			y = 8
		},
		{
			direction = 1,
			x = 6,
			y = 8
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
		},
		{
			direction = 1,
			x = 4,
			y = 8
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
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 11040201,
					x = 10,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 11040201,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 11040201,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 11040201,
					x = 9,
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
			form = 5,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组2",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 11040203,
					x = 6,
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
			groupName = "怪物组3",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 11040202,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 10,
					tag = "",
					monsterId = 11040202,
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
	lockHeroList = {},
	monsters = {
		[11040201] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 49.2,
			maxHp = 2675.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 49.2,
			pre_meleeDef = 244.4,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 244.4,
			level = 42,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 491.5,
			pre_meleeAtk = 491.5,
			pre_maxHp = 2675.1,
			colorType = 1,
			monsterType = 0,
			id = 11040201,
			mobility = 4,
			pre_magicDef = 130,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55.8,
			modelId = 120089,
			magicDef = 130,
			specialSkill = 1208902,
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
		[11040202] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 572.2,
			maxHp = 1960.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 572.2,
			pre_meleeDef = 131.8,
			sanity = 0,
			remark = "红特异小怪（主动攻击时触发超感；超感范围+1）",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 131.8,
			level = 42,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 57.2,
			pre_meleeAtk = 57.2,
			pre_maxHp = 1960.5,
			colorType = 1,
			monsterType = 0,
			id = 11040202,
			mobility = 2,
			pre_magicDef = 222.7,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65.8,
			modelId = 120029,
			magicDef = 222.7,
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
		[11040203] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 51.5,
			maxHp = 17155.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 51.5,
			pre_meleeDef = 271.6,
			sanity = 0,
			remark = "幻影精英怪（主动攻击时追击；位移再动追击强化）",
			giftSkill = 1208905,
			weakPointHpRate = 0.3,
			meleeDef = 271.6,
			level = 42,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 515,
			pre_meleeAtk = 515,
			pre_maxHp = 17155.6,
			colorType = 1,
			monsterType = 1,
			id = 11040203,
			mobility = 4,
			pre_magicDef = 144.4,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 58.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 58.8,
			modelId = 120089,
			magicDef = 144.4,
			specialSkill = 1208904,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[11040204] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 625.7,
			maxHp = 12736.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 625.7,
			pre_meleeDef = 146.4,
			sanity = 0,
			remark = "红特异精英（主动攻击时触发强化超感；获得高昂）",
			giftSkill = 1202902,
			weakPointHpRate = 0.3,
			meleeDef = 146.4,
			level = 42,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 62.6,
			pre_meleeAtk = 62.6,
			pre_maxHp = 12736.5,
			colorType = 1,
			monsterType = 1,
			id = 11040204,
			mobility = 2,
			pre_magicDef = 247.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 68.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 68.8,
			modelId = 120029,
			magicDef = 247.4,
			specialSkill = 1202904,
			extraSkills = {},
			attributeGrade = {
				"S",
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
