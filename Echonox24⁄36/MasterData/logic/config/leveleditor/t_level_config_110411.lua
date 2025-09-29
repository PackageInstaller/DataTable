-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110411.lua

module("logic.config.leveleditor.t_level_config_110411", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal02_block",
	remarks = "",
	levelId = "110411",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 180,
	maxRound = 10,
	levelName = "主线普通4-11",
	lossConditionDesc = "",
	sceneId = "112002",
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
			x = 5,
			y = 8
		},
		{
			direction = 1,
			x = 6,
			y = 8
		},
		{
			direction = 2,
			x = 6,
			y = 7
		},
		{
			direction = 3,
			x = 5,
			y = 6
		},
		{
			direction = 3,
			x = 6,
			y = 6
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
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 11041103,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 12,
					tag = "",
					monsterId = 11041103,
					x = 6,
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
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 11041103,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 11041105,
					x = 7,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组3",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 2,
					y = 8,
					tag = "",
					monsterId = 11041102,
					x = 1,
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
					monsterId = 11041102,
					x = 1,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 6,
					tag = "",
					monsterId = 11041102,
					x = 8,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 11041102,
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
			form = 2,
			plotStr = "",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组4",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 11041101,
					x = 10,
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
		[11041101] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 60.8,
			maxHp = 3270.9,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 60.8,
			pre_meleeDef = 270.9,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 270.9,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 607.9,
			pre_meleeAtk = 607.9,
			pre_maxHp = 3270.9,
			colorType = 4,
			monsterType = 0,
			id = 11041101,
			mobility = 1,
			pre_magicDef = 193.5,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 60,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 60,
			modelId = 120069,
			magicDef = 193.5,
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
		},
		[11041102] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 693.9,
			maxHp = 2678.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 693.9,
			pre_meleeDef = 165.6,
			sanity = 0,
			remark = "红特异小怪（主动攻击触发超感）",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 165.6,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 69.4,
			pre_meleeAtk = 69.4,
			pre_maxHp = 2678.7,
			colorType = 1,
			monsterType = 0,
			id = 11041102,
			mobility = 2,
			pre_magicDef = 260.1,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120068,
			magicDef = 260.1,
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
		[11041103] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 693.9,
			maxHp = 2678.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 693.9,
			pre_meleeDef = 165.6,
			sanity = 0,
			remark = "蓝特异小怪",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 165.6,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 69.4,
			pre_meleeAtk = 69.4,
			pre_maxHp = 2678.7,
			colorType = 2,
			monsterType = 0,
			id = 11041103,
			mobility = 2,
			pre_magicDef = 260.1,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120068,
			magicDef = 260.1,
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
		[11041104] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 693.9,
			maxHp = 2678.7,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 693.9,
			pre_meleeDef = 165.6,
			sanity = 0,
			remark = "绿特异小怪",
			giftSkill = 1206802,
			weakPointHpRate = 0,
			meleeDef = 165.6,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 69.4,
			pre_meleeAtk = 69.4,
			pre_maxHp = 2678.7,
			colorType = 3,
			monsterType = 0,
			id = 11041104,
			mobility = 2,
			pre_magicDef = 260.1,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 70,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 70,
			modelId = 120068,
			magicDef = 260.1,
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
		[11041105] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 761.1,
			maxHp = 17178.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 761.1,
			pre_meleeDef = 184,
			sanity = 0,
			remark = "绿特异精英（主动攻击触发超感；超感强化）",
			giftSkill = 1206802,
			weakPointHpRate = 0.3,
			meleeDef = 184,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 76.1,
			pre_meleeAtk = 76.1,
			pre_maxHp = 17178.6,
			colorType = 3,
			monsterType = 1,
			id = 11041105,
			mobility = 2,
			pre_magicDef = 289,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 73,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 73,
			modelId = 120068,
			magicDef = 289,
			specialSkill = 1206803,
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
		[11041106] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 761.1,
			maxHp = 17178.6,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 761.1,
			pre_meleeDef = 184,
			sanity = 0,
			remark = "蓝特异精英（主动攻击触发超感；超感强化）",
			giftSkill = 1206802,
			weakPointHpRate = 0.3,
			meleeDef = 184,
			level = 50,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 76.1,
			pre_meleeAtk = 76.1,
			pre_maxHp = 17178.6,
			colorType = 2,
			monsterType = 1,
			id = 11041106,
			mobility = 2,
			pre_magicDef = 289,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 73,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 3,
			monsterGroupEnum = 1,
			pre_inspire = 73,
			modelId = 120068,
			magicDef = 289,
			specialSkill = 1206803,
			extraSkills = {},
			attributeGrade = {
				"S",
				"C",
				"C",
				"S",
				"S"
			},
			tags = {}
		}
	}
}

return configData
