local IslandTaskTarget = class("IslandTaskTarget", import("model.vo.BaseVO"))

function IslandTaskTarget:Ctor(arg_1_1)
	self.id = arg_1_1.target_id
	self.configId = self.id
	self.progress = arg_1_1.target_count or 0

	return
end

function IslandTaskTarget:bindConfigTable()
	return pg.island_task_target
end

function IslandTaskTarget:GetName()
	return self:getConfig("name")
end

function IslandTaskTarget:GetType()
	return self:getConfig("type")
end

function IslandTaskTarget:GetTargetParam()
	return self:getConfig("target_param")
end

function IslandTaskTarget:GetTargetId()
	return self:getConfig("target_param")[1]
end

function IslandTaskTarget:GetTargetNum()
	return self:getConfig("target_num")
end

function IslandTaskTarget:GetTrackParma()
	return self:getConfig("tips")
end

function IslandTaskTarget:GetProgress()
	local var_9_0 = self:GetType()

	if var_9_0 == IslandTaskTargetType.TASK_DAILY_IN_WEEK then
		return self.progress + IslandTaskHelper.GetRuntimeData(var_9_0, self:GetTargetParam())
	end

	if table.contains(IslandTaskTargetType.GetRuntimeTypes(), var_9_0) then
		return IslandTaskHelper.GetRuntimeData(var_9_0, self:GetTargetParam())
	end

	return self.progress
end

function IslandTaskTarget:UpdateProgress(arg_10_1)
	self.progress = arg_10_1

	return
end

function IslandTaskTarget:IsFinish()
	return self:GetProgress() / self:GetTargetNum() >= 1
end

function IslandTaskTarget:CheckTypeAndTargetId(arg_12_1, arg_12_2)
	return self:GetType() == arg_12_1 and self:GetTargetId() == arg_12_2
end

return IslandTaskTarget
