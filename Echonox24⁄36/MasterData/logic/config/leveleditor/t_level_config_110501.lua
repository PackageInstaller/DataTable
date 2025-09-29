-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110501.lua

module("logic.config.leveleditor.t_level_config_110501", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110501",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通5-1",
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
			y = 6
		},
		{
			direction = 1,
			x = 6,
			y = 6
		},
		{
			direction = 1,
			x = 7,
			y = 6
		},
		{
			direction = 1,
			x = 4,
			y = 6
		},
		{
			direction = 4,
			x = 5,
			y = 5
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
					direction = 2,
					y = 4,
					tag = "",
					monsterId = 11050101,
					x = 1,
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
			groupName = "怪物组2",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 11050102,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 11050102,
					x = 4,
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
					monsterId = 11050103,
					x = 6,
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
					monsterId = 11050103,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 4,
					tag = "",
					monsterId = 11050103,
					x = 2,
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
			groupName = "怪物组4",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 11050106,
					x = 1,
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
		[11050101] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 698.8,
			maxHp = 2972.3,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 698.8,
			pre_meleeDef = 193.9,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 193.9,
			level = 51,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 69.9,
			pre_meleeAtk = 69.9,
			pre_maxHp = 2972.3,
			colorType = 4,
			monsterType = 0,
			id = 11050101,
			mobility = 2,
			pre_magicDef = 297.2,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 50.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 50.6,
			modelId = 120031,
			magicDef = 297.2,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[11050102] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 59.7,
			maxHp = 4897.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 59.7,
			pre_meleeDef = 319.3,
			sanity = 0,
			remark = "守卫小怪（受到攻击后锥刺）",
			giftSkill = 1201402,
			weakPointHpRate = 0,
			meleeDef = 319.3,
			level = 51,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 596.5,
			pre_meleeAtk = 596.5,
			pre_maxHp = 4897.7,
			colorType = 2,
			monsterType = 0,
			id = 11050102,
			mobility = 2,
			pre_magicDef = 174.4,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50.6,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 50.6,
			modelId = 120014,
			magicDef = 174.4,
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
		[11050103] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 731.4,
			maxHp = 2884.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 731.4,
			pre_meleeDef = 175.3,
			sanity = 0,
			remark = "红特异小怪（主动攻击时触发超感；超感范围+1）",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 175.3,
			level = 51,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 73.1,
			pre_meleeAtk = 73.1,
			pre_maxHp = 2884.6,
			colorType = 1,
			monsterType = 0,
			id = 11050103,
			mobility = 2,
			pre_magicDef = 272.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 70.6,
			modelId = 120029,
			magicDef = 272.3,
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
		[11050104] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 59.7,
			maxHp = 4897.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 59.7,
			pre_meleeDef = 319.3,
			sanity = 0,
			remark = "守卫小怪（反击后触发振荡）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 319.3,
			level = 51,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 596.5,
			pre_meleeAtk = 596.5,
			pre_maxHp = 4897.7,
			colorType = 2,
			monsterType = 0,
			id = 11050104,
			mobility = 2,
			pre_magicDef = 174.4,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 50.6,
			modelId = 120090,
			magicDef = 174.4,
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
		[11050105] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 58,
			maxHp = 30672.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 58,
			pre_meleeDef = 354.8,
			sanity = 0,
			remark = "守卫精英（受到攻击后获得1层[坚韧]）",
			giftSkill = 1201402,
			weakPointHpRate = 0.3,
			meleeDef = 354.8,
			level = 51,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 579.6,
			pre_meleeAtk = 579.6,
			pre_maxHp = 30672.7,
			colorType = 2,
			monsterType = 1,
			id = 11050105,
			mobility = 2,
			pre_magicDef = 193.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53.6,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 53.6,
			modelId = 120014,
			magicDef = 193.8,
			specialSkill = 1201404,
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
		[11050106] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 58,
			maxHp = 30672.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 58,
			pre_meleeDef = 354.8,
			sanity = 0,
			remark = "守卫精英（振荡2次；范围变大）",
			giftSkill = 1209002,
			weakPointHpRate = 0.3,
			meleeDef = 354.8,
			level = 51,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 579.6,
			pre_meleeAtk = 579.6,
			pre_maxHp = 30672.7,
			colorType = 2,
			monsterType = 1,
			id = 11050106,
			mobility = 2,
			pre_magicDef = 193.8,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 53.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 53.6,
			modelId = 120090,
			magicDef = 193.8,
			specialSkill = 1209003,
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
