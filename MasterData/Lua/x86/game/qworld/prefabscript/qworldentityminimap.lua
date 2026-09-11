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

function QWorldMiniMapBoardInfo:GetTag()
	return self.tag
end

function QWorldMiniMapBoardInfo:GetName()
	if QWorldEntityMiniMapTag.Task == self.tag then
		return SandplayTaskMainCfg[SandplayTaskCfg[self.param] and SandplayTaskCfg[self.param].main_task_id].title, SandplayTaskMainCfg[SandplayTaskCfg[self.param] and SandplayTaskCfg[self.param].main_task_id].descrption
	else
		if QWorldEntityMiniMapTag.Hud ~= self.tag then
			if QWorldEntityMiniMapTag.Thing == self.tag then
				do return SandplayTagCfg[self.param].tag_name, SandplayTagCfg[self.param].hud_desc end

				goto label_3_0
			end
		end

		return self.inst.display_name, self.inst.thingCfg.map_desc
	end

	::label_3_0::
end

function QWorldMiniMapBoardInfo:GetIcon()
	return QWorldEntityMiniMap.GetIcon(self.tag, self.param)
end

function QWorldMiniMapBoardInfo:GetMainQuestId()
	if QWorldEntityMiniMapTag.Task == self.tag then
		return (SandplayTaskCfg[self.param] or nil) and (SandplayTaskCfg[self.param].main_task_id or 0)
	end

	return 0
end

function QWorldMiniMapBoardInfo:GetTeleportId()
	if QWorldEntityMiniMapTag.Hud == self.tag then
		return self.inst:GetTeleportId()
	end

	return 0
end

function QWorldMiniMapBoardInfo:GetRewards()
	if QWorldEntityMiniMapTag.Task == self.tag then
		if SandplayTaskMainCfg[SandplayTaskCfg[self.param].main_task_id] then
			return SandplayTaskMainCfg[SandplayTaskCfg[self.param].main_task_id].reward
		end
	elseif QWorldEntityMiniMapTag.Hud == self.tag then
		if SandplayTagCfg[self.param].tag_behaviour == 4 then
			local var_7_0 = SandplayTagCfg[self.param].behaviour_parameters[1] and ActivityCfg[SandplayTagCfg[self.param].behaviour_parameters[1]]

			if SandplayTagCfg[self.param].behaviour_parameters[1] and ActivityCfg[SandplayTagCfg[self.param].behaviour_parameters[1]] and var_7_0.reward_show ~= "" then
				local var_7_1 = {}

				for iter_7_0, iter_7_1 in ipairs(var_7_0.reward_show) do
					table.insert(var_7_1, {
						iter_7_1
					})
				end

				return var_7_1
			end
		end
	end

	return {}
end

function QWorldMiniMapBoardInfo:CheckInShowRightList()
	if QWorldEntityMiniMapTag.Task == self.tag then
		return false
	elseif QWorldEntityMiniMapTag.Hud == self.tag then
		return SandplayTagCfg[self.param].overview == 0
	elseif self.inst.thingCfg then
		return self.inst.thingCfg.overview == 0
	end

	return false
end

local QWorldEntityMiniMap = class("QWorldEntityMiniMap")

function QWorldEntityMiniMap:GetIcon(arg_9_1)
	if QWorldEntityMiniMapTag.Task == self then
		if QWorldQuestConst.QUEST_TASK_TYPE.MAIN == SandplayTaskMainCfg[SandplayTaskCfg[arg_9_1] and SandplayTaskCfg[arg_9_1].main_task_id].main_task_type then
			return "TextureConfig/SandPlay/MiniIcon/" .. "SandPlay_Questicon_Main", 2
		elseif QWorldQuestConst.QUEST_TASK_TYPE.SIDE == SandplayTaskMainCfg[SandplayTaskCfg[arg_9_1] and SandplayTaskCfg[arg_9_1].main_task_id].main_task_type then
			return "TextureConfig/SandPlay/MiniIcon/" .. "SandPlay_Questicon_Side", 3
		else
			return "TextureConfig/SandPlay/MiniIcon/" .. "SandPlay_Questicon_Explore", 4
		end
	elseif QWorldEntityMiniMapTag.Hud == self or QWorldEntityMiniMapTag.Thing == self then
		local var_9_0 = SandplayTagCfg[arg_9_1]

		if SandplayTagCfg[arg_9_1].baseboard and var_9_0.baseboard ~= "" then
			return "TextureConfig/SandPlay/MiniIcon/" .. var_9_0.map_icon, 1, "TextureConfig/SandPlay/BaseBoard/" .. var_9_0.baseboard
		elseif var_9_0.tag_behaviour == 1 then
			return "TextureConfig/SandPlay/MiniIcon/" .. var_9_0.map_icon, 5
		else
			return "TextureConfig/SandPlay/MiniIcon/" .. var_9_0.map_icon, 1
		end
	else
		return "TextureConfig/SandPlay/MiniIcon/" .. "SandPlay_icon_00001", 1
	end
end

function QWorldEntityMiniMap:Ctor(arg_10_1, arg_10_2, arg_10_3)
	self.inst = arg_10_1
	self.unit = arg_10_1.entity:AddMiniMap()
	self.tags = {}
	self.hud = 0
	self.thing = 0
	self.taskList = {}
	self.boardDict = {}
end

function QWorldEntityMiniMap:GetBoardKey(arg_11_1, arg_11_2)
	if QWorldEntityMiniMapTag.Task == arg_11_1 then
		return arg_11_2 * 10 + arg_11_1
	else
		return arg_11_1
	end
end

function QWorldEntityMiniMap:AddMini(arg_12_1, arg_12_2)
	if QWorldEntityMiniMapTag.Task == arg_12_1 then
		if not table.indexof(self.taskList, arg_12_2) then
			table.insert(self.taskList, arg_12_2)
		end
	elseif QWorldEntityMiniMapTag.Hud == arg_12_1 then
		self.hud = arg_12_2

		local var_12_0 = SandplayTagCfg[self.hud] and SandplayTagCfg[self.hud].activityId

		if var_12_0 then
			manager.redPoint:appendGroup(RedPointConst.QWORLD_MINI_MAP, ActivityTools.GetRedPointKey(var_12_0) .. var_12_0)
		end
	elseif QWorldEntityMiniMapTag.Thing == arg_12_1 then
		self.thing = arg_12_2
	end

	if not table.indexof(self.tags, arg_12_1) and self:GetMapDisplay(arg_12_1) ~= 0 then
		table.insert(self.tags, arg_12_1)
	end

	local var_12_1 = self:GetBoardKey(arg_12_1, arg_12_2)

	if not self.boardDict[var_12_1] and self:GetMapDisplay(arg_12_1) ~= 0 then
		self.boardDict[var_12_1] = QWorldMiniMapBoardInfo.New(self.inst, arg_12_1, arg_12_2)
	end

	self:UpdateDisplay()
end

function QWorldEntityMiniMap:RemoveMini(arg_13_1, arg_13_2)
	if QWorldEntityMiniMapTag.Task == arg_13_1 then
		local var_13_0 = table.indexof(self.taskList, arg_13_2)

		if var_13_0 then
			table.remove(self.taskList, var_13_0)
		end

		if #self.taskList >= 0 then
			table.removebyvalue(self.tags, arg_13_1)
		end
	elseif QWorldEntityMiniMapTag.Hud == arg_13_1 then
		local var_13_1 = SandplayTagCfg[self.hud] and SandplayTagCfg[self.hud].activityId

		if var_13_1 then
			manager.redPoint:delGroup(RedPointConst.QWORLD_MINI_MAP, {
				ActivityTools.GetRedPointKey(var_13_1) .. var_13_1
			})
		end

		table.removebyvalue(self.tags, arg_13_1)
	elseif QWorldEntityMiniMapTag.Thing == arg_13_1 then
		table.removebyvalue(self.tags, arg_13_1)
	else
		table.removebyvalue(self.tags, arg_13_1)
	end

	local var_13_2 = self:GetBoardKey(arg_13_1, arg_13_2)

	if self.boardDict[var_13_2] then
		self.boardDict[var_13_2] = nil
	end

	if #self.tags > 0 then
		self:UpdateDisplay()

		return false
	else
		return true
	end
end

function QWorldEntityMiniMap:UpdateDisplay()
	local var_14_0 = self.tags[#self.tags]

	if self.tags[#self.tags] == nil then
		return
	end

	local var_14_1

	if QWorldEntityMiniMapTag.Task == var_14_0 then
		var_14_1 = self.taskList[1] or 0
	elseif QWorldEntityMiniMapTag.Hud == var_14_0 then
		var_14_1 = self.hud
	elseif QWorldEntityMiniMapTag.Thing == var_14_0 then
		var_14_1 = self.thing
	end

	local var_14_2, var_14_3, var_14_4 = QWorldEntityMiniMap.GetIcon(var_14_0, var_14_1)

	self.unit:SetIcon(var_14_2, var_14_3, var_14_4)
	self.unit:SetMapDisplay((self:GetMapDisplay(var_14_0)))
end

function QWorldEntityMiniMap:GetMapDisplay(arg_15_1)
	if QWorldEntityMiniMapTag.Task == arg_15_1 then
		return 3
	elseif QWorldEntityMiniMapTag.Hud == arg_15_1 then
		return SandplayTagCfg[self.hud].map_display or 3
	elseif QWorldEntityMiniMapTag.Thing == arg_15_1 then
		return SandplayTagCfg[self.thing].map_display or 3
	elseif self.inst.thingCfg then
		return self.inst.thingCfg.map_display or 3
	else
		return 3
	end
end

function QWorldEntityMiniMap:GetBoardDict()
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(self.boardDict) do
		if iter_16_1:CheckInShowRightList() then
			table.insert(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function QWorldEntityMiniMap:GetDefaultBoard()
	local var_17_0

	for iter_17_0, iter_17_1 in pairs(self.boardDict) do
		if not var_17_0 then
			var_17_0 = iter_17_1
		elseif iter_17_1.tag > var_17_0.tag then
			var_17_0 = iter_17_1
		end
	end

	return var_17_0
end

function QWorldEntityMiniMap:SetSelect(arg_18_1)
	if self.unit then
		self.unit:SetSelect(arg_18_1)
	end
end

function QWorldEntityMiniMap:SetMiniType(arg_19_1)
	if self.unit then
		self.unit:SetMiniType(arg_19_1)
	end
end

function QWorldEntityMiniMap:Dispose()
	self.inst.entity:RemoveMiniMap()

	self.tags = {}
end

return QWorldEntityMiniMap
