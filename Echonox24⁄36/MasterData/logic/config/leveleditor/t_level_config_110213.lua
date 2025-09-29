-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_110213.lua

module("logic.config.leveleditor.t_level_config_110213", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "110213",
	plotEventGroup = 110213,
	maxPerson = 1,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "主线普通2-13",
	lossConditionDesc = "",
	sceneId = "112001",
	winConditionDesc = "引导烟火到达出口",
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
			x = 3,
			y = 7
		}
	},
	additionalTerrainList = {
		{
			terrainId = 1011,
			times = 0,
			posList = {
				{
					x = 3,
					y = 8
				},
				{
					x = 4,
					y = 8
				},
				{
					x = 3,
					y = 6
				},
				{
					x = 4,
					y = 6
				},
				{
					x = 6,
					y = 8
				},
				{
					x = 6,
					y = 7
				},
				{
					x = 6,
					y = 6
				},
				{
					x = 9,
					y = 9
				},
				{
					x = 9,
					y = 8
				},
				{
					x = 9,
					y = 7
				},
				{
					x = 9,
					y = 6
				},
				{
					x = 9,
					y = 5
				}
			}
		},
		{
			terrainId = 1005,
			times = 0,
			posList = {
				{
					x = 12,
					y = 8
				},
				{
					x = 11,
					y = 8
				},
				{
					x = 11,
					y = 7
				},
				{
					x = 11,
					y = 6
				},
				{
					x = 12,
					y = 6
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
					DIYName = "",
					condition = 9,
					monsterIds = {
						11021301
					}
				}
			}
		}
	},
	lossConditionList = {
		{
			condition = 2,
			maxDeadCount = 0,
			count = 0,
			hasTag = false,
			DIYName = "",
			isBackup = false,
			tag = "",
			targetId = 11021301,
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
					isInitialStatus = true,
					direction = 2,
					y = 7,
					tag = "",
					monsterId = 11021301,
					x = 1,
					initialStatus = {
						hpPercent = 0.1,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 11,
			y = 7
		},
		{
			x = 8,
			y = 7
		},
		{
			x = 1,
			y = 7
		}
	},
	lockHeroList = {
		{
			isInitialStatus = true,
			heroId = 2000022,
			direction = 4,
			heroType = 1,
			monsterId = 0,
			pos = {
				x = 3,
				y = 7
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 99,
						buffId = 11009,
						layer = 1
					}
				}
			}
		}
	},
	monsters = {
		[11021301] = {
			normalSkill = 1101601,
			name = "烟火",
			pre_magicAtk = 32.4,
			maxHp = 2503.4,
			aiName = "ai_2-13烟火",
			battleCamp = 3,
			career = 1,
			magicAtk = 32.4,
			pre_meleeDef = 198,
			sanity = 0,
			remark = "",
			giftSkill = 1101604,
			weakPointHpRate = 0,
			meleeDef = 198,
			level = 25,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 323.6,
			pre_meleeAtk = 323.6,
			pre_maxHp = 2503.4,
			colorType = 1,
			monsterType = 0,
			id = 11021301,
			mobility = 4,
			pre_magicDef = 89,
			aiStepOrder = 4,
			trumpSkill = 1101603,
			isFuzzy = false,
			inspire = 50,
			camp = 1,
			hasSanity = true,
			bodyEffect = "",
			weakPointColor = 0,
			monsterGroupEnum = 1,
			pre_inspire = 50,
			modelId = 100016,
			magicDef = 89,
			specialSkill = 1101602,
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
