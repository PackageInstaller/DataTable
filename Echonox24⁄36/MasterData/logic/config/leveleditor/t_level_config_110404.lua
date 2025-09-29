-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110404.lua

module("logic.config.leveleditor.t_level_config_110404", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110404",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通4-4",
	lossConditionDesc = "",
	sceneId = "111003",
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
			y = 1
		},
		{
			direction = 1,
			x = 7,
			y = 1
		},
		{
			direction = 1,
			x = 8,
			y = 1
		},
		{
			direction = 1,
			x = 5,
			y = 1
		},
		{
			direction = 1,
			x = 9,
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
					y = 5,
					tag = "",
					monsterId = 11040404,
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
			form = 2,
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
					y = 6,
					tag = "",
					monsterId = 11040403,
					x = 11,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 11040403,
					x = 11,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11040403,
					x = 3,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 11040403,
					x = 3,
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
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 11040402,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 11040402,
					x = 5,
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
			groupName = "怪物组4",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 4,
					tag = "",
					monsterId = 11040401,
					x = 7,
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
		[11040401] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 58.7,
			maxHp = 15854.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 58.7,
			pre_meleeDef = 256.6,
			sanity = 0,
			remark = "狙击精英（弧光额外弹射3次）",
			giftSkill = 1203002,
			weakPointHpRate = 0.3,
			meleeDef = 256.6,
			level = 43,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 586.9,
			pre_meleeAtk = 586.9,
			pre_maxHp = 15854.6,
			colorType = 3,
			monsterType = 1,
			id = 11040401,
			mobility = 2,
			pre_magicDef = 151.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 69.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 69.2,
			modelId = 120030,
			magicDef = 151.6,
			specialSkill = 1203003,
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
		[11040402] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 53.2,
			maxHp = 2446.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 53.2,
			pre_meleeDef = 230.9,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 230.9,
			level = 43,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 532.4,
			pre_meleeAtk = 532.4,
			pre_maxHp = 2446.7,
			colorType = 3,
			monsterType = 0,
			id = 11040402,
			mobility = 2,
			pre_magicDef = 136.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 66.2,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 66.2,
			modelId = 120030,
			magicDef = 136.4,
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
		[11040403] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 590.1,
			maxHp = 2055.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 590.1,
			pre_meleeDef = 136.4,
			sanity = 0,
			remark = "红特异小怪（主动攻击触发超感）",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 136.4,
			level = 43,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 59,
			pre_meleeAtk = 59,
			pre_maxHp = 2055.8,
			colorType = 1,
			monsterType = 0,
			id = 11040403,
			mobility = 2,
			pre_magicDef = 230.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 66.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 66.2,
			modelId = 120068,
			magicDef = 230.9,
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
		[11040404] = {
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
			id = 11040404,
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
		[11040405] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 645,
			maxHp = 13321.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 645,
			pre_meleeDef = 151.6,
			sanity = 0,
			remark = "红特异精英（主动攻击触发超感；超感强化）",
			giftSkill = 1206802,
			weakPointHpRate = 0.3,
			meleeDef = 151.6,
			level = 43,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 64.5,
			pre_meleeAtk = 64.5,
			pre_maxHp = 13321.6,
			colorType = 1,
			monsterType = 1,
			id = 11040405,
			mobility = 2,
			pre_magicDef = 256.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 69.2,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 69.2,
			modelId = 120068,
			magicDef = 256.6,
			specialSkill = 1206803,
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
		[11040406] = {
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
			id = 11040406,
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
