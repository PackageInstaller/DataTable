-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/task/util/TaskUtil.lua

module("logic.extensions.task.util.TaskUtil", package.seeall)

function TaskUtil.parseContent(code, param, args)
	local desc = ""
	local needCount = false
	local isTaskGroup = false
	local sideTips = false
	local dataCO = TaskConfig.instance:getStatisticsCO(code)

	if dataCO then
		if string.nilorempty(dataCO.program) and enableErrorLog then
			printError("Invalid parameter,program is nil with code:", code)
		end

		local className = "Task" .. dataCO.program
		local implClass = _G[className]

		if className == "TaskFinishSubAnd" or className == "TaskFinishSubOr" then
			isTaskGroup = true
		end

		if implClass then
			desc, needCount, sideTips, isTaskGroup = implClass:parseContent(code, dataCO.desc, param, args)
		else
			desc, needCount = TaskDefault:parseContent(code, dataCO.desc, param, args)

			printWarn("使用默认代码，因为缺少对应的代码段", dataCO.program)
		end
	end

	return desc, needCount, isTaskGroup, sideTips
end

function TaskUtil.getFinishCount(list)
	local count = 0

	if list then
		for index, taskMo in ipairs(list) do
			if taskMo:getIsFinish() or taskMo:canGetReward() then
				count = count + 1
			end
		end
	end

	return count
end

function TaskUtil.getDungeonFormatName(dungeonId)
	local dungeonName = ""
	local dungeonCo = DungeonConfig.instance:getDungeonCfgById(dungeonId)

	if dungeonCo then
		if dungeonCo.type == CommEnum.DungeonType.Mainline then
			local difficultyDesc = DungeonEnum.MainLineDiffName[DungeonEnum.Difficulty.Easy]
			local mainlineCO = DungeonConfig.instance:getCfgMainLineChapterIncludePlot(dungeonId)

			if mainlineCO then
				difficultyDesc = DungeonEnum.MainLineDiffName[mainlineCO.difficulty]
			else
				printError("Mainline dungeon config is not found, id ", dungeonId)
			end

			dungeonName = langF("task_mainline_dungeon_format_name", difficultyDesc, dungeonCo.index)
		elseif dungeonCo.type == CommEnum.DungeonType.LightTower then
			dungeonName = langF("task_lighttow_dungeon_format_name", dungeonCo.index)
		elseif dungeonCo.type == CommEnum.DungeonType.DarkTower then
			dungeonName = langF("task_darktow_dungeon_format_name", dungeonCo.index)
		else
			dungeonName = langF("task_common_dungeon_format_name", DungeonConfig.instance:getDungeonTypeName(dungeonCo.type), dungeonCo.index)
		end
	end

	return dungeonName
end

return TaskUtil
