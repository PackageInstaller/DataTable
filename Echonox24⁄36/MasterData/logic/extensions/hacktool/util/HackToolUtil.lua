-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/util/HackToolUtil.lua

module("logic.extensions.hacktool.util.HackToolUtil", package.seeall)

local GMCmdEnum = GameEnum.GMCmdEnum

function createAddItemCmd(itemList)
	local info = {
		cmd = GMCmdEnum.AddItemCmd,
		value = {}
	}

	for k, v in ipairs(itemList or {}) do
		table.insert(info.value, {
			itemId = tonumber(v.itemId),
			num = tonumber(v.num) or 1
		})
	end

	return info
end

function createReduceItemCmd(itemList)
	local info = {
		cmd = GMCmdEnum.ReduceItemCmd,
		value = {}
	}

	for k, v in ipairs(itemList or {}) do
		table.insert(info.value, {
			uuid = v.uuid,
			itemId = tonumber(v.itemId),
			reduce = tonumber(v.num) or 1
		})
	end

	return info
end

function createClearItemCmd(clearTypes)
	local info = {
		cmd = GMCmdEnum.ItemClear,
		value = {}
	}

	for k, v in ipairs(clearTypes or {}) do
		table.insert(info.value, {
			backType = v
		})
	end

	return info
end

function createAddEquipmentCmd(itemId, num, level, rank)
	local info = {
		cmd = GMCmdEnum.AddEquipment,
		value = {}
	}

	table.insert(info.value, {
		itemId = itemId,
		num = num,
		level = level,
		rank = rank
	})

	return info
end

function createAddEchoCmd(itemId, num, level)
	local info = {
		cmd = GMCmdEnum.AddEcho,
		value = {}
	}

	table.insert(info.value, {
		itemId = itemId,
		num = num,
		level = level
	})

	return info
end

function createAddNormalHerosCmd()
	local info = {
		cmd = GMCmdEnum.AddNormalHeros,
		value = {}
	}

	return info
end

function createAddAllFullHerosCmd()
	local info = {
		cmd = GMCmdEnum.AddFullHeros,
		value = {}
	}

	return info
end

function createHeroFullAllCmd()
	local info = {
		cmd = GMCmdEnum.HeroFullAll,
		value = {}
	}

	return info
end

function createDeleteHeroCmd(heroId)
	local info = {
		cmd = GMCmdEnum.DelHero,
		value = {}
	}

	table.insert(info.value, {
		hero = heroId
	})

	return info
end

function createDeleteAllHeroCmd()
	local info = {
		cmd = GMCmdEnum.DelAllHero,
		value = {}
	}

	return info
end

function createAddHeroAbsoluteCmd(heroId, level, breakLv, tacit, powerNodeId)
	local info = {
		cmd = GMCmdEnum.AddHeroAbsolute,
		value = {}
	}

	table.insert(info.value, {
		heroMark = heroId,
		level = level,
		breakLv = breakLv,
		tacit = tacit,
		powerNodeId = powerNodeId
	})

	return info
end

function createResetHeroCmd(heroId)
	local info = {
		cmd = GMCmdEnum.HeroReset,
		value = {}
	}

	table.insert(info.value, {
		hero = heroId
	})

	return info
end

function createLotteryCmd1(pool, count)
	local info = {
		cmd = GMCmdEnum.DummyLottery1,
		value = {}
	}

	table.insert(info.value, {
		pool = pool,
		count = count
	})

	return info
end

function createLotteryCmd2(pool, userCount, lotteryCount)
	local info = {
		cmd = GMCmdEnum.DummyLottery2,
		value = {}
	}

	table.insert(info.value, {
		pool = pool,
		userCount = userCount,
		lotteryCount = lotteryCount
	})

	return info
end

function createLotteryCmd3(pool, count)
	local info = {
		cmd = GMCmdEnum.DummyLottery3,
		value = {}
	}

	table.insert(info.value, {
		pool = pool,
		count = count
	})

	return info
end

function cleanlotteryLog()
	local info = {
		cmd = GMCmdEnum.ClearLotteryGuarantee,
		value = {}
	}

	return info
end

function createStartBattleLevel(dungeonCode)
	local info = {
		cmd = GMCmdEnum.StartDungeonLevel,
		value = {
			code = dungeonCode
		}
	}

	return info
end

function createAddHouseExp(addNum)
	local info = {
		cmd = GMCmdEnum.AddHouseExp,
		value = {
			addExp = addNum
		}
	}

	return info
end

function createFinishTask(taskId)
	local info = {
		cmd = GMCmdEnum.FinishTask,
		value = {
			id = taskId
		}
	}

	return info
end

function resetTask(type, taskId)
	local info = {
		cmd = GMCmdEnum.ResetTask,
		value = {
			type = type,
			id = taskId
		}
	}

	return info
end

function createAddTacitExp(heroId, addExp)
	local info = {
		cmd = GMCmdEnum.AddTacitExp,
		value = {
			heroId = heroId,
			addExp = addExp
		}
	}

	return info
end

function resetTacit(heroId)
	local info = {
		cmd = GMCmdEnum.ResetTacit,
		value = {
			heroId = heroId
		}
	}

	return info
end

function createPassAllFB()
	local info = {
		cmd = GMCmdEnum.PassAllDungeons,
		value = {}
	}

	return info
end

function createUnlockAllGuide()
	local info = {
		cmd = GMCmdEnum.PassAllGuide,
		value = {}
	}

	return info
end

function createUnlockAllThought()
	local info = {
		cmd = 528,
		value = {}
	}

	return info
end

function requireConfig(fileName)
	if package.loaded[fileName] then
		package.loaded[fileName] = nil

		LuaResLoader.ReplaceLuaScript(fileName)
	end

	return require(fileName)
end

function sendLogout()
	if PlayerModel.instance:getId() ~= "0" then
		UserAgent.instance:sendLogoutRequest()
	end
end

function previewHousePerform(performId)
	local pathPrefix = "logic.config.t_"
	local name = "house_perform"
	local f, ret = xpcall(function()
		local fileName = pathPrefix .. name

		package.loaded[fileName] = nil

		LuaResLoader.ReplaceLuaScript(fileName)

		local content = require(fileName)

		HouseConfig.instance:handleConfig(name, content)
		HouseEditorHelper.instance:showPerform(performId)
	end, debug.traceback)

	if not f then
		printError(ret)
	end
end

function previewRoleClip(clipType, modelCode, strArray, numArray, modelCode2)
	local f, ret = xpcall(function()
		CharacterCutFacade.instance:showRoleClip(clipType, modelCode, strArray, numArray, modelCode2)
	end, debug.traceback)

	if not f then
		printError(ret)
	end
end

function previewFurniturePerform(performId, characterIds)
	local pathPrefix = "logic.config.t_"
	local name = "furniture_perform"
	local f, ret = xpcall(function()
		local fileName = pathPrefix .. name

		package.loaded[fileName] = nil

		LuaResLoader.ReplaceLuaScript(fileName)

		local content = require(fileName)

		HouseConfig.instance:handleConfig(name, content)

		characterIds = string.split(characterIds, ",")

		local heroList = {}

		for _, id in ipairs(characterIds) do
			table.insert(heroList, tonumber(id))
		end

		HouseEditorHelper.instance:showFurniturePerform(performId, heroList)
	end, debug.traceback)

	if not f then
		printError(ret)
	end
end

function previewPlot(plotId, stepId)
	StoryMgr.instance:clearStep()

	local pathPrefix = "logic.config.t_"
	local name = "story_" .. plotId
	local f, ret = xpcall(function()
		StoryMgr.instance:previewInEditor()
		StoryMgr.instance:startSingle(plotId, stepId)
	end, debug.traceback)

	if not f then
		printError(ret)
	end
end

function createHeroLevelAndPower(power)
	return {
		cmd = GMCmdEnum.HeroLevelAndPower,
		value = {
			powerNode = power
		}
	}
end

function createDeletGuide(guidelist)
	return {
		cmd = GMCmdEnum.DeleteGuide,
		value = {
			codes = guidelist
		}
	}
end
