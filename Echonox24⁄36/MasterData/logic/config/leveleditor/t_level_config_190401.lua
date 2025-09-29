-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_190401.lua

module("logic.config.leveleditor.t_level_config_190401", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "援护体验难度1",
	levelId = "190401",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 270,
	maxRound = 10,
	levelName = "援护体验难度1",
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
					round = 3,
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
					monsterId = 19040101,
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
					monsterId = 19040101,
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
					monsterId = 19040101,
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
					monsterId = 19040101,
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
					monsterId = 19040101,
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
		[19040101] = {
			normalSkill = 1721910,
			name = "疯狂车轴",
			pre_magicAtk = 23.7,
			maxHp = 41126.5,
			aiName = "ai_援护体验本",
			battleCamp = 1,
			career = 5,
			magicAtk = 23.7,
			pre_meleeDef = 112.5,
			sanity = 0,
			remark = "陨灭小怪（具有3层及以上的轰鸣时；主动攻击必定暴击）",
			giftSkill = 0,
			weakPointHpRate = 0,
			meleeDef = 579,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 423.4,
			pre_meleeAtk = 236.7,
			pre_maxHp = 869.9,
			colorType = 4,
			monsterType = 1,
			id = 19040101,
			mobility = 1,
			pre_magicDef = 80.1,
			aiStepOrder = 1,
			trumpSkill = 0,
			isFuzzy = false,
			inspire = 46,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 46,
			modelId = 120069,
			magicDef = 579,
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
