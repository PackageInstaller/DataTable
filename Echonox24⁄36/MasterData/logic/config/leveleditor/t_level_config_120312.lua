-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_120312.lua

module("logic.config.leveleditor.t_level_config_120312", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "120312",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 5,
	levelName = "3-断章B-2",
	lossConditionDesc = "",
	sceneId = "113002",
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
			x = 8,
			y = 10
		},
		{
			direction = 3,
			x = 10,
			y = 10
		},
		{
			direction = 3,
			x = 6,
			y = 10
		},
		{
			direction = 3,
			x = 7,
			y = 10
		},
		{
			direction = 3,
			x = 9,
			y = 10
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1006,
			times = 1,
			posList = {
				{
					x = 9,
					y = 11
				},
				{
					x = 5,
					y = 11
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
					round = 5,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 2,
					monsterIds = {}
				}
			}
		},
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
					DIYName = "5回合内敌人全灭",
					condition = 13,
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
			form = 3,
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
					y = 6,
					tag = "",
					monsterId = 12031201,
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
			form = 3,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "特异",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 12031202,
					x = 11,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 12031202,
					x = 12,
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
			groupName = "狙",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 12031203,
					x = 4,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 12031203,
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
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 12031204,
					x = 9,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 12031204,
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
			form = 2,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "第2回合",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 12031203,
					x = 4,
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
					monsterId = 12031203,
					x = 5,
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
					monsterId = 12031202,
					x = 11,
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
					monsterId = 12031202,
					x = 12,
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
			groupName = "第3回合",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 12031202,
					x = 11,
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
					monsterId = 12031202,
					x = 12,
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
					monsterId = 12031203,
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
					monsterId = 12031203,
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
			refreshType = 2,
			form = 4,
			plotStr = "",
			round = 4,
			hasSymbol = false,
			groupName = "第4回合",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 12031204,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 6,
					tag = "",
					monsterId = 12031204,
					x = 10,
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
			form = 2,
			plotStr = "",
			round = 5,
			hasSymbol = false,
			groupName = "第5回合",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 12031203,
					x = 4,
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
					monsterId = 12031203,
					x = 5,
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
					monsterId = 12031202,
					x = 11,
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
					monsterId = 12031202,
					x = 12,
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
		[12031201] = {
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
			remark = "红特异精英（主动攻击时触发强化超感；获得高昂）",
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
			colorType = 1,
			monsterType = 1,
			id = 12031201,
			mobility = 2,
			pre_magicDef = 183,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 63,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 2,
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
				"S"
			},
			tags = {}
		},
		[12031202] = {
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
			remark = "红特异小怪（主动攻击时触发超感；超感范围+1）",
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
			colorType = 1,
			monsterType = 0,
			id = 12031202,
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
				"A"
			},
			tags = {}
		},
		[12031203] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 32.1,
			maxHp = 2269,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 32.1,
			pre_meleeDef = 164.7,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 164.7,
			level = 30,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 320.6,
			pre_meleeAtk = 320.6,
			pre_maxHp = 2269,
			colorType = 3,
			monsterType = 0,
			id = 12031203,
			mobility = 2,
			pre_magicDef = 103.5,
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
			modelId = 120030,
			magicDef = 103.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"A",
				"B",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[12031204] = {
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
			id = 12031204,
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
				"A"
			},
			tags = {}
		}
	}
}

return configData
