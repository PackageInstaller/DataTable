-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_130610.lua

module("logic.config.leveleditor.t_level_config_130610", package.seeall)

local configData = {
	battleMusicName = "music_battle_cailiao_block",
	remarks = "",
	levelId = "130610",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "特异材料本-10",
	lossConditionDesc = "",
	sceneId = "116001",
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
			y = 11
		},
		{
			direction = 2,
			x = 3,
			y = 5
		},
		{
			direction = 1,
			x = 9,
			y = 3
		},
		{
			direction = 3,
			x = 9,
			y = 10
		},
		{
			direction = 1,
			x = 5,
			y = 3
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
			monsterList = {}
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
					direction = 3,
					y = 5,
					tag = "",
					monsterId = 13061001,
					x = 7,
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
					direction = 1,
					y = 8,
					tag = "",
					monsterId = 13061002,
					x = 7,
					initialStatus = {
						hpPercent = 1,
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
		}
	},
	lockHeroList = {},
	trialHeroes = {},
	monsters = {
		[13061001] = {
			normalSkill = 1209301,
			name = "自裁气球",
			pre_magicAtk = 2254.6,
			maxHp = 65978.7,
			aiName = "ai_120093_自裁气球",
			battleCamp = 1,
			career = 4,
			magicAtk = 2254.6,
			pre_meleeDef = 550,
			sanity = 0,
			remark = "蓝特异精英-高难度（禁疗）",
			giftSkill = 1209302,
			weakPointHpRate = 0.3,
			meleeDef = 783,
			level = 90,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 225.5,
			pre_meleeAtk = 225.5,
			pre_maxHp = 67978.7,
			colorType = 2,
			monsterType = 1,
			id = 13061001,
			mobility = 2,
			pre_magicDef = 783,
			aiStepOrder = 1,
			trumpSkill = 1209304,
			isFuzzy = false,
			inspire = 77,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 120093,
			magicDef = 550,
			specialSkill = 0,
			extraSkills = {
				1209303
			},
			attributeGrade = {
				"C",
				"C",
				"S",
				"S",
				"C"
			},
			tags = {}
		},
		[13061002] = {
			normalSkill = 1206801,
			name = "噩梦圆规",
			pre_magicAtk = 2254.6,
			maxHp = 65978.7,
			aiName = "ai_120068_噩梦圆规",
			battleCamp = 1,
			career = 4,
			magicAtk = 2254.6,
			pre_meleeDef = 550,
			sanity = 0,
			remark = "红特异精英-高难度",
			giftSkill = 1206802,
			weakPointHpRate = 0.3,
			meleeDef = 783,
			level = 90,
			monsterGroup = "通用关卡",
			skipStep = false,
			hasGodlike = false,
			meleeAtk = 225.5,
			pre_meleeAtk = 225.5,
			pre_maxHp = 67978.7,
			colorType = 3,
			monsterType = 1,
			id = 13061002,
			mobility = 2,
			pre_magicDef = 783,
			aiStepOrder = 0,
			trumpSkill = 1206804,
			isFuzzy = false,
			inspire = 77,
			camp = 8,
			hasSanity = false,
			bodyEffect = "",
			weakPointColor = -1,
			monsterGroupEnum = 1,
			pre_inspire = 90,
			modelId = 120068,
			magicDef = 550,
			specialSkill = 0,
			extraSkills = {
				1206803
			},
			attributeGrade = {
				"C",
				"C",
				"S",
				"S",
				"C"
			},
			tags = {}
		}
	}
}

return configData
