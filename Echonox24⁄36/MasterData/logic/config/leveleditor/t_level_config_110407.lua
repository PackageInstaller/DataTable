-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110407.lua

module("logic.config.leveleditor.t_level_config_110407", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "",
	levelId = "110407",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通4-7",
	lossConditionDesc = "",
	sceneId = "112003",
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
			direction = 4,
			x = 5,
			y = 5
		},
		{
			direction = 2,
			x = 7,
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
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 11040704,
					x = 5,
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
					monsterId = 11040704,
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
					monsterId = 11040704,
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
			form = 2,
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
					y = 5,
					tag = "",
					monsterId = 11040703,
					x = 10,
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
					monsterId = 11040703,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组3",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 11040702,
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
			groupName = "怪物组4",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 8,
					tag = "",
					monsterId = 11040701,
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
		[11040701] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 51.3,
			maxHp = 24632.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 51.3,
			pre_meleeDef = 327.2,
			sanity = 0,
			remark = "守卫精英（受到攻击后触发振荡；振荡范围强化）",
			giftSkill = 1202802,
			weakPointHpRate = 0.3,
			meleeDef = 327.2,
			level = 46,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 512.6,
			pre_meleeAtk = 512.6,
			pre_maxHp = 24632.8,
			colorType = 2,
			monsterType = 1,
			id = 11040701,
			mobility = 2,
			pre_magicDef = 165.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 50.6,
			modelId = 120028,
			magicDef = 165.4,
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
		[11040702] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 52.7,
			maxHp = 3921.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 52.7,
			pre_meleeDef = 294.5,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 294.5,
			level = 46,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 526.7,
			pre_meleeAtk = 526.7,
			pre_maxHp = 3921.3,
			colorType = 2,
			monsterType = 0,
			id = 11040702,
			mobility = 2,
			pre_magicDef = 148.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 47.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 47.6,
			modelId = 120028,
			magicDef = 148.9,
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
		[11040703] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 612.2,
			maxHp = 2391.3,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 612.2,
			pre_meleeDef = 165.6,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 165.6,
			level = 46,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 61.2,
			pre_meleeAtk = 61.2,
			pre_maxHp = 2391.3,
			colorType = 4,
			monsterType = 0,
			id = 11040703,
			mobility = 2,
			pre_magicDef = 273.6,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 47.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 47.6,
			modelId = 120031,
			magicDef = 273.6,
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
		[11040704] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 57.7,
			maxHp = 2776.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 57.7,
			pre_meleeDef = 250,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 250,
			level = 46,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 576.7,
			pre_meleeAtk = 576.7,
			pre_maxHp = 2776.6,
			colorType = 3,
			monsterType = 0,
			id = 11040704,
			mobility = 2,
			pre_magicDef = 149.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 67.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 67.6,
			modelId = 120030,
			magicDef = 149.8,
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
		[11040705] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 666.5,
			maxHp = 12677.5,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 666.5,
			pre_meleeDef = 184,
			sanity = 0,
			remark = "支援精英（行动结束时援护；援护强化）",
			giftSkill = 1203105,
			weakPointHpRate = 0.3,
			meleeDef = 184,
			level = 46,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 66.6,
			pre_meleeAtk = 66.6,
			pre_maxHp = 12677.5,
			colorType = 4,
			monsterType = 1,
			id = 11040705,
			mobility = 2,
			pre_magicDef = 304,
			aiStepOrder = 0,
			trumpSkill = 1203104,
			isFuzzy = false,
			inspire = 50.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 50.6,
			modelId = 120031,
			magicDef = 304,
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
		[11040706] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 63.6,
			maxHp = 17886.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 63.6,
			pre_meleeDef = 277.8,
			sanity = 0,
			remark = "狙击精英（弧光额外弹射3次）",
			giftSkill = 1203002,
			weakPointHpRate = 0.3,
			meleeDef = 277.8,
			level = 46,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 636,
			pre_meleeAtk = 636,
			pre_maxHp = 17886.9,
			colorType = 3,
			monsterType = 1,
			id = 11040706,
			mobility = 2,
			pre_magicDef = 166.4,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70.6,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 70.6,
			modelId = 120030,
			magicDef = 166.4,
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
		}
	}
}

return configData
