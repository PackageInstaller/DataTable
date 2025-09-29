-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/leveleditor/t_level_config_2333.lua

module("logic.config.leveleditor.t_level_config_2333", package.seeall)

local configData = {
	battleMusicName = "",
	remarks = "",
	levelId = "2333",
	plotEventGroup = 3,
	maxPerson = 2,
	initRotationOffSet = 0,
	maxRound = 10,
	levelName = "测试关卡",
	lossConditionDesc = "",
	sceneId = "2112",
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
			x = 1,
			y = 0
		},
		{
			direction = 2,
			x = 0,
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
					round = 5,
					heroId = 0,
					count = 0,
					monsterTag = "",
					DIYName = "",
					condition = 2,
					monsterIds = {}
				},
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
		},
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
					isInitialStatus = true,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 0,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {
							{
								round = 2,
								buffId = 1,
								layer = 1
							}
						}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 0,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 4,
			form = 5,
			plotStr = "12354",
			round = 1,
			hasSymbol = false,
			groupName = "怪物组2",
			color = 3,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 0,
					x = 3,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 8,
					tag = "",
					monsterId = 0,
					x = 5,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		},
		{
			symbolStr = "",
			refreshType = 2,
			form = 4,
			plotStr = "",
			round = 2,
			hasSymbol = false,
			groupName = "怪物组3",
			color = 2,
			enemyCountY = 0,
			enemyCountX = 0,
			monsterList = {
				{
					isInitialStatus = true,
					direction = 4,
					y = 2,
					tag = "",
					monsterId = 0,
					x = 2,
					initialStatus = {
						hpPercent = 1,
						buffList = {
							{
								round = 54,
								buffId = 5444,
								layer = 1
							}
						}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 4,
					tag = "",
					monsterId = 0,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				},
				{
					isInitialStatus = false,
					direction = 4,
					y = 5,
					tag = "",
					monsterId = 0,
					x = 4,
					initialStatus = {
						hpPercent = 0,
						buffList = {}
					}
				}
			}
		}
	},
	cameraWalkCells = {
		{
			x = 21,
			y = 35
		}
	},
	lockHeroList = {
		{
			isInitialStatus = true,
			heroId = 1,
			direction = 2,
			heroType = 2,
			monsterId = 1,
			pos = {
				x = 0,
				y = 0
			},
			initialStatus = {
				hpPercent = 1,
				buffList = {
					{
						round = 2,
						buffId = 122,
						layer = 1
					},
					{
						round = 1,
						buffId = 123,
						layer = 1
					}
				}
			}
		},
		{
			isInitialStatus = false,
			heroId = 1,
			direction = 2,
			heroType = 1,
			monsterId = 1,
			pos = {
				x = 0,
				y = 0
			},
			initialStatus = {
				hpPercent = 0,
				buffList = {}
			}
		}
	},
	monsters = {}
}

return configData
