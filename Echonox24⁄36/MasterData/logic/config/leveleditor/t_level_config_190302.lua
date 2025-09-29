-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_190302.lua

module("logic.config.leveleditor.t_level_config_190302", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "190302",
	plotEventGroup = 0,
	maxPerson = 4,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "超感体验难度2",
	lossConditionDesc = "",
	sceneId = "111003",
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
			x = 10,
			y = 5
		},
		{
			direction = 4,
			x = 10,
			y = 6
		},
		{
			direction = 4,
			x = 11,
			y = 8
		},
		{
			direction = 4,
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
					round = 10,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "10回合内击杀所有原体",
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
	globalSkillCodeList = {
		1721913
	},
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
					direction = 2,
					y = 10,
					tag = "",
					monsterId = 19030202,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 11,
					tag = "",
					monsterId = 19030202,
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
					monsterId = 19030202,
					x = 7,
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
					monsterId = 19030202,
					x = 7,
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
					monsterId = 19030201,
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
					monsterId = 19030203,
					x = 6,
					initialStatus = {
						hpPercent = 1,
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
			groupName = "怪物组2",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 5,
					tag = "",
					monsterId = 19030201,
					x = 5,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 3,
					tag = "",
					monsterId = 19030202,
					x = 6,
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
					monsterId = 19030202,
					x = 7,
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
					monsterId = 19030202,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 3,
					tag = "",
					monsterId = 19030202,
					x = 7,
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
					monsterId = 19030202,
					x = 6,
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
		[19030201] = {
			normalSkill = 1208101,
			name = "拟态/葵",
			pre_magicAtk = 47.2,
			maxHp = 2150.3,
			aiName = "ai_120081_尖刺",
			battleCamp = 1,
			career = 5,
			magicAtk = 47.2,
			pre_meleeDef = 216,
			sanity = 0,
			remark = "陨灭模板（没移动力；要注意）",
			giftSkill = 1208103,
			weakPointHpRate = 0,
			meleeDef = 216,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 471.7,
			pre_meleeAtk = 471.7,
			pre_maxHp = 2150.3,
			colorType = 4,
			monsterType = 0,
			id = 19030201,
			mobility = 1,
			pre_magicDef = 144,
			aiStepOrder = 3,
			trumpSkill = 1208102,
			isFuzzy = false,
			inspire = 55,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120081,
			magicDef = 144,
			specialSkill = 1208104,
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
		[19030202] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 44.1,
			maxHp = 2958.2,
			aiName = "ai_120028_秽卵",
			battleCamp = 1,
			career = 2,
			magicAtk = 44.1,
			pre_meleeDef = 244.8,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 244.8,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 440.9,
			pre_meleeAtk = 440.9,
			pre_maxHp = 2958.2,
			colorType = 2,
			monsterType = 0,
			id = 19030202,
			mobility = 2,
			pre_magicDef = 121.5,
			aiStepOrder = 0,
			trumpSkill = 1202804,
			isFuzzy = false,
			inspire = 45,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45,
			modelId = 120028,
			magicDef = 121.5,
			specialSkill = 0,
			extraSkills = {
				1202803
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
		[19030203] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 42.9,
			maxHp = 18833.2,
			aiName = "ai_120028_秽卵",
			battleCamp = 1,
			career = 2,
			magicAtk = 42.9,
			pre_meleeDef = 272,
			sanity = 0,
			remark = "守卫精英-高难度",
			giftSkill = 1202802,
			weakPointHpRate = 0.3,
			meleeDef = 272,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 428.9,
			pre_meleeAtk = 428.9,
			pre_maxHp = 18833.2,
			colorType = 2,
			monsterType = 1,
			id = 19030203,
			mobility = 2,
			pre_magicDef = 135,
			aiStepOrder = 0,
			trumpSkill = 1202804,
			isFuzzy = false,
			inspire = 48,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 48,
			modelId = 120028,
			magicDef = 135,
			specialSkill = 0,
			extraSkills = {
				1202803
			},
			attributeGrade = {
				"A",
				"B",
				"S",
				"C",
				"C"
			},
			tags = {}
		}
	}
}

return configData
