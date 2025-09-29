-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150067.lua

module("logic.config.leveleditor.t_level_config_150067", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "150067",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "爬塔明面67",
	lossConditionDesc = "",
	sceneId = "109001",
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
			x = 4,
			y = 7
		},
		{
			direction = 2,
			x = 4,
			y = 6
		},
		{
			direction = 2,
			x = 5,
			y = 8
		},
		{
			direction = 2,
			x = 5,
			y = 6
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "超级蛋",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15006701,
					x = 9,
					initialStatus = {
						hpPercent = 1,
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
			groupName = "小蛋",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 15006702,
					x = 13,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15006702,
					x = 13,
					initialStatus = {
						hpPercent = 1,
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
			groupName = "狙击1",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 15006703,
					x = 10,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15006703,
					x = 10,
					initialStatus = {
						hpPercent = 1,
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
			groupName = "狙击2",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 15006704,
					x = 14,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15006704,
					x = 14,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 15006704,
					x = 14,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {
		[15006701] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 124,
			maxHp = 85002.9,
			aiName = "ai_120028_秽卵",
			battleCamp = 1,
			career = 2,
			magicAtk = 124,
			pre_meleeDef = 706,
			sanity = 0,
			remark = "守卫精英-高难度",
			giftSkill = 1202802,
			weakPointHpRate = 0.3,
			meleeDef = 706,
			level = 76,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1240.2,
			pre_meleeAtk = 1240.2,
			pre_maxHp = 85002.9,
			colorType = 2,
			monsterType = 1,
			id = 15006701,
			mobility = 2,
			pre_magicDef = 435.4,
			aiStepOrder = 0,
			trumpSkill = 1202804,
			isFuzzy = false,
			inspire = 68.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 68.4,
			modelId = 120028,
			magicDef = 435.4,
			specialSkill = 0,
			extraSkills = {
				1202803
			},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		},
		[15006702] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 127.9,
			maxHp = 13951,
			aiName = "ai_120028_秽卵",
			battleCamp = 1,
			career = 2,
			magicAtk = 127.9,
			pre_meleeDef = 635.4,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 635.4,
			level = 76,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1279.2,
			pre_meleeAtk = 1279.2,
			pre_maxHp = 13951,
			colorType = 2,
			monsterType = 0,
			id = 15006702,
			mobility = 2,
			pre_magicDef = 391.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 65.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 65.4,
			modelId = 120028,
			magicDef = 391.9,
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
		[15006703] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 141.7,
			maxHp = 9578.9,
			aiName = "ai_120030_毒沫",
			battleCamp = 1,
			career = 3,
			magicAtk = 141.7,
			pre_meleeDef = 555.8,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 555.8,
			level = 76,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1417.3,
			pre_meleeAtk = 1417.3,
			pre_maxHp = 9578.9,
			colorType = 3,
			monsterType = 0,
			id = 15006703,
			mobility = 2,
			pre_magicDef = 393.7,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 85.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 85.4,
			modelId = 120030,
			magicDef = 393.7,
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
		[15006704] = {
			normalSkill = 1207001,
			name = "彩绘积木",
			pre_magicAtk = 141.7,
			maxHp = 9578.9,
			aiName = "ai_120070_涂鸦积木",
			battleCamp = 1,
			career = 3,
			magicAtk = 141.7,
			pre_meleeDef = 555.8,
			sanity = 0,
			remark = "狙击小怪",
			giftSkill = 1207003,
			weakPointHpRate = 0,
			meleeDef = 555.8,
			level = 76,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1417.3,
			pre_meleeAtk = 1417.3,
			pre_maxHp = 9578.9,
			colorType = 3,
			monsterType = 0,
			id = 15006704,
			mobility = 2,
			pre_magicDef = 393.7,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 85.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 85.4,
			modelId = 120070,
			magicDef = 393.7,
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
