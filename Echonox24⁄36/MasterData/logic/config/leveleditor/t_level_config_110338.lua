-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110338.lua

module("logic.config.leveleditor.t_level_config_110338", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "困难3-8",
	levelId = "110338",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "困难3-8",
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
			direction = 2,
			x = 10,
			y = 6
		},
		{
			direction = 2,
			x = 9,
			y = 6
		},
		{
			direction = 2,
			x = 7,
			y = 6
		},
		{
			direction = 3,
			x = 9,
			y = 4
		},
		{
			direction = 3,
			x = 8,
			y = 4
		},
		{
			direction = 3,
			x = 7,
			y = 4
		},
		{
			direction = 3,
			x = 10,
			y = 4
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
			form = 5,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组1",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 11033801,
					x = 8,
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
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 11033802,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 11033802,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 6,
					tag = "",
					monsterId = 11033802,
					x = 11,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组3",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 11033803,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 7,
					tag = "",
					monsterId = 11033803,
					x = 11,
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
			form = 2,
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
					y = 8,
					tag = "",
					monsterId = 11033804,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11033804,
					x = 10,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11033804,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11033804,
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
	lockHeroList = {},
	monsters = {
		[11033801] = {
			normalSkill = 1201401,
			name = "禁行隔离墩",
			pre_magicAtk = 45.9,
			maxHp = 21012.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 45.9,
			pre_meleeDef = 310,
			sanity = 0,
			remark = "守卫精英（受到攻击后获得1层[坚韧]）",
			giftSkill = 1201402,
			weakPointHpRate = 0.3,
			meleeDef = 310,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 459.3,
			pre_meleeAtk = 459.3,
			pre_maxHp = 21012.7,
			colorType = 2,
			monsterType = 1,
			id = 11033801,
			mobility = 2,
			pre_magicDef = 147,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 120014,
			magicDef = 147,
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
		[11033802] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 42,
			maxHp = 5867,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 42,
			pre_meleeDef = 279,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡,振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 279,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 420,
			pre_meleeAtk = 420,
			pre_maxHp = 5867,
			colorType = 2,
			monsterType = 0,
			id = 11033802,
			mobility = 2,
			pre_magicDef = 132.3,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 47,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 47,
			modelId = 120028,
			magicDef = 132.3,
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
		[11033803] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 471.1,
			maxHp = 3593.2,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 471.1,
			pre_meleeDef = 148.5,
			sanity = 0,
			remark = "支援小怪（行动结束时援护,援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 148.5,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 47.1,
			pre_meleeAtk = 47.1,
			pre_maxHp = 3593.2,
			colorType = 4,
			monsterType = 0,
			id = 11033803,
			mobility = 2,
			pre_magicDef = 258.3,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 47,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 47,
			modelId = 120031,
			magicDef = 258.3,
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
		[11033804] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 45,
			maxHp = 4190.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 45,
			pre_meleeDef = 234.9,
			sanity = 0,
			remark = "狙击小怪（弧光,弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 234.9,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 449.9,
			pre_meleeAtk = 449.9,
			pre_maxHp = 4190.4,
			colorType = 3,
			monsterType = 0,
			id = 11033804,
			mobility = 2,
			pre_magicDef = 133.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 67,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 67,
			modelId = 120030,
			magicDef = 133.2,
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
