-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110209.lua

module("logic.config.leveleditor.t_level_config_110209", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal03_block",
	remarks = "",
	levelId = "110209",
	plotEventGroup = 110209,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "主线普通2-9",
	lossConditionDesc = "",
	sceneId = "108004",
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
			x = 10,
			y = 6
		},
		{
			direction = 1,
			x = 11,
			y = 9
		},
		{
			direction = 1,
			x = 10,
			y = 8
		},
		{
			direction = 4,
			x = 11,
			y = 5
		},
		{
			direction = 4,
			x = 11,
			y = 4
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1022,
			times = 1,
			posList = {
				{
					x = 8,
					y = 4
				}
			}
		}
	},
	winConditionGroupList = {
		{
			tag = "101",
			isBackup = false,
			hasTag = true,
			winConditionList = {
				{
					round = 3,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "存活3回合",
					condition = 2,
					monsterIds = {}
				}
			}
		},
		{
			tag = "102",
			isBackup = true,
			hasTag = true,
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
			symbolStr = "104",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = true,
			groupName = "上方",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 10,
					tag = "",
					monsterId = 11020901,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 11020901,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 11020902,
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
			groupName = "准备转变阵营的己方单位",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 7,
					tag = "",
					monsterId = 11020903,
					x = 10,
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
					monsterId = 11020904,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "104",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = true,
			groupName = "下方",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 11020901,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 4,
					tag = "",
					monsterId = 11020901,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 4,
					tag = "",
					monsterId = 11020902,
					x = 7,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 3,
					tag = "",
					monsterId = 11020902,
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
			refreshType = 4,
			form = 2,
			plotStr = "103",
			round = 1,
			hasSymbol = false,
			groupName = "芬里尔",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 11020905,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "104",
			refreshType = 1,
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = true,
			groupName = "芬里尔秒杀怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 11020907,
					x = 5,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 11020907,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 11020907,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 11020907,
					x = 5,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 11020906,
					x = 4,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 11020906,
					x = 4,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 11020906,
					x = 4,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 11020906,
					x = 4,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 5,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "芬里尔秒杀后刷新怪",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 11020909,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 9,
					tag = "",
					monsterId = 11020908,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 11020908,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 11020909,
					x = 7,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 8,
			y = 9
		},
		{
			x = 8,
			y = 4
		}
	},
	lockHeroList = {},
	trialHeroes = {},
	monsters = {
		[11020901] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 14,
			maxHp = 918.8,
			aiName = "ai_主线3.9_近战",
			battleCamp = 1,
			career = 2,
			magicAtk = 14,
			pre_meleeDef = 97.8,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 97.8,
			level = 16,
			monsterGroup = "通用关卡",
			skipStep = true,
			hasGodlike = false,
			meleeAtk = 139.9,
			pre_meleeAtk = 139.9,
			pre_maxHp = 918.8,
			colorType = 2,
			monsterType = 0,
			id = 11020901,
			mobility = 0,
			pre_magicDef = 41.1,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 33.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 33.7,
			modelId = 120067,
			magicDef = 41.1,
			specialSkill = 0,
			extraSkills = {
				1760007
			},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[11020902] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 14.7,
			maxHp = 679.1,
			aiName = "ai_主线3.9_陨灭",
			battleCamp = 1,
			career = 5,
			magicAtk = 14.7,
			pre_meleeDef = 84.9,
			sanity = 0,
			remark = "",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 84.9,
			level = 16,
			monsterGroup = "通用关卡",
			skipStep = true,
			hasGodlike = false,
			meleeAtk = 146.5,
			pre_meleeAtk = 146.5,
			pre_maxHp = 679.1,
			colorType = 4,
			monsterType = 0,
			id = 11020902,
			mobility = 0,
			pre_magicDef = 50.7,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 43.7,
			modelId = 120069,
			magicDef = 50.7,
			specialSkill = 1206902,
			extraSkills = {
				1760007
			},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[11020903] = {
			normalSkill = 1101601,
			name = "烟火",
			pre_magicAtk = 14.4,
			maxHp = 757.6,
			aiName = "",
			battleCamp = 1,
			career = 1,
			magicAtk = 14.4,
			pre_meleeDef = 89.7,
			sanity = 0,
			remark = "",
			giftSkill = 1101604,
			weakPointHpRate = 0,
			meleeDef = 89.7,
			level = 16,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 144,
			pre_meleeAtk = 144,
			pre_maxHp = 757.6,
			colorType = 1,
			monsterType = 0,
			id = 11020903,
			mobility = 4,
			pre_magicDef = 40.8,
			aiStepOrder = 4,
			trumpSkill = 1101603,
			isFuzzy = false,
			inspire = 43.7,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 43.7,
			modelId = 100016,
			magicDef = 40.8,
			specialSkill = 1101602,
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
		[11020904] = {
			normalSkill = 1105301,
			name = "阿妮亚",
			pre_magicAtk = 155.3,
			maxHp = 567.8,
			aiName = "",
			battleCamp = 1,
			career = 6,
			magicAtk = 155.3,
			pre_meleeDef = 47.7,
			sanity = 0,
			remark = "",
			giftSkill = 1105304,
			weakPointHpRate = 0,
			meleeDef = 47.7,
			level = 16,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 15.5,
			pre_meleeAtk = 15.5,
			pre_maxHp = 567.8,
			colorType = 4,
			monsterType = 0,
			id = 11020904,
			mobility = 2,
			pre_magicDef = 89.7,
			aiStepOrder = 4,
			trumpSkill = 1105303,
			isFuzzy = false,
			inspire = 33.7,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 33.7,
			modelId = 100053,
			magicDef = 89.7,
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
		},
		[11020905] = {
			normalSkill = 1101201,
			name = "芬里尔",
			pre_magicAtk = 348.1,
			maxHp = 1906.5,
			aiName = "auto_fenlier_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 748.1,
			pre_meleeDef = 103.5,
			sanity = 0,
			remark = "",
			giftSkill = 1101204,
			weakPointHpRate = 0,
			meleeDef = 103.5,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 34.8,
			pre_meleeAtk = 34.8,
			pre_maxHp = 1906.5,
			colorType = 1,
			monsterType = 0,
			id = 11020905,
			mobility = 2,
			pre_magicDef = 164.7,
			aiStepOrder = 0,
			trumpSkill = 1101203,
			isFuzzy = false,
			inspire = 60,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 100012,
			magicDef = 164.7,
			specialSkill = 1101202,
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
		[11020906] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 14,
			maxHp = 918.8,
			aiName = "",
			battleCamp = 1,
			career = 2,
			magicAtk = 14,
			pre_meleeDef = 97.8,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 97.8,
			level = 16,
			monsterGroup = "通用关卡",
			skipStep = true,
			hasGodlike = false,
			meleeAtk = 139.9,
			pre_meleeAtk = 139.9,
			pre_maxHp = 918.8,
			colorType = 2,
			monsterType = 0,
			id = 11020906,
			mobility = 0,
			pre_magicDef = 41.1,
			aiStepOrder = 5,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 33.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 33.7,
			modelId = 120067,
			magicDef = 41.1,
			specialSkill = 0,
			extraSkills = {
				1760007
			},
			attributeGrade = {
				"B",
				"B",
				"A",
				"C",
				"C"
			},
			tags = {}
		},
		[11020907] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 14.7,
			maxHp = 679.1,
			aiName = "",
			battleCamp = 1,
			career = 5,
			magicAtk = 14.7,
			pre_meleeDef = 84.9,
			sanity = 0,
			remark = "",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 84.9,
			level = 16,
			monsterGroup = "通用关卡",
			skipStep = true,
			hasGodlike = false,
			meleeAtk = 146.5,
			pre_meleeAtk = 146.5,
			pre_maxHp = 679.1,
			colorType = 4,
			monsterType = 0,
			id = 11020907,
			mobility = 0,
			pre_magicDef = 50.7,
			aiStepOrder = 6,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 43.7,
			modelId = 120069,
			magicDef = 50.7,
			specialSkill = 1206902,
			extraSkills = {
				1760007
			},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		},
		[11020908] = {
			normalSkill = 1206701,
			name = "冲锋路桩",
			pre_magicAtk = 14,
			maxHp = 918.8,
			aiName = "ai_主线3.9_近战",
			battleCamp = 1,
			career = 2,
			magicAtk = 14,
			pre_meleeDef = 97.8,
			sanity = 0,
			remark = "",
			giftSkill = 1206702,
			weakPointHpRate = 0,
			meleeDef = 97.8,
			level = 16,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 139.9,
			pre_meleeAtk = 139.9,
			pre_maxHp = 918.8,
			colorType = 2,
			monsterType = 0,
			id = 11020908,
			mobility = 2,
			pre_magicDef = 41.1,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 33.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 33.7,
			modelId = 120067,
			magicDef = 41.1,
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
		[11020909] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 14.7,
			maxHp = 679.1,
			aiName = "ai_主线3.9_陨灭",
			battleCamp = 1,
			career = 5,
			magicAtk = 14.7,
			pre_meleeDef = 84.9,
			sanity = 0,
			remark = "",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 84.9,
			level = 16,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 146.5,
			pre_meleeAtk = 146.5,
			pre_maxHp = 679.1,
			colorType = 4,
			monsterType = 0,
			id = 11020909,
			mobility = 1,
			pre_magicDef = 50.7,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43.7,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 43.7,
			modelId = 120069,
			magicDef = 50.7,
			specialSkill = 1206902,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"B",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
