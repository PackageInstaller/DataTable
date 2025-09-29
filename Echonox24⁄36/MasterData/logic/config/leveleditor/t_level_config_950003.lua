-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_950003.lua

module("logic.config.leveleditor.t_level_config_950003", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "950003",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "月岛-2",
	lossConditionDesc = "",
	sceneId = "108003",
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
			x = 6,
			y = 12
		},
		{
			direction = 2,
			x = 6,
			y = 11
		},
		{
			direction = 1,
			x = 8,
			y = 4
		},
		{
			direction = 1,
			x = 9,
			y = 4
		},
		{
			direction = 2,
			x = 5,
			y = 12
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
						95000302
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
			groupName = "怪物组1",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 95000305,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 95000303,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 95000301,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 95000301,
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
			form = 5,
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
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 95000302,
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
			refreshType = 2,
			form = 3,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "怪物组3",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 95000304,
					x = 10,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 95000304,
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
			refreshType = 2,
			form = 4,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "怪物组4",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 95000305,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 95000303,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 95000303,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 95000303,
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
		[95000301] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 1196.1,
			maxHp = 12115.1,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 1196.1,
			pre_meleeDef = 352.8,
			sanity = 0,
			remark = "绿特异小怪（主动攻击时触发超感；超感范围+1）",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 352.8,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 119.6,
			pre_meleeAtk = 119.6,
			pre_maxHp = 12115.1,
			colorType = 3,
			monsterType = 0,
			id = 95000301,
			mobility = 2,
			pre_magicDef = 510.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 85,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 85,
			modelId = 120029,
			magicDef = 510.3,
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
		[95000302] = {
			normalSkill = 1208801,
			name = "狂欢路灯",
			pre_magicAtk = 141.2,
			maxHp = 53185,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 141.2,
			pre_meleeDef = 567,
			sanity = 0,
			remark = "狙击精英（主动攻击后发动弧光）",
			giftSkill = 1208803,
			weakPointHpRate = 0.3,
			meleeDef = 567,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1411.5,
			pre_meleeAtk = 1411.5,
			pre_maxHp = 53185,
			colorType = 3,
			monsterType = 1,
			id = 95000302,
			mobility = 2,
			pre_magicDef = 392,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 88,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 88,
			modelId = 120088,
			magicDef = 392,
			specialSkill = 1208802,
			extraSkills = {},
			attributeGrade = {
				"S",
				"S",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[95000303] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 100,
			maxHp = 20807.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 100,
			pre_meleeDef = 586.8,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 586.8,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 999.8,
			pre_meleeAtk = 999.8,
			pre_maxHp = 20807.5,
			colorType = 2,
			monsterType = 0,
			id = 95000303,
			mobility = 2,
			pre_magicDef = 351,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65,
			modelId = 120028,
			magicDef = 351,
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
		[95000304] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 1484.8,
			maxHp = 45841.9,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 1484.8,
			pre_meleeDef = 426,
			sanity = 0,
			remark = "支援精英（行动结束时援护；援护强化）",
			giftSkill = 1203105,
			weakPointHpRate = 0.3,
			meleeDef = 426,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 148.5,
			pre_meleeAtk = 148.5,
			pre_maxHp = 45841.9,
			colorType = 4,
			monsterType = 1,
			id = 95000304,
			mobility = 2,
			pre_magicDef = 612,
			aiStepOrder = 0,
			trumpSkill = 1203104,
			isFuzzy = false,
			inspire = 68,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 68,
			modelId = 120031,
			magicDef = 612,
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
		},
		[95000305] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 111.4,
			maxHp = 75217.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 111.4,
			pre_meleeDef = 652,
			sanity = 0,
			remark = "守卫精英（受到攻击后触发振荡；振荡范围强化）",
			giftSkill = 1202802,
			weakPointHpRate = 0.3,
			meleeDef = 652,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1114.3,
			pre_meleeAtk = 1114.3,
			pre_maxHp = 75217.9,
			colorType = 2,
			monsterType = 1,
			id = 95000305,
			mobility = 2,
			pre_magicDef = 390,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 68,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 68,
			modelId = 120028,
			magicDef = 390,
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
		}
	}
}

return configData
