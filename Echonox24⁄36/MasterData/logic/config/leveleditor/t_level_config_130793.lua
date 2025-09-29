-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130793.lua

module("logic.config.leveleditor.t_level_config_130793", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "130793",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "陨灭材料本-93",
	lossConditionDesc = "",
	sceneId = "130708",
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
			direction = 4,
			x = 5,
			y = 5
		},
		{
			direction = 2,
			x = 8,
			y = 8
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1004,
			times = 0,
			posList = {
				{
					x = 6,
					y = 7
				},
				{
					x = 7,
					y = 7
				},
				{
					x = 6,
					y = 6
				},
				{
					x = 7,
					y = 6
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
					DIYName = "阻挡敌人闯阵",
					condition = 1,
					monsterIds = {
						13079301
					}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 6,
			maxDeadCount = 0,
			count = 5,
			hasTag = false,
			DIYName = "5名敌人闯过陨灭阵型",
			isBackup = false,
			tag = "",
			targetId = 13070000,
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
			groupName = "初始-右下",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 13070105,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 13070105,
					x = 13,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 13070105,
					x = 13,
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
			groupName = "初始-左上",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 11,
					tag = "",
					monsterId = 13070106,
					x = 13,
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
					monsterId = 13070106,
					x = 12,
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
					monsterId = 13070106,
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
			refreshType = 2,
			form = 6,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "第3回合-中下",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 13070105,
					x = 7,
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
					monsterId = 13070105,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 0,
					tag = "",
					monsterId = 13070105,
					x = 6,
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
			form = 6,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "第3回合-左上、右",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 13070106,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 13070106,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 13070106,
					x = 0,
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
			form = 6,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "初始-中上",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 13070106,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 13070106,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 13070106,
					x = 6,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 13,
					tag = "",
					monsterId = 13070106,
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
			form = 6,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "初始-左下",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 13070105,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 13070105,
					x = 1,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 13070105,
					x = 0,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 13070105,
					x = 0,
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
			x = 6,
			y = 6
		}
	},
	lockHeroList = {},
	monsters = {
		[13079301] = {
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
			id = 13079301,
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
		}
	}
}

return configData
