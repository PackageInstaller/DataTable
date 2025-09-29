-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_190402.lua

module("logic.config.leveleditor.t_level_config_190402", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "援护体验难度2",
	levelId = "190402",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 4,
	levelName = "援护体验难度2",
	lossConditionDesc = "",
	sceneId = "111002",
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
			direction = 3,
			x = 7,
			y = 12
		},
		{
			direction = 3,
			x = 8,
			y = 13
		},
		{
			direction = 3,
			x = 5,
			y = 12
		},
		{
			direction = 3,
			x = 6,
			y = 13
		},
		{
			direction = 3,
			x = 9,
			y = 12
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
					round = 4,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 2,
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
		1721914
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
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 19040201,
					x = 5,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 3,
					tag = "",
					monsterId = 19040201,
					x = 8,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 4,
					tag = "",
					monsterId = 19040201,
					x = 6,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 19040201,
					x = 5,
					initialStatus = {
						hpPercent = 1,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 1,
					y = 5,
					tag = "",
					monsterId = 19040201,
					x = 8,
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
		[19040201] = {
			normalSkill = 1721910,
			name = "疯狂车轴",
			pre_magicAtk = 47.2,
			maxHp = 55983.9,
			aiName = "ai_援护体验本",
			battleCamp = 1,
			career = 5,
			magicAtk = 47.2,
			pre_meleeDef = 216,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 679,
			level = 40,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 1579.6,
			pre_meleeAtk = 471.7,
			pre_maxHp = 2150.3,
			colorType = 4,
			monsterType = 0,
			id = 19040201,
			mobility = 1,
			pre_magicDef = 144,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 55,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 55,
			modelId = 120069,
			magicDef = 679,
			specialSkill = 0,
			extraSkills = {},
			attributeGrade = {
				"A",
				"S",
				"S",
				"C",
				"S"
			},
			tags = {}
		}
	}
}

return configData
