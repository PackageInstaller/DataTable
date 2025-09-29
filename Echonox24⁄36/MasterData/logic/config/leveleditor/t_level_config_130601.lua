-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130601.lua

module("logic.config.leveleditor.t_level_config_130601", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130601",
	plotEventGroup = 0,
	maxPerson = 3,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "特异材料本-1",
	lossConditionDesc = "",
	sceneId = "116003",
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
			y = 5
		},
		{
			direction = 4,
			x = 7,
			y = 9
		},
		{
			direction = 2,
			x = 9,
			y = 10
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
					DIYName = "10回合内击杀所有来袭密室原体",
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
			groupName = "怪物-红色",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 11,
					tag = "",
					monsterId = 13060102,
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
			refreshType = 1,
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物-蓝色",
			color = 4,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 13060103,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 2,
					y = 6,
					tag = "",
					monsterId = 13060103,
					x = 4,
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
			groupName = "怪物-绿色",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 13060104,
					x = 12,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 13060104,
					x = 13,
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
			x = 8,
			y = 7
		},
		{
			x = 9,
			y = 5
		}
	},
	lockHeroList = {
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 13060101,
			pos = {
				x = 9,
				y = 5
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	trialHeroes = {},
	monsters = {
		[13060101] = {
			normalSkill = 1101301,
			name = "安妮薇",
			pre_magicAtk = 155.3,
			maxHp = 484.5,
			aiName = "auto_anniwei_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 155.3,
			pre_meleeDef = 37.9,
			sanity = 0,
			remark = "",
			giftSkill = 1101304,
			weakPointHpRate = 0,
			meleeDef = 37.9,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 35.2,
			pre_meleeAtk = 35.2,
			pre_maxHp = 484.5,
			colorType = 1,
			monsterType = 0,
			id = 13060101,
			mobility = 2,
			pre_magicDef = 67.9,
			aiStepOrder = 2,
			trumpSkill = 1101303,
			isFuzzy = false,
			inspire = 48.1,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 48.1,
			modelId = 100013,
			magicDef = 67.9,
			specialSkill = 1101302,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"A",
				"A"
			},
			tags = {}
		},
		[13060102] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 96.2,
			maxHp = 153,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 96.2,
			pre_meleeDef = 24,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 42.4,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 9.6,
			pre_meleeAtk = 9.6,
			pre_maxHp = 172.6,
			colorType = 1,
			monsterType = 0,
			id = 13060102,
			mobility = 2,
			pre_magicDef = 42.4,
			aiStepOrder = 10,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 42.5,
			modelId = 120029,
			magicDef = 24,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"A",
				"S",
				"C"
			},
			tags = {}
		},
		[13060103] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 96.2,
			maxHp = 153,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 96.2,
			pre_meleeDef = 24,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 42.4,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 9.6,
			pre_meleeAtk = 9.6,
			pre_maxHp = 172.6,
			colorType = 2,
			monsterType = 0,
			id = 13060103,
			mobility = 2,
			pre_magicDef = 42.4,
			aiStepOrder = 20,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 42.5,
			modelId = 120029,
			magicDef = 24,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"A",
				"S",
				"C"
			},
			tags = {}
		},
		[13060104] = {
			normalSkill = 1202901,
			name = "惑形/蜉蝣",
			pre_magicAtk = 96.2,
			maxHp = 153,
			aiName = "ai-特异本-小怪",
			battleCamp = 1,
			career = 4,
			magicAtk = 96.2,
			pre_meleeDef = 24,
			sanity = 0,
			remark = "",
			giftSkill = 1202902,
			weakPointHpRate = 0,
			meleeDef = 42.4,
			level = 5,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 9.6,
			pre_meleeAtk = 9.6,
			pre_maxHp = 172.6,
			colorType = 3,
			monsterType = 0,
			id = 13060104,
			mobility = 2,
			pre_magicDef = 42.4,
			aiStepOrder = 30,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 22,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 42.5,
			modelId = 120029,
			magicDef = 24,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"C",
				"C",
				"A",
				"S",
				"C"
			},
			tags = {}
		}
	}
}

return configData
