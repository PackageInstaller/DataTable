-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130499.lua

module("logic.config.leveleditor.t_level_config_130499", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "130499",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "守卫材料本-实验性质",
	lossConditionDesc = "",
	sceneId = "130402",
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
			x = 9,
			y = 11
		},
		{
			direction = 2,
			x = 11,
			y = 11
		},
		{
			direction = 2,
			x = 9,
			y = 9
		},
		{
			direction = 2,
			x = 11,
			y = 9
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
					DIYName = "在支援到来前，火种不熄灭",
					condition = 2,
					monsterIds = {
						13049903
					}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 2,
			maxDeadCount = 0,
			count = 0,
			hasTag = false,
			DIYName = "火种被破坏",
			isBackup = false,
			tag = "",
			targetId = 13049904,
			monsterIds = {}
		}
	},
	globalSkillCodeList = {},
	monsterGroupList = {
		{
			symbolStr = "保护",
			refreshType = 1,
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = true,
			groupName = "保护友方目标",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 10,
					tag = "",
					monsterId = 13049901,
					x = 10,
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
			groupName = "第一回合开始进攻的怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 20,
					tag = "",
					monsterId = 13049902,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 19,
					tag = "",
					monsterId = 13049902,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 18,
					tag = "",
					monsterId = 13049902,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 17,
					tag = "",
					monsterId = 13049902,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 19,
					tag = "",
					monsterId = 13049902,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 19,
					tag = "",
					monsterId = 13049902,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 20,
					tag = "",
					monsterId = 13049902,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 19,
					tag = "",
					monsterId = 13049902,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 16,
					tag = "",
					monsterId = 13049902,
					x = 1,
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
			form = 4,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "第三回合开始进攻的怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 13049902,
					x = 20,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 13049902,
					x = 18,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 13049902,
					x = 20,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 13049902,
					x = 19,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 13049902,
					x = 19,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 13049902,
					x = 17,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 13049902,
					x = 16,
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
					monsterId = 13049902,
					x = 19,
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
			groupName = "第五回合开始进攻的怪物(左下)",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 13049902,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 13049902,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 0,
					tag = "",
					monsterId = 13049902,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 13049902,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 13049902,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 13049902,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 13049902,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 4,
			hasSymbol = false,
			groupName = "第4回合开始进攻的怪物(右上)",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 20,
					tag = "",
					monsterId = 13049902,
					x = 20,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 19,
					tag = "",
					monsterId = 13049902,
					x = 19,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 20,
					tag = "",
					monsterId = 13049902,
					x = 18,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 19,
					tag = "",
					monsterId = 13049902,
					x = 20,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 20,
					tag = "",
					monsterId = 13049902,
					x = 17,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 19,
					tag = "",
					monsterId = 13049902,
					x = 16,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 17,
					tag = "",
					monsterId = 13049902,
					x = 19,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 16,
					tag = "",
					monsterId = 13049902,
					x = 19,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 7,
			y = 7
		}
	},
	lockHeroList = {},
	monsters = {
		[13049902] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 9.4,
			maxHp = 434.1,
			aiName = "ai-守卫本-进攻怪",
			battleCamp = 1,
			career = 1,
			magicAtk = 9.4,
			pre_meleeDef = 46.8,
			sanity = 0,
			remark = "",
			giftSkill = 1224204,
			weakPointHpRate = 0,
			meleeDef = 46.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 93.9,
			pre_meleeAtk = 93.9,
			pre_maxHp = 434.1,
			colorType = 1,
			monsterType = 0,
			id = 13049902,
			mobility = 4,
			pre_magicDef = 23.4,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 40,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 40,
			modelId = 120089,
			magicDef = 23.4,
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
		[13049903] = {
			normalSkill = 1223101,
			name = "仪式负责人",
			pre_magicAtk = 9.7,
			maxHp = 771,
			aiName = "ai-幻影本-刺杀目标1",
			battleCamp = 1,
			career = 3,
			magicAtk = 9.7,
			pre_meleeDef = 30.6,
			sanity = 0,
			remark = "",
			giftSkill = 1223102,
			weakPointHpRate = 0.3,
			meleeDef = 30.6,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 96.7,
			pre_meleeAtk = 96.7,
			pre_maxHp = 771,
			colorType = 3,
			monsterType = 1,
			id = 13049903,
			mobility = 2,
			pre_magicDef = 54.9,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 50,
			camp = 0,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 120047,
			magicDef = 54.9,
			specialSkill = 0,
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
		[13049904] = {
			normalSkill = 1224103,
			name = "阿妮亚",
			pre_magicAtk = 0,
			maxHp = 5,
			aiName = "ai-守卫本-保护npc",
			battleCamp = 3,
			career = 6,
			magicAtk = 0,
			pre_meleeDef = 0,
			sanity = 0,
			remark = "",
			giftSkill = 1224102,
			weakPointHpRate = 0,
			meleeDef = 0,
			level = 1,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 0,
			pre_maxHp = 5,
			colorType = 4,
			monsterType = 0,
			id = 13049904,
			mobility = 0,
			pre_magicDef = 0,
			aiStepOrder = 99,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 0,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 100053,
			magicDef = 0,
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
		}
	}
}

return configData
