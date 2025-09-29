-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_150038.lua

module("logic.config.leveleditor.t_level_config_150038", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "150038",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "爬塔明面38",
	lossConditionDesc = "",
	sceneId = "116004",
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
			x = 5,
			y = 7
		},
		{
			direction = 2,
			x = 5,
			y = 6
		},
		{
			direction = 2,
			x = 6,
			y = 7
		},
		{
			direction = 2,
			x = 6,
			y = 6
		},
		{
			direction = 2,
			x = 5,
			y = 5
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
					direction = 1,
					y = 2,
					tag = "",
					monsterId = 15003801,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15003801,
					x = 5,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 7,
					tag = "",
					monsterId = 15003802,
					x = 7,
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
					monsterId = 15003802,
					x = 7,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 15003802,
					x = 7,
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
					monsterId = 15003803,
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
			refreshType = 2,
			form = 2,
			plotStr = "",
			round = 3,
			hasSymbol = false,
			groupName = "怪物组2",
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 1,
					y = 1,
					tag = "",
					monsterId = 15003804,
					x = 6,
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
					monsterId = 15003804,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 3,
					y = 11,
					tag = "",
					monsterId = 15003804,
					x = 6,
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
					monsterId = 15003804,
					x = 6,
					initialStatus = {
						hpPercent = 100,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 6,
			y = 11
		},
		{
			x = 6,
			y = 2
		}
	},
	lockHeroList = {},
	monsters = {
		[15003801] = {
			normalSkill = 1206901,
			name = "疯狂车轴",
			pre_magicAtk = 70.5,
			maxHp = 4032.2,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 5,
			magicAtk = 70.5,
			pre_meleeDef = 308.7,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 1206903,
			weakPointHpRate = 0,
			meleeDef = 308.7,
			level = 53,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 704.4,
			pre_meleeAtk = 704.4,
			pre_maxHp = 4032.2,
			colorType = 4,
			monsterType = 0,
			id = 15003801,
			mobility = 1,
			pre_magicDef = 225.4,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 61.8,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 61.8,
			modelId = 120069,
			magicDef = 225.4,
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
		[15003802] = {
			normalSkill = 1202801,
			name = "枯荣/孵化",
			pre_magicAtk = 65.6,
			maxHp = 5635,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 2,
			magicAtk = 65.6,
			pre_meleeDef = 346,
			sanity = 0,
			remark = "守卫小怪（受到攻击后触发振荡；振荡附带群体衰退）",
			giftSkill = 1202802,
			weakPointHpRate = 0,
			meleeDef = 346,
			level = 53,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 655.8,
			pre_meleeAtk = 655.8,
			pre_maxHp = 5635,
			colorType = 2,
			monsterType = 0,
			id = 15003802,
			mobility = 2,
			pre_magicDef = 193.9,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 51.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 51.8,
			modelId = 120028,
			magicDef = 193.9,
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
		[15003803] = {
			normalSkill = 1203001,
			name = "惑形/毒蛞",
			pre_magicAtk = 72.3,
			maxHp = 3923.3,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 72.3,
			pre_meleeDef = 296.8,
			sanity = 0,
			remark = "狙击小怪（弧光；弧光可弹射重复目标且施加1层[衰退）",
			giftSkill = 1203002,
			weakPointHpRate = 0,
			meleeDef = 296.8,
			level = 53,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 722.6,
			pre_meleeAtk = 722.6,
			pre_maxHp = 3923.3,
			colorType = 3,
			monsterType = 0,
			id = 15003803,
			mobility = 2,
			pre_magicDef = 194.8,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 71.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 71.8,
			modelId = 120030,
			magicDef = 194.8,
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
		[15003804] = {
			normalSkill = 1208901,
			name = "花剑雨伞",
			pre_magicAtk = 68.6,
			maxHp = 4548,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 1,
			magicAtk = 68.6,
			pre_meleeDef = 322.7,
			sanity = 0,
			remark = "幻影小怪（主动攻击时追击）",
			giftSkill = 1208903,
			weakPointHpRate = 0,
			meleeDef = 322.7,
			level = 53,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 686.2,
			pre_meleeAtk = 686.2,
			pre_maxHp = 4548,
			colorType = 1,
			monsterType = 0,
			id = 15003804,
			mobility = 4,
			pre_magicDef = 193,
			aiStepOrder = 3,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 61.8,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 61.8,
			modelId = 120089,
			magicDef = 193,
			specialSkill = 1208902,
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
