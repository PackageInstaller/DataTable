-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_100102.lua

module("logic.config.leveleditor.t_level_config_100102", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "空气工坊02",
	levelId = "100102",
	plotEventGroup = 0,
	maxPerson = 5,
	initRotationOffSet = 90,
	maxRound = 10,
	levelName = "街心公园",
	lossConditionDesc = "",
	sceneId = "111005",
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
			x = 2,
			y = 3
		},
		{
			direction = 1,
			x = 4,
			y = 4
		},
		{
			direction = 1,
			x = 3,
			y = 3
		},
		{
			direction = 1,
			x = 4,
			y = 3
		},
		{
			direction = 1,
			x = 3,
			y = 4
		},
		{
			direction = 1,
			x = 2,
			y = 4
		},
		{
			direction = 1,
			x = 4,
			y = 5
		},
		{
			direction = 1,
			x = 3,
			y = 5
		},
		{
			direction = 1,
			x = 2,
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
	monsterGroupList = {},
	cameraWalkCells = {},
	lockHeroList = {},
	monsters = {}
}

return configData
