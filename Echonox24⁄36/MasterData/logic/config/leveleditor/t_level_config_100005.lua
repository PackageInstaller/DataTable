-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_100005.lua

module("logic.config.leveleditor.t_level_config_100005", package.seeall)

local configData = {
	battleMusicName = "music_battle_boss_01",
	remarks = "",
	levelId = "100005",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "不朽boss战",
	lossConditionDesc = "",
	sceneId = "190020",
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
			x = 3,
			y = 5
		},
		{
			direction = 2,
			x = 3,
			y = 6
		},
		{
			direction = 2,
			x = 3,
			y = 7
		},
		{
			direction = 2,
			x = 3,
			y = 4
		},
		{
			direction = 2,
			x = 2,
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
			color = 1,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 10000501,
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
	lockHeroList = {},
	monsters = {
		[10000501] = {
			normalSkill = 1202601,
			name = "永恒/枝桠",
			pre_magicAtk = 204,
			maxHp = 6066,
			aiName = "mob_active_ai",
			battleCamp = 1,
			career = 4,
			magicAtk = 204,
			pre_meleeDef = 51.5,
			sanity = 0,
			remark = "",
			giftSkill = 1202608,
			weakPointHpRate = 0.3,
			meleeDef = 51.5,
			level = 20,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 81.6,
			pre_meleeAtk = 81.6,
			pre_maxHp = 6066,
			colorType = 3,
			monsterType = 2,
			id = 10000501,
			mobility = 0,
			pre_magicDef = 81.6,
			aiStepOrder = 0,
			trumpSkill = 1202611,
			isFuzzy = false,
			inspire = 31.9,
			camp = 9,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = 1,
			monsterGroupEnum = 1,
			pre_inspire = 31.9,
			modelId = 120026,
			magicDef = 81.6,
			specialSkill = 1202610,
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
