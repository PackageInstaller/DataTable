-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110308.lua

module("logic.config.leveleditor.t_level_config_110308", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110308",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通3-8",
	lossConditionDesc = "",
	sceneId = "112001",
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
			x = 4,
			y = 8
		},
		{
			direction = 2,
			x = 3,
			y = 7
		},
		{
			direction = 2,
			x = 4,
			y = 6
		},
		{
			direction = 2,
			x = 3,
			y = 5
		},
		{
			direction = 2,
			x = 3,
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
					condition = 3,
					monsterIds = {
						11030801
					}
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
			groupName = "伊丽莎白",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11030801,
					x = 11,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "伴随远程怪物",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 11030803,
					x = 11,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 11030803,
					x = 11,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11030802,
					x = 10,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "第一波远程怪物",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11030802,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11030802,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 11030803,
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
	lockHeroList = {},
	monsters = {
		[11030801] = {
			normalSkill = 1103901,
			name = "伊丽莎白",
			pre_magicAtk = 35.2,
			maxHp = 9543.2,
			aiName = "auto_attack_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 35.2,
			pre_meleeDef = 190.8,
			sanity = 0,
			remark = "",
			giftSkill = 1103904,
			weakPointHpRate = 0.3,
			meleeDef = 190.8,
			level = 27,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 352.2,
			pre_meleeAtk = 352.2,
			pre_maxHp = 9543.2,
			colorType = 1,
			monsterType = 0,
			id = 11030801,
			mobility = 4,
			pre_magicDef = 100.8,
			aiStepOrder = 0,
			trumpSkill = 1103903,
			isFuzzy = false,
			inspire = 52.1,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 52.1,
			modelId = 100039,
			magicDef = 100.8,
			specialSkill = 1103902,
			extraSkills = {
				1315003
			},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[11030802] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 35.3,
			maxHp = 1241.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 35.3,
			pre_meleeDef = 156.6,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 156.6,
			level = 27,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 352.8,
			pre_meleeAtk = 352.8,
			pre_maxHp = 1241.6,
			colorType = 3,
			monsterType = 0,
			id = 11030802,
			mobility = 2,
			pre_magicDef = 91.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.1,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.1,
			modelId = 120030,
			magicDef = 91.6,
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
		[11030803] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 390.1,
			maxHp = 1043.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 390.1,
			pre_meleeDef = 91.6,
			sanity = 0,
			remark = "红特异小怪（主动攻击时触发超感；超感范围+1）",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 91.6,
			level = 27,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 39,
			pre_meleeAtk = 39,
			pre_maxHp = 1043.3,
			colorType = 1,
			monsterType = 0,
			id = 11030803,
			mobility = 2,
			pre_magicDef = 156.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.1,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.1,
			modelId = 120029,
			magicDef = 156.6,
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
