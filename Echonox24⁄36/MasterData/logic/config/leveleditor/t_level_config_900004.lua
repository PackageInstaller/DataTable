-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_900004.lua

module("logic.config.leveleditor.t_level_config_900004", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "900004",
	plotEventGroup = 0,
	maxPerson = 30,
	initRotationOffSet = 90,
	maxRound = 99,
	levelName = "全角色展示-新7日",
	lossConditionDesc = "",
	sceneId = "110002",
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
			y = 11
		},
		{
			direction = 2,
			x = 6,
			y = 11
		},
		{
			direction = 2,
			x = 8,
			y = 11
		},
		{
			direction = 2,
			x = 10,
			y = 11
		},
		{
			direction = 2,
			x = 4,
			y = 9
		},
		{
			direction = 2,
			x = 6,
			y = 9
		},
		{
			direction = 2,
			x = 8,
			y = 9
		},
		{
			direction = 2,
			x = 10,
			y = 9
		},
		{
			direction = 2,
			x = 12,
			y = 9
		},
		{
			direction = 2,
			x = 2,
			y = 9
		},
		{
			direction = 2,
			x = 2,
			y = 7
		},
		{
			direction = 2,
			x = 4,
			y = 7
		},
		{
			direction = 2,
			x = 6,
			y = 7
		},
		{
			direction = 2,
			x = 8,
			y = 7
		},
		{
			direction = 2,
			x = 10,
			y = 7
		},
		{
			direction = 2,
			x = 12,
			y = 7
		},
		{
			direction = 2,
			x = 2,
			y = 5
		},
		{
			direction = 2,
			x = 4,
			y = 5
		},
		{
			direction = 2,
			x = 6,
			y = 5
		},
		{
			direction = 2,
			x = 8,
			y = 5
		},
		{
			direction = 2,
			x = 10,
			y = 5
		},
		{
			direction = 2,
			x = 12,
			y = 5
		},
		{
			direction = 2,
			x = 10,
			y = 13
		},
		{
			direction = 2,
			x = 8,
			y = 13
		},
		{
			direction = 2,
			x = 6,
			y = 13
		},
		{
			direction = 2,
			x = 4,
			y = 13
		},
		{
			direction = 2,
			x = 2,
			y = 13
		},
		{
			direction = 2,
			x = 12,
			y = 11
		},
		{
			direction = 2,
			x = 12,
			y = 13
		},
		{
			direction = 2,
			x = 12,
			y = 3
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
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 14,
					tag = "",
					monsterId = 90000401,
					x = 0,
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
			isInitialStatus = true,
			heroId = 2000005,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 2,
				y = 13
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000007,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 4,
				y = 13
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000008,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 6,
				y = 13
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000010,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 8,
				y = 13
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000011,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 10,
				y = 13
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000012,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 12,
				y = 13
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000013,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 4,
				y = 11
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000015,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 6,
				y = 11
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000016,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 8,
				y = 11
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000019,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 10,
				y = 11
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000020,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 12,
				y = 11
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000021,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 2,
				y = 9
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000022,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 4,
				y = 9
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000025,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 6,
				y = 9
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000028,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 8,
				y = 9
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000030,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 10,
				y = 9
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000031,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 12,
				y = 9
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000036,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 2,
				y = 7
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000039,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 4,
				y = 7
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000041,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 6,
				y = 7
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000043,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 8,
				y = 7
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000047,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 10,
				y = 7
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000053,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 12,
				y = 7
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000055,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 2,
				y = 5
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = true,
			heroId = 2000056,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 4,
				y = 5
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 11021,
						layer = 1
					}
				}
			}
		}
	},
	monsters = {
		[90000401] = {
			normalSkill = 0,
			name = "水滴执行者",
			pre_magicAtk = 144.8,
			maxHp = 10916.7,
			aiName = "",
			battleCamp = 1,
			career = 5,
			magicAtk = 144.8,
			pre_meleeDef = 611.1,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 611.1,
			level = 80,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1447.8,
			pre_meleeAtk = 1447.8,
			pre_maxHp = 10916.7,
			colorType = 4,
			monsterType = 0,
			id = 90000401,
			mobility = 1,
			pre_magicDef = 468.9,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 77,
			camp = 7,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 77,
			modelId = 120049,
			magicDef = 468.9,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"B",
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
		[90000402] = {
			normalSkill = 1205001,
			name = "水滴执行者",
			pre_magicAtk = 0,
			maxHp = 0,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 0,
			pre_meleeDef = 0,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 0,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 0,
			pre_maxHp = 0,
			colorType = 1,
			monsterType = 0,
			id = 90000402,
			mobility = 2,
			pre_magicDef = 0,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 0,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 0,
			modelId = 120050,
			magicDef = 0,
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
		[90000403] = {
			normalSkill = 1204501,
			name = "水滴执行者",
			pre_magicAtk = 63.6,
			maxHp = 148.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 63.6,
			pre_meleeDef = 41,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 41,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 161.2,
			pre_meleeAtk = 161.2,
			pre_maxHp = 148.9,
			colorType = 1,
			monsterType = 0,
			id = 90000403,
			mobility = 3,
			pre_magicDef = 37.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22.4,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 22.4,
			modelId = 120045,
			magicDef = 37.8,
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
		[90000404] = {
			normalSkill = 1204601,
			name = "水滴执行者",
			pre_magicAtk = 58.5,
			maxHp = 180.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 58.5,
			pre_meleeDef = 74.9,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 74.9,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 145.5,
			pre_meleeAtk = 145.5,
			pre_maxHp = 180.2,
			colorType = 2,
			monsterType = 0,
			id = 90000404,
			mobility = 2,
			pre_magicDef = 32.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 17.9,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 17.9,
			modelId = 120046,
			magicDef = 32.1,
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
		[90000405] = {
			normalSkill = 1204701,
			name = "水滴执行者",
			pre_magicAtk = 70.2,
			maxHp = 112.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 70.2,
			pre_meleeDef = 43,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 43,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 175.4,
			pre_meleeAtk = 175.4,
			pre_maxHp = 112.8,
			colorType = 3,
			monsterType = 0,
			id = 90000405,
			mobility = 2,
			pre_magicDef = 32.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.9,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 120047,
			magicDef = 32.5,
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
		[90000406] = {
			normalSkill = 1204801,
			name = "水滴执行者",
			pre_magicAtk = 145.5,
			maxHp = 135.2,
			aiName = "mob_cure_ai",
			battleCamp = 1,
			career = 6,
			magicAtk = 145.5,
			pre_meleeDef = 37.8,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 37.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 70.2,
			pre_meleeAtk = 70.2,
			pre_maxHp = 135.2,
			colorType = 4,
			monsterType = 0,
			id = 90000406,
			mobility = 2,
			pre_magicDef = 49.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 17.9,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 17.9,
			modelId = 120048,
			magicDef = 49.5,
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
		[90000407] = {
			normalSkill = 1200601,
			name = "迷雾使徒",
			pre_magicAtk = 63.6,
			maxHp = 148.9,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 1,
			magicAtk = 63.6,
			pre_meleeDef = 41,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 41,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 161.2,
			pre_meleeAtk = 161.2,
			pre_maxHp = 148.9,
			colorType = 1,
			monsterType = 0,
			id = 90000407,
			mobility = 3,
			pre_magicDef = 37.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22.4,
			camp = 0,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 22.4,
			modelId = 120006,
			magicDef = 37.8,
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
		[90000408] = {
			normalSkill = 1200701,
			name = "迷雾使徒",
			pre_magicAtk = 58.5,
			maxHp = 180.2,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 2,
			magicAtk = 58.5,
			pre_meleeDef = 74.9,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 74.9,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 145.5,
			pre_meleeAtk = 145.5,
			pre_maxHp = 180.2,
			colorType = 2,
			monsterType = 0,
			id = 90000408,
			mobility = 2,
			pre_magicDef = 32.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 17.9,
			camp = 0,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 17.9,
			modelId = 120007,
			magicDef = 32.1,
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
		[90000409] = {
			normalSkill = 1200801,
			name = "迷雾使徒",
			pre_magicAtk = 70.2,
			maxHp = 112.8,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 3,
			magicAtk = 70.2,
			pre_meleeDef = 43,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 43,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 175.4,
			pre_meleeAtk = 175.4,
			pre_maxHp = 112.8,
			colorType = 3,
			monsterType = 0,
			id = 90000409,
			mobility = 2,
			pre_magicDef = 32.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.9,
			camp = 0,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 120008,
			magicDef = 32.5,
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
		[90000410] = {
			normalSkill = 1200901,
			name = "迷雾使徒",
			pre_magicAtk = 145.5,
			maxHp = 135.2,
			aiName = "mob_cure_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 145.5,
			pre_meleeDef = 37.8,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 37.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 70.2,
			pre_meleeAtk = 70.2,
			pre_maxHp = 135.2,
			colorType = 4,
			monsterType = 0,
			id = 90000410,
			mobility = 2,
			pre_magicDef = 49.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 17.9,
			camp = 0,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 17.9,
			modelId = 120009,
			magicDef = 49.5,
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
		[90000411] = {
			normalSkill = 1201001,
			name = "迷雾使徒",
			pre_magicAtk = 82.6,
			maxHp = 123.8,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 5,
			magicAtk = 82.6,
			pre_meleeDef = 48.2,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 48.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 206.4,
			pre_meleeAtk = 206.4,
			pre_maxHp = 123.8,
			colorType = 4,
			monsterType = 0,
			id = 90000411,
			mobility = 1,
			pre_magicDef = 48.2,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22.4,
			camp = 0,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 22.4,
			modelId = 120010,
			magicDef = 48.2,
			specialSkill = 1201002,
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
		[90000412] = {
			normalSkill = 1203501,
			name = "迷雾使徒",
			pre_magicAtk = 206.4,
			maxHp = 112.8,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 206.4,
			pre_meleeDef = 32.5,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 32.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.6,
			pre_meleeAtk = 82.6,
			pre_maxHp = 112.8,
			colorType = 2,
			monsterType = 0,
			id = 90000412,
			mobility = 2,
			pre_magicDef = 49.5,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.9,
			camp = 0,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 120035,
			magicDef = 49.5,
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
		[90000413] = {
			normalSkill = 1202901,
			name = "枯荣/维生",
			pre_magicAtk = 206.4,
			maxHp = 112.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 206.4,
			pre_meleeDef = 32.5,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 32.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.6,
			pre_meleeAtk = 82.6,
			pre_maxHp = 112.8,
			colorType = 3,
			monsterType = 0,
			id = 90000413,
			mobility = 2,
			pre_magicDef = 49.5,
			aiStepOrder = 20,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 120031,
			magicDef = 49.5,
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
		[90000414] = {
			normalSkill = 1202901,
			name = "枯荣/孵化",
			pre_magicAtk = 206.4,
			maxHp = 112.8,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 206.4,
			pre_meleeDef = 32.5,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 32.5,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.6,
			pre_meleeAtk = 82.6,
			pre_maxHp = 112.8,
			colorType = 3,
			monsterType = 0,
			id = 90000414,
			mobility = 2,
			pre_magicDef = 49.5,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 120028,
			magicDef = 49.5,
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
		[90000415] = {
			normalSkill = 1201501,
			name = "虫态补光灯",
			pre_magicAtk = 60.3,
			maxHp = 192.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 60.3,
			pre_meleeDef = 52.9,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 52.9,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 153,
			pre_meleeAtk = 153,
			pre_maxHp = 192.2,
			colorType = 1,
			monsterType = 0,
			id = 90000415,
			mobility = 3,
			pre_magicDef = 48.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 24.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 24.4,
			modelId = 120015,
			magicDef = 48.8,
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
		[90000416] = {
			normalSkill = 1201201,
			name = "斑驳轮胎",
			pre_magicAtk = 66.6,
			maxHp = 145.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 66.6,
			pre_meleeDef = 55.5,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 55.5,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 166.5,
			pre_meleeAtk = 166.5,
			pre_maxHp = 145.5,
			colorType = 3,
			monsterType = 0,
			id = 90000416,
			mobility = 2,
			pre_magicDef = 42,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 29.4,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 29.4,
			modelId = 120012,
			magicDef = 42,
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
		[90000417] = {
			normalSkill = 1200101,
			name = "天文台调查员",
			pre_magicAtk = 66.6,
			maxHp = 145.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 66.6,
			pre_meleeDef = 55.5,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 55.5,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 166.5,
			pre_meleeAtk = 166.5,
			pre_maxHp = 145.5,
			colorType = 2,
			monsterType = 0,
			id = 90000417,
			mobility = 2,
			pre_magicDef = 42,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 29.4,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 29.4,
			modelId = 120001,
			magicDef = 42,
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
		[90000418] = {
			normalSkill = 1200201,
			name = "天文台调查员",
			pre_magicAtk = 66.6,
			maxHp = 145.5,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 66.6,
			pre_meleeDef = 55.5,
			sanity = 0,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 55.5,
			level = 15,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 166.5,
			pre_meleeAtk = 166.5,
			pre_maxHp = 145.5,
			colorType = 1,
			monsterType = 0,
			id = 90000418,
			mobility = 3,
			pre_magicDef = 42,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 29.4,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 29.4,
			modelId = 120002,
			magicDef = 42,
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
		}
	}
}

return configData
