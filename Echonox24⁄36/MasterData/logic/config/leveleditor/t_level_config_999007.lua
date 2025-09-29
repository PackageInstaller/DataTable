-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_999007.lua

module("logic.config.leveleditor.t_level_config_999007", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "999007",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 6,
	levelName = "wlf个人测试7",
	lossConditionDesc = "",
	sceneId = "931007",
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
			x = 5,
			y = 1
		},
		{
			direction = 2,
			x = 6,
			y = 0
		},
		{
			direction = 2,
			x = 7,
			y = 0
		},
		{
			direction = 2,
			x = 8,
			y = 0
		},
		{
			direction = 2,
			x = 9,
			y = 1
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1001,
			times = 1,
			posList = {
				{
					x = 5,
					y = 4
				},
				{
					x = 9,
					y = 4
				},
				{
					x = 5,
					y = 7
				},
				{
					x = 9,
					y = 7
				}
			}
		},
		{
			terrainId = 1007,
			times = 1,
			posList = {
				{
					x = 7,
					y = 9
				}
			}
		}
	},
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
						99900705
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "boss",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 14,
					tag = "",
					monsterId = 99900701,
					x = 7,
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
			groupName = "法",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 99900702,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 99900702,
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "盾",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 99900703,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 99900703,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 99900703,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 99900703,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 99900703,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 99900703,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 99900703,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 99900703,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 99900703,
					x = 9,
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
			form = 5,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "炮",
			color = 5,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 99900704,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 99900704,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 99900704,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 99900704,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 12,
					tag = "",
					monsterId = 99900704,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 9,
					tag = "",
					monsterId = 99900704,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 99900704,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 99900704,
					x = 12,
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
		[99900702] = {
			normalSkill = 1283101,
			name = "迷雾使徒",
			pre_magicAtk = 277.4,
			maxHp = 509.4,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 277.4,
			pre_meleeDef = 51.5,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 51.5,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 111,
			pre_meleeAtk = 111,
			pre_maxHp = 509.4,
			colorType = 1,
			monsterType = 1,
			id = 99900702,
			mobility = 2,
			pre_magicDef = 78.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 31.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
			monsterGroupEnum = 1,
			pre_inspire = 31.9,
			modelId = 120035,
			magicDef = 78.2,
			specialSkill = 1283102,
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
		[99900703] = {
			normalSkill = 1282901,
			name = "迷雾使徒",
			pre_magicAtk = 92.5,
			maxHp = 813.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 92.5,
			pre_meleeDef = 118.3,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0.3,
			meleeDef = 118.3,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 229.8,
			pre_meleeAtk = 229.8,
			pre_maxHp = 813.6,
			colorType = 2,
			monsterType = 1,
			id = 99900703,
			mobility = 2,
			pre_magicDef = 50.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 20.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 20.9,
			modelId = 120007,
			magicDef = 50.8,
			specialSkill = 1282902,
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
		[99900704] = {
			normalSkill = 1281801,
			name = "迷雾使徒",
			pre_magicAtk = 111,
			maxHp = 195.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 111,
			pre_meleeDef = 76.2,
			sanity = 0,
			remark = "",
			giftSkill = 1281802,
			weakPointHpRate = 0,
			meleeDef = 76.2,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 277.4,
			pre_meleeAtk = 277.4,
			pre_maxHp = 195.6,
			colorType = 4,
			monsterType = 0,
			id = 99900704,
			mobility = 1,
			pre_magicDef = 76.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.4,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.4,
			modelId = 120010,
			magicDef = 76.2,
			specialSkill = 0,
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
		[99900705] = {
			normalSkill = 1105301,
			name = "阿妮亚",
			pre_magicAtk = 0,
			maxHp = 0,
			aiName = "auto_aniya_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 0,
			pre_meleeDef = 0,
			sanity = 0,
			remark = "",
			giftSkill = 1105304,
			weakPointHpRate = 0,
			meleeDef = 0,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 0,
			pre_maxHp = 0,
			colorType = 4,
			monsterType = 0,
			id = 99900705,
			mobility = 3,
			pre_magicDef = 0,
			aiStepOrder = 3,
			trumpSkill = 1105303,
			isFuzzy = false,
			inspire = 0,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 100053,
			magicDef = 0,
			specialSkill = 1105302,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		}
	}
}

return configData
