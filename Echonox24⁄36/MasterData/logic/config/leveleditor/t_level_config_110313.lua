-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110313.lua

module("logic.config.leveleditor.t_level_config_110313", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110313",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "主线普通3-13",
	lossConditionDesc = "",
	sceneId = "113004",
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
			direction = 3,
			x = 4,
			y = 9
		},
		{
			direction = 3,
			x = 5,
			y = 9
		},
		{
			direction = 3,
			x = 4,
			y = 8
		},
		{
			direction = 3,
			x = 8,
			y = 9
		},
		{
			direction = 3,
			x = 9,
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
			groupName = "精英",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 11031301,
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
			groupName = "左侧精英伴生",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 11031303,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 11031304,
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
			groupName = "右侧后半",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 11031302,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 11031303,
					x = 8,
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
					monsterId = 11031303,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "左侧第一波",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 11031302,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 11031304,
					x = 3,
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
		[11031301] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 33.2,
			maxHp = 12866.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 33.2,
			pre_meleeDef = 213.2,
			sanity = 0,
			remark = "守卫精英（受到攻击后触发振荡；振荡范围强化）",
			giftSkill = 1202802,
			weakPointHpRate = 0.3,
			meleeDef = 213.2,
			level = 29,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 332.2,
			pre_meleeAtk = 332.2,
			pre_maxHp = 12866.3,
			colorType = 2,
			monsterType = 1,
			id = 11031301,
			mobility = 2,
			pre_magicDef = 109.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 42.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 42.7,
			modelId = 120028,
			magicDef = 109.8,
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
		[11031302] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 34.2,
			maxHp = 1952.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 34.2,
			pre_meleeDef = 191.9,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 191.9,
			level = 29,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 341.4,
			pre_meleeAtk = 341.4,
			pre_maxHp = 1952.5,
			colorType = 2,
			monsterType = 0,
			id = 11031302,
			mobility = 2,
			pre_magicDef = 98.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 39.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 39.7,
			modelId = 120028,
			magicDef = 98.8,
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
		[11031303] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 414.2,
			maxHp = 1162.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 414.2,
			pre_meleeDef = 99.5,
			sanity = 0,
			remark = "红特异小怪（主动攻击时触发超感；超感范围+1）",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 99.5,
			level = 29,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 41.4,
			pre_meleeAtk = 41.4,
			pre_maxHp = 1162.2,
			colorType = 1,
			monsterType = 0,
			id = 11031303,
			mobility = 2,
			pre_magicDef = 162,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.7,
			modelId = 120029,
			magicDef = 162,
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
		[11031304] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 37.4,
			maxHp = 1383.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 37.4,
			pre_meleeDef = 162,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 162,
			level = 29,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 373.7,
			pre_meleeAtk = 373.7,
			pre_maxHp = 1383.2,
			colorType = 3,
			monsterType = 0,
			id = 11031304,
			mobility = 2,
			pre_magicDef = 99.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 59.7,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 59.7,
			modelId = 120030,
			magicDef = 99.5,
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
