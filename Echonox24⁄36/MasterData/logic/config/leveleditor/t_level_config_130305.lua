-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130305.lua

module("logic.config.leveleditor.t_level_config_130305", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130305",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "幻影材料本-5",
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
						13030501
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
					monsterId = 13030501,
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
					monsterId = 13030502,
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
					monsterId = 13030502,
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
					monsterId = 13030502,
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
					monsterId = 13030502,
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
					monsterId = 13030502,
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
					monsterId = 13030502,
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
					monsterId = 13030502,
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
					monsterId = 13030502,
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
		[13030501] = {
			normalSkill = 1223101,
			name = "仪式负责人",
			pre_magicAtk = 50.6,
			maxHp = 17247.4,
			aiName = "ai-幻影本-刺杀目标2",
			battleCamp = 1,
			career = 3,
			magicAtk = 0,
			pre_meleeDef = 229,
			sanity = 0,
			remark = "",
			giftSkill = 1223102,
			weakPointHpRate = 0.3,
			meleeDef = 162,
			level = 45,
			monsterGroup = "",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 0,
			pre_meleeAtk = 506.4,
			pre_maxHp = 24023.6,
			colorType = 3,
			monsterType = 1,
			id = 13030501,
			mobility = 2,
			pre_magicDef = 136,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70,
			camp = 1,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 0,
			pre_inspire = 68,
			modelId = 120047,
			magicDef = 275,
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
		[13030502] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 51.7,
			maxHp = 3769.3,
			aiName = "ai-幻影本-守卫小怪",
			battleCamp = 1,
			career = 2,
			magicAtk = 51.7,
			pre_meleeDef = 291.6,
			sanity = 0,
			remark = "守卫小怪（反击后触发振荡）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 291.6,
			level = 45,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 516.7,
			pre_meleeAtk = 516.7,
			pre_maxHp = 3769.3,
			colorType = 2,
			monsterType = 0,
			id = 13030502,
			mobility = 1,
			pre_magicDef = 144.9,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 47,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 47,
			modelId = 120090,
			magicDef = 144.9,
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
