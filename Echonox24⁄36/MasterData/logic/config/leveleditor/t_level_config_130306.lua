-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130306.lua

module("logic.config.leveleditor.t_level_config_130306", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130306",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "幻影材料本-6",
	lossConditionDesc = "",
	sceneId = "115002",
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
			y = 1
		},
		{
			direction = 1,
			x = 7,
			y = 2
		},
		{
			direction = 1,
			x = 8,
			y = 1
		}
	},
	additionalTerrainList = {
		{
			terrainId = 4001,
			times = 0,
			posList = {
				{
					x = 7,
					y = 13
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
					DIYName = "10回合内刺杀仪式负责人",
					condition = 3,
					monsterIds = {
						13030601
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
			symbolStr = "刺杀",
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = true,
			groupName = "胜利条件的刺杀怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 12,
					tag = "",
					monsterId = 13030601,
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
			form = 1,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "守卫道路的怪物",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 11,
					tag = "",
					monsterId = 13030602,
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
					monsterId = 13030602,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030602,
					x = 2,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030602,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030602,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13030602,
					x = 12,
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
					monsterId = 13030602,
					x = 11,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 11,
					tag = "",
					monsterId = 13030602,
					x = 12,
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
			y = 12
		},
		{
			x = 6,
			y = 1
		}
	},
	lockHeroList = {},
	monsters = {
		[13030601] = {
			normalSkill = 1223101,
			name = "仪式负责人",
			pre_magicAtk = 94,
			maxHp = 19822,
			aiName = "ai-幻影本-刺杀目标2",
			battleCamp = 1,
			career = 3,
			magicAtk = 0,
			pre_meleeDef = 385,
			sanity = 0,
			remark = "",
			giftSkill = 1223102,
			weakPointHpRate = 0.3,
			meleeDef = 260,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 940.1,
			pre_maxHp = 31822,
			colorType = 3,
			monsterType = 1,
			id = 13030601,
			mobility = 2,
			pre_magicDef = 260,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 78,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 78,
			modelId = 120047,
			magicDef = 385,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"C",
				"B"
			},
			tags = {}
		},
		[13030602] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 76.8,
			maxHp = 7272.7,
			aiName = "ai-幻影本-守卫小怪",
			battleCamp = 1,
			career = 2,
			magicAtk = 76.8,
			pre_meleeDef = 400.5,
			sanity = 0,
			remark = "守卫小怪（反击后触发振荡）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 400.5,
			level = 60,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 767.9,
			pre_meleeAtk = 767.9,
			pre_maxHp = 7272.7,
			colorType = 2,
			monsterType = 0,
			id = 13030602,
			mobility = 1,
			pre_magicDef = 232.2,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120090,
			magicDef = 232.2,
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
		}
	}
}

return configData
