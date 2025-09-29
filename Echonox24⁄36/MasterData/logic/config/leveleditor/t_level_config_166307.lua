-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_166307.lua

module("logic.config.leveleditor.t_level_config_166307", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "166307",
	plotEventGroup = 0,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 1,
	levelName = "新1教学7",
	lossConditionDesc = "",
	sceneId = "99000105",
	winConditionDesc = "利用治疗完成反击",
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
			y = 2
		},
		{
			direction = 2,
			x = 2,
			y = 2
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
					y = 2,
					tag = "",
					monsterId = 16630701,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 1,
					tag = "",
					monsterId = 16630701,
					x = 5,
					initialStatus = {
						hpPercent = 0,
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
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16630702,
			pos = {
				x = 2,
				y = 2
			},
			initialStatus = {
				hpPercent = 0.3,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 0,
			direction = 2,
			heroType = 2,
			monsterId = 16630703,
			pos = {
				x = 1,
				y = 2
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[16630701] = {
			normalSkill = 1740054,
			name = "迷雾使徒",
			pre_magicAtk = 82.6,
			maxHp = 135,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 3,
			magicAtk = 82.6,
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
			meleeAtk = 90,
			pre_meleeAtk = 90,
			pre_maxHp = 135,
			colorType = 3,
			monsterType = 0,
			id = 16630701,
			mobility = 2,
			pre_magicDef = 18.5,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 120008,
			magicDef = 18.5,
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
		[16630702] = {
			normalSkill = 1740052,
			name = "天文台调查员",
			pre_magicAtk = 206.4,
			maxHp = 94,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 4,
			magicAtk = 206.4,
			pre_meleeDef = 32.5,
			sanity = -1,
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
			pre_maxHp = 94,
			colorType = 1,
			monsterType = 0,
			id = 16630702,
			mobility = 2,
			pre_magicDef = 43,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 26.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 26.9,
			modelId = 120034,
			magicDef = 43,
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
		[16630703] = {
			normalSkill = 0,
			name = "阿妮亚",
			pre_magicAtk = 171.2,
			maxHp = 112.7,
			aiName = "mob_active_ai",
			battleCamp = 2,
			career = 6,
			magicAtk = 171.2,
			pre_meleeDef = 37.8,
			sanity = -1,
			remark = "",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 37.8,
			level = 10,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 82.6,
			pre_meleeAtk = 82.6,
			pre_maxHp = 112.7,
			colorType = 4,
			monsterType = 0,
			id = 16630703,
			mobility = 2,
			pre_magicDef = 43,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 17.9,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 17.9,
			modelId = 100053,
			magicDef = 43,
			specialSkill = 1740023,
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
