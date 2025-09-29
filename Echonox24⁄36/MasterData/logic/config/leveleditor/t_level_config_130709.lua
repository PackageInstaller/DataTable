-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130709.lua

module("logic.config.leveleditor.t_level_config_130709", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130709",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "陨灭材料本-9",
	lossConditionDesc = "",
	sceneId = "130712",
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
			x = 5,
			y = 11
		},
		{
			direction = 3,
			x = 7,
			y = 11
		},
		{
			direction = 3,
			x = 9,
			y = 11
		},
		{
			direction = 1,
			x = 5,
			y = 3
		},
		{
			direction = 1,
			x = 7,
			y = 3
		},
		{
			direction = 1,
			x = 9,
			y = 3
		}
	},
	additionalTerrainList = {
		{
			terrainId = 4004,
			times = 0,
			posList = {
				{
					x = 12,
					y = 9
				},
				{
					x = 12,
					y = 8
				},
				{
					x = 12,
					y = 7
				},
				{
					x = 12,
					y = 6
				},
				{
					x = 12,
					y = 5
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
					DIYName = "拦截不超过5个密室原体入侵",
					condition = 1,
					monsterIds = {}
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
			DIYName = "5个密室原体成功入侵",
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
			groupName = "初始",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 13070901,
					x = 1,
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
					monsterId = 13070903,
					x = 1,
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
					monsterId = 13070901,
					x = 2,
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
					monsterId = 13070902,
					x = 1,
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
					monsterId = 13070903,
					x = 2,
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
					monsterId = 13070901,
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
					monsterId = 13070902,
					x = 3,
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
					monsterId = 13070903,
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
			form = 6,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "第2回合刷新",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 13070904,
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
					monsterId = 13070906,
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
					monsterId = 13070904,
					x = 3,
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
					monsterId = 13070905,
					x = 3,
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
					monsterId = 13070906,
					x = 3,
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
					monsterId = 13070904,
					x = 2,
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
					monsterId = 13070906,
					x = 2,
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
					monsterId = 13070904,
					x = 1,
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
					monsterId = 13070905,
					x = 1,
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
					monsterId = 13070906,
					x = 1,
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
			form = 6,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "怪物组3",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 13070901,
					x = 2,
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
					monsterId = 13070902,
					x = 2,
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
					monsterId = 13070903,
					x = 2,
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
					monsterId = 13070902,
					x = 1,
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
					monsterId = 13070901,
					x = 0,
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
					monsterId = 13070902,
					x = 0,
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
					monsterId = 13070903,
					x = 0,
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
	trialHeroes = {},
	monsters = {
		[13070901] = {
			normalSkill = 0,
			name = "徘徊者",
			pre_magicAtk = 121.9,
			maxHp = 2961,
			aiName = "ai-陨灭本-2.1",
			battleCamp = 1,
			career = 1,
			magicAtk = 121.9,
			pre_meleeDef = 540.9,
			sanity = 0,
			remark = "随意近战（记得改职业）",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 355.5,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1219.1,
			pre_meleeAtk = 1219.1,
			pre_maxHp = 9020.1,
			colorType = 1,
			monsterType = 0,
			id = 13070901,
			mobility = 4,
			pre_magicDef = 355.5,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120097,
			magicDef = 355.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[13070902] = {
			normalSkill = 0,
			name = "徘徊者",
			pre_magicAtk = 121.9,
			maxHp = 2961,
			aiName = "ai-陨灭本-2.2",
			battleCamp = 1,
			career = 1,
			magicAtk = 121.9,
			pre_meleeDef = 540.9,
			sanity = 0,
			remark = "随意近战（记得改职业）",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 355.5,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1219.1,
			pre_meleeAtk = 1219.1,
			pre_maxHp = 9020.1,
			colorType = 1,
			monsterType = 0,
			id = 13070902,
			mobility = 4,
			pre_magicDef = 355.5,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120097,
			magicDef = 355.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[13070903] = {
			normalSkill = 0,
			name = "徘徊者",
			pre_magicAtk = 121.9,
			maxHp = 2961,
			aiName = "ai-陨灭本-2.3",
			battleCamp = 1,
			career = 1,
			magicAtk = 121.9,
			pre_meleeDef = 540.9,
			sanity = 0,
			remark = "随意近战（记得改职业）",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 355.5,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1219.1,
			pre_meleeAtk = 1219.1,
			pre_maxHp = 9020.1,
			colorType = 1,
			monsterType = 0,
			id = 13070903,
			mobility = 4,
			pre_magicDef = 355.5,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120097,
			magicDef = 355.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
				"C",
				"C",
				"C"
			},
			tags = {}
		},
		[13070904] = {
			normalSkill = 0,
			name = "抽水花洒",
			pre_magicAtk = 1377,
			maxHp = 3646,
			aiName = "ai-陨灭本-2.1",
			battleCamp = 1,
			career = 6,
			magicAtk = 1377,
			pre_meleeDef = 386.1,
			sanity = 0,
			remark = "支援小怪",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 355.5,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 137.7,
			pre_meleeAtk = 137.7,
			pre_maxHp = 6760.4,
			colorType = 4,
			monsterType = 0,
			id = 13070904,
			mobility = 2,
			pre_magicDef = 540.9,
			aiStepOrder = 4,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120095,
			magicDef = 355.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"C"
			},
			tags = {}
		},
		[13070905] = {
			normalSkill = 0,
			name = "抽水花洒",
			pre_magicAtk = 1377,
			maxHp = 3646,
			aiName = "ai-陨灭本-2.2",
			battleCamp = 1,
			career = 6,
			magicAtk = 1377,
			pre_meleeDef = 386.1,
			sanity = 0,
			remark = "支援小怪",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 355.5,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 137.7,
			pre_meleeAtk = 137.7,
			pre_maxHp = 6760.4,
			colorType = 4,
			monsterType = 0,
			id = 13070905,
			mobility = 2,
			pre_magicDef = 540.9,
			aiStepOrder = 5,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120095,
			magicDef = 355.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"C"
			},
			tags = {}
		},
		[13070906] = {
			normalSkill = 0,
			name = "抽水花洒",
			pre_magicAtk = 1377,
			maxHp = 3646,
			aiName = "ai-陨灭本-2.3",
			battleCamp = 1,
			career = 6,
			magicAtk = 1377,
			pre_meleeDef = 386.1,
			sanity = 0,
			remark = "支援小怪",
			giftSkill = 1227103,
			weakPointHpRate = 0,
			meleeDef = 355.5,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 137.7,
			pre_meleeAtk = 137.7,
			pre_maxHp = 6760.4,
			colorType = 4,
			monsterType = 0,
			id = 13070906,
			mobility = 2,
			pre_magicDef = 540.9,
			aiStepOrder = 6,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120095,
			magicDef = 355.5,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"B",
				"C",
				"C",
				"A",
				"C"
			},
			tags = {}
		}
	}
}

return configData
