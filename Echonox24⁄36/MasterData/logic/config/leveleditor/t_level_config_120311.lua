-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120311.lua

module("logic.config.leveleditor.t_level_config_120311", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120311",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "3-断章B-1",
	lossConditionDesc = "",
	sceneId = "112002",
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
			y = 6
		},
		{
			direction = 3,
			x = 6,
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
					round = 5,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 1,
					monsterIds = {
						12031103
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
			form = 1,
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
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 12031103,
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "奶",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 10,
					tag = "",
					monsterId = 12031105,
					x = 2,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 12031105,
					x = 8,
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
			form = 1,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "初始",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 9,
					tag = "",
					monsterId = 12031104,
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
			refreshType = 2,
			form = 1,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "回合3",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 12031104,
					x = 11,
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
					monsterId = 12031104,
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "回合5",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 12031104,
					x = 1,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 12031104,
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
			refreshType = 2,
			form = 3,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "回合2",
			color = 7,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 12031104,
					x = 5,
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
					monsterId = 12031104,
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
			refreshType = 2,
			form = 3,
			plotStr = "",
			round = 4,
			hasSymbol = false,
			groupName = "回合4",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 12031104,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 12031104,
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
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 3,
			heroType = 2,
			monsterId = 12031101,
			pos = {
				x = 6,
				y = 5
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 1,
			heroType = 2,
			monsterId = 12031102,
			pos = {
				x = 6,
				y = 6
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[12031101] = {
			normalSkill = 1105601,
			name = "提亚",
			pre_magicAtk = 336.2,
			maxHp = 1167,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 587,
			pre_meleeDef = 115.2,
			sanity = 0,
			remark = "提亚",
			giftSkill = 1105604,
			weakPointHpRate = 0,
			meleeDef = 213,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 215,
			pre_meleeAtk = 33.6,
			pre_maxHp = 1954.8,
			colorType = 4,
			monsterType = 0,
			id = 12031101,
			mobility = 2,
			pre_magicDef = 180.9,
			aiStepOrder = 0,
			trumpSkill = 1105603,
			isFuzzy = false,
			inspire = 68,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 40,
			modelId = 100056,
			magicDef = 283,
			specialSkill = 1105602,
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
		[12031102] = {
			normalSkill = 1105701,
			name = "厄迪普斯",
			pre_magicAtk = 348.1,
			maxHp = 1906.5,
			aiName = "auto_texiusi_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 664,
			pre_meleeDef = 103.5,
			sanity = 0,
			remark = "厄迪普斯",
			giftSkill = 1105704,
			weakPointHpRate = 0,
			meleeDef = 103.5,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 34.8,
			pre_meleeAtk = 34.8,
			pre_maxHp = 1906.5,
			colorType = 3,
			monsterType = 0,
			id = 12031102,
			mobility = 2,
			pre_magicDef = 164.7,
			aiStepOrder = 0,
			trumpSkill = 1105703,
			isFuzzy = false,
			inspire = 64,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 100057,
			magicDef = 277,
			specialSkill = 1105702,
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
		[12031103] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 440.7,
			maxHp = 7047.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 440.7,
			pre_meleeDef = 115,
			sanity = 0,
			remark = "蓝特异精英（主动攻击时触发强化超感；获得高昂）",
			giftSkill = 1202902,
			weakPointHpRate = 0.3,
			meleeDef = 115,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 44.1,
			pre_meleeAtk = 44.1,
			pre_maxHp = 7047.8,
			colorType = 2,
			monsterType = 1,
			id = 12031103,
			mobility = 2,
			pre_magicDef = 183,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 63,
			modelId = 120029,
			magicDef = 183,
			specialSkill = 1202904,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[12031104] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 348.1,
			maxHp = 1906.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 348.1,
			pre_meleeDef = 103.5,
			sanity = 0,
			remark = "蓝特异小怪（主动攻击时触发超感；超感范围+1）",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 103.5,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 34.8,
			pre_meleeAtk = 34.8,
			pre_maxHp = 1906.5,
			colorType = 2,
			monsterType = 0,
			id = 12031104,
			mobility = 2,
			pre_magicDef = 164.7,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120029,
			magicDef = 164.7,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"A",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[12031105] = {
			normalSkill = 1203101,
			name = "枯荣/维生",
			pre_magicAtk = 336.2,
			maxHp = 1954.8,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 336.2,
			pre_meleeDef = 115.2,
			sanity = 0,
			remark = "支援小怪（行动结束时援护；援护群体加攻）",
			giftSkill = 1203103,
			weakPointHpRate = 0,
			meleeDef = 115.2,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 33.6,
			pre_meleeAtk = 33.6,
			pre_maxHp = 1954.8,
			colorType = 4,
			monsterType = 0,
			id = 12031105,
			mobility = 2,
			pre_magicDef = 180.9,
			aiStepOrder = 0,
			trumpSkill = 1203102,
			isFuzzy = false,
			inspire = 40,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 40,
			modelId = 120031,
			magicDef = 180.9,
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
		}
	}
}

return configData
