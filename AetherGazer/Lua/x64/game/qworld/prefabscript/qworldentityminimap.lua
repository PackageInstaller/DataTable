QWorldEntityMiniMapTag = {
	Common = 1,
	Hud = 2,
	Thing = 3,
	Task = 4
}
QWorldMiniMapBoardInfo = class("QWorldMiniMapBoardInfo")

function QWorldMiniMapBoardInfo.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.inst = arg_1_1
	arg_1_0.tag = arg_1_2
	arg_1_0.param = arg_1_3
end

function QWorldMiniMapBoardInfo.GetTag(arg_2_0)
	return arg_2_0.tag
end

function QWorldMiniMapBoardInfo.GetName(arg_3_0)
	if QWorldEntityMiniMapTag.Task == arg_3_0.tag then
		local var_3_0 = arg_3_0.param
		local var_3_1 = SandplayTaskCfg[var_3_0]
		local var_3_2 = var_3_1 and var_3_1.main_task_id

		return SandplayTaskMainCfg[var_3_2].title, SandplayTaskMainCfg[var_3_2].descrption
	elseif QWorldEntityMiniMapTag.Hud == arg_3_0.tag or QWorldEntityMiniMapTag.Thing == arg_3_0.tag then
		local var_3_3 = arg_3_0.param
		local var_3_4 = SandplayTagCfg[var_3_3]

		return var_3_4.tag_name, var_3_4.hud_desc
	else
		return arg_3_0.inst.display_name, arg_3_0.inst.thingCfg.map_desc
	end
end

function QWorldMiniMapBoardInfo.GetIcon(arg_4_0)
	return QWorldEntityMiniMap.GetIcon(arg_4_0.tag, arg_4_0.param)
end

function QWorldMiniMapBoardInfo.GetMainQuestId(arg_5_0)
	if QWorldEntityMiniMapTag.Task == arg_5_0.tag then
		local var_5_0 = arg_5_0.param
		local var_5_1 = SandplayTaskCfg[var_5_0]

		return var_5_1 and var_5_1.main_task_id or 0
	end

	return 0
end

function QWorldMiniMapBoardInfo.GetTeleportId(arg_6_0)
	if QWorldEntityMiniMapTag.Hud == arg_6_0.tag then
		return arg_6_0.inst:GetTeleportId()
	end

	return 0
end

function QWorldMiniMapBoardInfo.GetRewards(arg_7_0)
	if QWorldEntityMiniMapTag.Task == arg_7_0.tag then
		local var_7_0 = arg_7_0.param
		local var_7_1 = SandplayTaskCfg[var_7_0].main_task_id
		local var_7_2 = SandplayTaskMainCfg[var_7_1]

		if var_7_2 then
			return var_7_2.reward
		end
	elseif QWorldEntityMiniMapTag.Hud == arg_7_0.tag then
		local var_7_3 = arg_7_0.param
		local var_7_4 = SandplayTagCfg[var_7_3]

		if var_7_4.tag_behaviour == 4 then
			local var_7_5 = var_7_4.behaviour_parameters[1]
			local var_7_6 = var_7_5 and ActivityCfg[var_7_5]

			if var_7_6 and var_7_6.reward_show ~= "" then
				local var_7_7 = {}

				for iter_7_0, iter_7_1 in ipairs(var_7_6.reward_show) do
					table.insert(var_7_7, {
						iter_7_1
					})
				end

				return var_7_7
			end
		end
	end

	return {}
end

function QWorldMiniMapBoardInfo.CheckInShowRightList(arg_8_0)
	if QWorldEntityMiniMapTag.Task == arg_8_0.tag then
		return false
	elseif QWorldEntityMiniMapTag.Hud == arg_8_0.tag then
		local var_8_0 = arg_8_0.param

		return SandplayTagCfg[var_8_0].overview == 0
	elseif arg_8_0.inst.thingCfg then
		return arg_8_0.inst.thingCfg.overview == 0
	end

	return false
end

local var_0_0 = class("QWorldEntityMiniMap")

function var_0_0.GetIcon(arg_9_0, arg_9_1)
	local var_9_0 = "TextureConfig/SandPlay/MiniIcon/"
	local var_9_1 = "TextureConfig/SandPlay/BaseBoard/"

	if QWorldEntityMiniMapTag.Task == arg_9_0 then
		local var_9_2 = arg_9_1
		local var_9_3 = SandplayTaskCfg[var_9_2]
		local var_9_4 = var_9_3 and var_9_3.main_task_id
		local var_9_5 = SandplayTaskMainCfg[var_9_4]

		if QWorldQuestConst.QUEST_TASK_TYPE.MAIN == var_9_5.main_task_type then
			return var_9_0 .. "SandPlay_Questicon_Main", 2
		elseif QWorldQuestConst.QUEST_TASK_TYPE.SIDE == var_9_5.main_task_type then
			return var_9_0 .. "SandPlay_Questicon_Side", 3
		else
			return var_9_0 .. "SandPlay_Questicon_Explore", 4
		end
	elseif QWorldEntityMiniMapTag.Hud == arg_9_0 or QWorldEntityMiniMapTag.Thing == arg_9_0 then
		local var_9_6 = arg_9_1
		local var_9_7 = SandplayTagCfg[var_9_6]

		if var_9_7.baseboard and var_9_7.baseboard ~= "" then
			return var_9_0 .. var_9_7.map_icon, 1, var_9_1 .. var_9_7.baseboard
		elseif var_9_7.tag_behaviour == 1 then
			return var_9_0 .. var_9_7.map_icon, 5
		else
			return var_9_0 .. var_9_7.map_icon, 1
		end
	else
		return var_9_0 .. "SandPlay_icon_00001", 1
	end
end

function var_0_0.Ctor(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.inst = arg_10_1
	arg_10_0.unit = arg_10_1.entity:AddMiniMap()
	arg_10_0.tags = {}
	arg_10_0.hud = 0
	arg_10_0.thing = 0
	arg_10_0.taskList = {}
	arg_10_0.boardDict = {}
end

function var_0_0.GetBoardKey(arg_11_0, arg_11_1, arg_11_2)
	if QWorldEntityMiniMapTag.Task == arg_11_1 then
		return arg_11_2 * 10 + arg_11_1
	else
		return arg_11_1
	end
end

function var_0_0.AddMini(arg_12_0, arg_12_1, arg_12_2)
	if QWorldEntityMiniMapTag.Task == arg_12_1 then
		if not table.indexof(arg_12_0.taskList, arg_12_2) then
			table.insert(arg_12_0.taskList, arg_12_2)
		end
	elseif QWorldEntityMiniMapTag.Hud == arg_12_1 then
		arg_12_0.hud = arg_12_2

		local var_12_0 = SandplayTagCfg[arg_12_0.hud] and SandplayTagCfg[arg_12_0.hud].activityId

		if var_12_0 then
			local var_12_1 = ActivityTools.GetRedPointKey(var_12_0) .. var_12_0

			manager.redPoint:appendGroup(RedPointConst.QWORLD_MINI_MAP, var_12_1)
		end
	elseif QWorldEntityMiniMapTag.Thing == arg_12_1 then
		arg_12_0.thing = arg_12_2
	end

	if not table.indexof(arg_12_0.tags, arg_12_1) and arg_12_0:GetMapDisplay(arg_12_1) ~= 0 then
		table.insert(arg_12_0.tags, arg_12_1)
	end

	local var_12_2 = arg_12_0:GetBoardKey(arg_12_1, arg_12_2)

	if not arg_12_0.boardDict[var_12_2] and arg_12_0:GetMapDisplay(arg_12_1) ~= 0 then
		arg_12_0.boardDict[var_12_2] = QWorldMiniMapBoardInfo.New(arg_12_0.inst, arg_12_1, arg_12_2)
	end

	arg_12_0:UpdateDisplay()
end

function var_0_0.RemoveMini(arg_13_0, arg_13_1, arg_13_2)
	if QWorldEntityMiniMapTag.Task == arg_13_1 then
		local var_13_0 = table.indexof(arg_13_0.taskList, arg_13_2)

		if var_13_0 then
			table.remove(arg_13_0.taskList, var_13_0)
		end

		if #arg_13_0.taskList >= 0 then
			table.removebyvalue(arg_13_0.tags, arg_13_1)
		end
	elseif QWorldEntityMiniMapTag.Hud == arg_13_1 then
		local var_13_1 = SandplayTagCfg[arg_13_0.hud] and SandplayTagCfg[arg_13_0.hud].activityId

		if var_13_1 then
			local var_13_2 = ActivityTools.GetRedPointKey(var_13_1) .. var_13_1

			manager.redPoint:delGroup(RedPointConst.QWORLD_MINI_MAP, {
				var_13_2
			})
		end

		table.removebyvalue(arg_13_0.tags, arg_13_1)
	elseif QWorldEntityMiniMapTag.Thing == arg_13_1 then
		table.removebyvalue(arg_13_0.tags, arg_13_1)
	else
		table.removebyvalue(arg_13_0.tags, arg_13_1)
	end

	local var_13_3 = arg_13_0:GetBoardKey(arg_13_1, arg_13_2)

	if arg_13_0.boardDict[var_13_3] then
		arg_13_0.boardDict[var_13_3] = nil
	end

	if #arg_13_0.tags > 0 then
		arg_13_0:UpdateDisplay()

		return false
	else
		return true
	end
end

function var_0_0.UpdateDisplay(arg_14_0)
	local var_14_0 = arg_14_0.tags[#arg_14_0.tags]

	if var_14_0 == nil then
		return
	end

	local var_14_1

	if QWorldEntityMiniMapTag.Task == var_14_0 then
		var_14_1 = arg_14_0.taskList[1] or 0
	elseif QWorldEntityMiniMapTag.Hud == var_14_0 then
		var_14_1 = arg_14_0.hud
	elseif QWorldEntityMiniMapTag.Thing == var_14_0 then
		var_14_1 = arg_14_0.thing
	end

	local var_14_2, var_14_3, var_14_4 = var_0_0.GetIcon(var_14_0, var_14_1)

	arg_14_0.unit:SetIcon(var_14_2, var_14_3, var_14_4)

	local var_14_5 = arg_14_0:GetMapDisplay(var_14_0)

	arg_14_0.unit:SetMapDisplay(var_14_5)
end

function var_0_0.GetMapDisplay(arg_15_0, arg_15_1)
	if QWorldEntityMiniMapTag.Task == arg_15_1 then
		return 3
	elseif QWorldEntityMiniMapTag.Hud == arg_15_1 then
		local var_15_0 = arg_15_0.hud

		return SandplayTagCfg[var_15_0].map_display or 3
	elseif QWorldEntityMiniMapTag.Thing == arg_15_1 then
		local var_15_1 = arg_15_0.thing

		return SandplayTagCfg[var_15_1].map_display or 3
	elseif arg_15_0.inst.thingCfg then
		return arg_15_0.inst.thingCfg.map_display or 3
	else
		return 3
	end
end

function var_0_0.GetBoardDict(arg_16_0)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(arg_16_0.boardDict) do
		if iter_16_1:CheckInShowRightList() then
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function var_0_0.GetDefaultBoard(arg_17_0)
	local var_17_0

	for iter_17_0, iter_17_1 in pairs(arg_17_0.boardDict) do
		if not var_17_0 then
			var_17_0 = iter_17_1
		elseif iter_17_1.tag > var_17_0.tag then
			var_17_0 = iter_17_1
		end
	end

	return var_17_0
end

function var_0_0.SetSelect(arg_18_0, arg_18_1)
	if arg_18_0.unit then
		arg_18_0.unit:SetSelect(arg_18_1)
	end
end

function var_0_0.SetMiniType(arg_19_0, arg_19_1)
	if arg_19_0.unit then
		arg_19_0.unit:SetMiniType(arg_19_1)
	end
end

function var_0_0.Dispose(arg_20_0)
	arg_20_0.inst.entity:RemoveMiniMap()

	arg_20_0.tags = {}
end

return var_0_0
