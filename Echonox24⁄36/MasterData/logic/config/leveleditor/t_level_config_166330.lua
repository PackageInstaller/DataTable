-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166330.lua

module("logic.config.leveleditor.t_level_config_166330", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166330",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新2教学10",
	lossConditionDesc = "",
	sceneId = "99000204",
	winConditionDesc = "利用高昂打出暴击",
	forbidAction = {
		auto = true,
		move = false,
		strengthenSkill = true,
		useSpecifyTypeSkill = {},
		useSpecifyPurposeSkill = {}
	},
	bornPosList = {
		{
			direction = 2,
			x = 1,
			y = 1
		},
		{
			direction = 2,
			x = 2,
			y = 0
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
			condition = 3,
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
					y = 1,
					tag = "",
					monsterId = 16633001,
					x = 3,
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
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16633002,
			pos = {
				x = 1,
				y = 1
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16633003,
			pos = {
				x = 2,
				y = 0
			},
			initialStatus = {
				hpPercent = 100,
				buffList = {}
			}
		}
	},
	monsters = {
		[16633001] = {
			normalSkill = 1740054,
			name = "迷雾使徒",
			pre_magicAtk = 10.8,
			maxHp = 120,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 10.8,
			pre_meleeDef = 51.2,
			sanity = 0,
			remark = "狙击小怪",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 51.2,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 300,
			pre_meleeAtk = 108.5,
			pre_maxHp = 248.5,
			colorType = 3,
			monsterType = 0,
			id = 16633001,
			mobility = 2,
			pre_magicDef = 28.8,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 40.5,
			camp = 7,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.5,
			modelId = 120008,
			magicDef = 28.8,
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
		[16633002] = {
			normalSkill = 1740034,
			name = "林鸮",
			pre_magicAtk = 113.2,
			maxHp = 99,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 113.2,
			pre_meleeDef = 33.6,
			sanity = -1,
			remark = "",
			giftSkill = 1740036,
			weakPointHpRate = 0,
			meleeDef = 33.6,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 11.3,
			pre_meleeAtk = 11.3,
			pre_maxHp = 213.7,
			colorType = 4,
			monsterType = 0,
			id = 16633002,
			mobility = 2,
			pre_magicDef = 57.6,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 25.5,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 25.5,
			modelId = 100010,
			magicDef = 57.6,
			specialSkill = 1740035,
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
		[16633003] = {
			normalSkill = 1740017,
			name = "安妮薇",
			pre_magicAtk = 116.8,
			maxHp = 99,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 116.8,
			pre_meleeDef = 28.8,
			sanity = -1,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 28.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 11.7,
			pre_meleeAtk = 11.7,
			pre_maxHp = 208.8,
			colorType = 3,
			monsterType = 0,
			id = 16633003,
			mobility = 2,
			pre_magicDef = 51.2,
			aiStepOrder = 0,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 43,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 45.5,
			modelId = 100013,
			magicDef = 51.2,
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
		}
	}
}

return configData
