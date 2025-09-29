-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110101.lua

module("logic.config.leveleditor.t_level_config_110101", package.seeall)

local configData = {
	battleMusicName = "music_battle_normal01_block",
	remarks = "",
	levelId = "110101",
	plotEventGroup = 0,
	maxPerson = 1,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "主线普通1-1",
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
			direction = 2,
			x = 5,
			y = 3
		},
		{
			direction = 2,
			x = 5,
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
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 3,
					tag = "",
					monsterId = 11010101,
					x = 8,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 11010101,
					x = 9,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 11010101,
					x = 11,
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
			isInitialStatus = false,
			heroId = 2000016,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 5,
				y = 3
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		},
		{
			isInitialStatus = false,
			heroId = 2000022,
			direction = 2,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 5,
				y = 2
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {
		[11010101] = {
			normalSkill = 1209001,
			name = "路障角兽",
			pre_magicAtk = 7.4,
			maxHp = 124,
			aiName = "mob_active_ai_freshman",
			battleCamp = 1,
			career = 2,
			magicAtk = 7.4,
			pre_meleeDef = 45.6,
			sanity = 0,
			remark = "守卫小怪（新手展示动画用）",
			giftSkill = 1209002,
			weakPointHpRate = 0,
			meleeDef = 45.6,
			level = 2,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 73.7,
			pre_meleeAtk = 73.7,
			pre_maxHp = 254.4,
			colorType = 2,
			monsterType = 0,
			id = 11010101,
			mobility = 2,
			pre_magicDef = 20.8,
			aiStepOrder = 2,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 21,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 21,
			modelId = 120090,
			magicDef = 20.8,
			specialSkill = 1209004,
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
